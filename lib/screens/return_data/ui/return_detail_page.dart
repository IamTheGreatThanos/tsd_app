import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/ui/goods_barcode_screen.dart';
import 'package:pharmacy_arrival/screens/history/history_cubit.dart/history_cubit.dart';
import 'package:pharmacy_arrival/screens/return_data/return_cubit/return_order_page_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/custom_button.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReturnDetailPage extends StatefulWidget {
  final PharmacyOrderDTO? pharmacyOrder;
  const ReturnDetailPage({super.key, this.pharmacyOrder});

  @override
  State<ReturnDetailPage> createState() => _ReturnDetailPageState();
}

class _ReturnDetailPageState extends State<ReturnDetailPage> {
  final ScrollController _controller = ScrollController();

  void _animateToIndex(int index, double height) {
    _controller.animateTo(
      index * height,
      duration: const Duration(seconds: 2),
      curve: Curves.linear,
    );
  }

  FocusNode focusNode = FocusNode();
  String _currentScan = '';
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<GoodsListScreenCubit>(context)
        .getPharmacyProducts(orderId: widget.pharmacyOrder!.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKey: widget.pharmacyOrder?.refundStatus == 2
            ? null
            : (event) async {
                if (event.logicalKey.keyLabel != 'Enter') {
                  _currentScan += event.logicalKey.keyLabel;
                } else if (_currentScan.isNotEmpty) {
                  _currentScan = _currentScan.replaceAll('Shift Left', '');
                  log('Current Scan: $_currentScan');
                  var scanResult = '';
                  for (var i = 0; i < _currentScan.length; i++) {
                    if (i.isEven) {
                      scanResult += _currentScan[i];
                    }
                  }

                  scanResult = scanResult.replaceAll(' ', '').toLowerCase();
                  setState(() {
                    _currentScan = '';
                  });
                  BlocProvider.of<GoodsListScreenCubit>(context)
                      .refundScannerBarCode(
                    scanResult,
                    widget.pharmacyOrder!.id,
                    searchController.text.isNotEmpty
                        ? searchController.text
                        : null,
                    1,
                    0,
                  );
                }
              },
        child: Scaffold(
          floatingActionButton: widget.pharmacyOrder?.refundStatus == 2
              ? null
              : BlocConsumer<HistoryCubit, HistoryState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {
                        context.loaderOverlay.hide();
                      },
                      initialState: () {
                        context.loaderOverlay.hide();
                      },
                      loadingState: () {
                        context.loaderOverlay.show();
                      },
                      refundHistoryFinishedState: () {
                        context.loaderOverlay.hide();
                        BlocProvider.of<ReturnOrderPageCubit>(context)
                            .onRefreshOrders(refundStatus: 1);
                        Navigator.pop(context);
                      },
                      errorState: (String message) {
                        buildErrorCustomSnackBar(context, message);
                      },
                    );
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: FloatingActionButton(
                              child: Image.asset(
                                'assets/images/png/scan_floating.png',
                              ),
                              onPressed: () {
                                AppRouter.push(
                                  context,
                                  GoodsBarcodeScreen(
                                    isFromPharmacyPage: false,
                                    searchController: searchController,
                                    orderId: widget.pharmacyOrder!.id,
                                  ),
                                );
                              },
                            ),
                          ),
                          CustomButton(
                            height: 44,
                            onClick: () {
                              BlocProvider.of<HistoryCubit>(context)
                                  .updatePharmacyOrderStatus(
                                isFromHisPage: false,
                                orderId: widget.pharmacyOrder!.id,
                                refundStatus: 2,
                              );
                            },
                            body: const Text(
                              'Завершить возврата',
                              style: TextStyle(),
                            ),
                            style: pinkButtonStyle(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          backgroundColor: ColorPalette.main,
          appBar: CustomAppBar(
            title: "Список товаров".toUpperCase(),
            
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextField(
                  focusNode: FocusNode(),
                  onFieldSubmitted: (value) {
                    final productCubit =
                        BlocProvider.of<GoodsListScreenCubit>(context);

                    if (value.isNotEmpty) {
                      productCubit.getPharmacyProducts(
                        orderId: widget.pharmacyOrder!.id,
                        search: value,
                      );
                    } else {
                      productCubit.getPharmacyProducts(
                        orderId: widget.pharmacyOrder!.id,
                      );
                    }
                  },
                  onChanged: (String? text) {
                    final productCubit =
                        BlocProvider.of<GoodsListScreenCubit>(context);

                    if (text != null) {
                      productCubit.getPharmacyProducts(
                        orderId: widget.pharmacyOrder!.id,
                        search: text,
                      );
                    }
                    if (text == null || text.isEmpty) {
                      productCubit.getPharmacyProducts(
                        orderId: widget.pharmacyOrder!.id,
                      );
                    }
                  },
                  controller: searchController,
                  hintText: "Введите имя продукта",
                  hintStyle: ThemeTextStyle.textStyle14w400
                      .copyWith(color: ColorPalette.grey400),
                  fillColor: ColorPalette.white,
                  prefixIcon: SvgPicture.asset(
                    "assets/images/svg/search.svg",
                    colorFilter: const ColorFilter.mode(
                        ColorPalette.grey400, BlendMode.srcIn,),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 17,
                    bottom: 17,
                    left: 13,
                  ),
                ),
              ),
              Expanded(
                child: BlocConsumer<GoodsListScreenCubit, GoodsListScreenState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loadingState: () {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        );
                      },
                      loadedState: (
                        scannedProducts,
                        unscannedProducts,
                        selectedProduct,
                      ) {
                        return _BuildBody(
                          scrollController: _controller,
                          searchController: searchController,
                          orderStatus: widget.pharmacyOrder?.status ?? 0,
                          orderId: widget.pharmacyOrder!.id,
                          scannedProducts: scannedProducts,
                          selectedProduct: selectedProduct,
                          pharmacyOrder: widget.pharmacyOrder,
                        );
                      },
                      errorState: (String message) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                color: Colors.red,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                message,
                                style: const TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        );
                      },
                      orElse: () {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      },
                    );
                  },
                  listener: (context, state) {
                    state.when(
                      initialState: () {},
                      loadingState: () {},
                      successScannedState: (String message) {
                        buildSuccessCustomSnackBar(context, message);
                      },
                      loadedState: (
                        scannedProducts,
                        unscannedProducts,
                        selectedProductId,
                      ) {
                        for (int i = 0; i < scannedProducts.length; i++) {
                          if (scannedProducts[i].id == selectedProductId.id) {
                            _animateToIndex(
                              i,
                              MediaQuery.of(context).size.height * 0.5,
                            );
                          }
                        }
                      },
                      errorState: (String message) {
                        buildErrorCustomSnackBar(context, message);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
  final ScrollController scrollController;
  final TextEditingController searchController;
  final int orderStatus;
  final int orderId;
  final ProductDTO selectedProduct;
  final List<ProductDTO> scannedProducts;
  final PharmacyOrderDTO? pharmacyOrder;
  const _BuildBody({
    required this.orderId,
    required this.scannedProducts,
    required this.selectedProduct,
    required this.orderStatus,
    this.pharmacyOrder,
    required this.searchController,
    required this.scrollController,
  });

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  RefreshController controller = RefreshController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  "Продукты",
                  style: ThemeTextStyle.textStyle14w500
                      .copyWith(color: ColorPalette.grayText),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: ColorPalette.borderGrey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "${widget.scannedProducts.length}",
                    style: ThemeTextStyle.textStyle12w600.copyWith(
                      color: ColorPalette.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SmartRefresher(
            onRefresh: () {
              BlocProvider.of<GoodsListScreenCubit>(context)
                  .getPharmacyProducts(orderId: widget.orderId);
            },
            controller: controller,
            child: ListView.builder(
              controller: widget.scrollController,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 12.5, right: 12.5, top: 20),
              itemCount: widget.scannedProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // if (currentIndex == 0) {
                    //   AppRouter.push(
                    //     context,
                    //     DefectScreen(
                    //       product: widget.unscannedProducts[index],
                    //       orderId: widget.orderId,
                    //     ),
                    //   );
                    // }
                  },
                  child: _BuildGoodDetails(
                    pharmacyOrderDTO: widget.pharmacyOrder,
                    searchController: widget.searchController,
                    orderID: widget.orderId,
                    good: widget.scannedProducts[index],
                    selectedProduct: widget.selectedProduct,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildGoodDetails extends StatefulWidget {
  final TextEditingController searchController;
  final ProductDTO good;
  final ProductDTO selectedProduct;
  final int orderID;
  final PharmacyOrderDTO? pharmacyOrderDTO;
  const _BuildGoodDetails({
    required this.good,
    required this.selectedProduct,
    required this.orderID,
    required this.searchController,
    required this.pharmacyOrderDTO,
  });

  @override
  State<_BuildGoodDetails> createState() => _BuildGoodDetailsState();
}

class _BuildGoodDetailsState extends State<_BuildGoodDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.good.id == widget.selectedProduct.id
              ? const Color.fromARGB(255, 183, 244, 215)
              : ColorPalette.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.good.image ??
                      'https://teelindy.com/wp-content/uploads/2019/03/default_image.png',
                  width: 104,
                  height: 104,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/png/not_found.png',
                      width: 104,
                      height: 104,
                    );
                  },
                ),
                Positioned(
                  bottom: 8,
                  left: 24,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorPalette.white,
                      border: Border.all(
                        color: ColorPalette.red,
                      ),
                    ),
                    child: Text(
                      "${widget.good.totalCount} шт.",
                      style: ThemeTextStyle.textStyle12w600.copyWith(
                        color: ColorPalette.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.good.refund != 0
                          ? ColorPalette.lightGreen
                          : ColorPalette.lightYellow,
                      border: Border.all(
                        color: widget.good.refund != 0
                            ? ColorPalette.borderGreen
                            : ColorPalette.borderYellow,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Center(
                      child: Text(
                        widget.good.refund != 0
                            ? "Подтвержден"
                            : "Не подтвержден",
                        style: ThemeTextStyle.textStyle12w600.copyWith(
                          color: widget.good.refund != 0
                              ? ColorPalette.textGreen
                              : ColorPalette.textYellow,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.good.scanCount!}x",
                        style: ThemeTextStyle.textStyle14w400
                            .copyWith(color: ColorPalette.black),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          widget.good.barcode ?? 'null',
                          style: ThemeTextStyle.textStyle14w600
                              .copyWith(color: ColorPalette.grayText),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.good.name}',
                    overflow: TextOverflow.fade,
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.good.producer}",
                    style: ThemeTextStyle.textStyle14w400.copyWith(
                      color: ColorPalette.grayText,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      if (widget.good.refund != widget.good.totalCount! &&
                          widget.pharmacyOrderDTO?.refundStatus != 2)
                        MaterialButton(
                          color: ColorPalette.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _bottomSheet(
                              _SpecifyingNumberManually(
                                searchController: widget.searchController,
                                productDTO: widget.good,
                                orderID: widget.orderID,
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Ввести количество возравта',
                              style: TextStyle(
                                color: ColorPalette.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Кол-во:   ${widget.good.totalCount}'.toUpperCase()),
                      Text('Скан:   ${widget.good.scanCount}'.toUpperCase()),
                      Text('Просрочен:   ${widget.good.overdue}'.toUpperCase()),
                      Text(
                        'Нетоварный вид:   ${widget.good.netovar}'
                            .toUpperCase(),
                      ),
                      Text('Брак:   ${widget.good.defective}'.toUpperCase()),
                      Text('Излишка:   ${widget.good.surplus}'.toUpperCase()),
                      Text(
                        'Недостача:   ${widget.good.underachievement}'
                            .toUpperCase(),
                      ),
                      Text(
                        'Пересорт серий:   ${widget.good.reSorting}'
                            .toUpperCase(),
                      ),
                      Text(
                        'Возврат:   ${widget.good.refund}'.toUpperCase(),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _bottomSheet(Widget widget) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      enableDrag: true,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return widget;
      },
    );
  }
}

class _SpecifyingNumberManually extends StatefulWidget {
  final TextEditingController searchController;
  final ProductDTO productDTO;
  final int orderID;
  const _SpecifyingNumberManually({
    required this.productDTO,
    required this.orderID,
    required this.searchController,
  });

  @override
  State<_SpecifyingNumberManually> createState() =>
      _SpecifyingNumberManuallyState();
}

class _SpecifyingNumberManuallyState extends State<_SpecifyingNumberManually> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    controller.clear();
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(
                top: 14,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffD9DBE9),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Укажите количество вручную ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            TextField(
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Укажите количество вручную',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: ColorPalette.orange,
              disabledColor: ColorPalette.orangeInactive,
              padding: EdgeInsets.zero,
              onPressed: () {
                if (controller.text.isEmpty) {
                  Navigator.pop(context);
                } else {
                  if (0 >= int.parse(controller.text) ||
                      int.parse(controller.text) >
                          widget.productDTO.totalCount! -
                              (widget.productDTO.refund ?? 0)) {
                    Navigator.pop(context);
                    buildErrorCustomSnackBar(
                      context,
                      'Укажите правильную количеству',
                    );
                  } else {
                    BlocProvider.of<GoodsListScreenCubit>(
                      context,
                    ).refundScannerBarCode(
                      widget.productDTO.barcode!,
                      widget.orderID,
                      widget.searchController.text.isNotEmpty
                          ? widget.searchController.text
                          : null,
                      int.parse(controller.text),
                      1,
                    );

                    controller.clear();
                    focusNode.dispose();
                    Navigator.pop(context);
                  }
                }
              },
              child: Center(
                child: Text(
                  "Отправить",
                  style: ThemeTextStyle.textStyle14w600
                      .copyWith(color: ColorPalette.white),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
