import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/core/utils/app_router.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/common/defect_screen.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/move_goods_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/ui/move_goods_barcode_screen.dart';
import 'package:pharmacy_arrival/screens/goods_list/ui/widgets/build_move_goods_detail.dart';
import 'package:pharmacy_arrival/screens/move_data/move_products_cubit/move_products_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoveGoodsListScreen extends StatefulWidget {
  final MoveDataDTO moveDataDTO;
  const MoveGoodsListScreen({super.key, required this.moveDataDTO});

  @override
  State<MoveGoodsListScreen> createState() => _MoveGoodsListScreenState();
}

class _MoveGoodsListScreenState extends State<MoveGoodsListScreen> {
  bool isFloatingButtonVisible = true;
  String _currentScan = '';
  FocusNode focusNode = FocusNode();
  final ScrollController _controller = ScrollController();

  void _animateToIndex(int index, double height) {
    _controller.animateTo(
      index * height,
      duration: const Duration(seconds: 2),
      curve: Curves.linear,
    );
  }

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<MoveGoodsScreenCubit>(context).getMoveProducts(
      orderId: widget.moveDataDTO.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKey: (event) async {
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
            BlocProvider.of<MoveGoodsScreenCubit>(context).scannerBarCode(
              scannedResult: scanResult,
              orderId: widget.moveDataDTO.id,
              search: searchController.text.isNotEmpty
                  ? searchController.text
                  : null,
              quantity: 1,
              scanType: 0,
            );

            // if (scannedCellId.isEmpty) {
            //   scanCellBarCode(scanResult);
            //   ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
            //     SnackBar(
            //       content: Text(
            //         scanResult,
            //         textAlign: TextAlign.center,
            //         style: TextStyle(color: Colors.white),
            //       ),
            //       backgroundColor: Color.fromRGBO(
            //         46,
            //         164,
            //         78,
            //         1,
            //       ),
            //     ),
            //   );
            //   return;
            // }
          }
        },
        child: Scaffold(
          floatingActionButton:
              BlocBuilder<MoveGoodsScreenCubit, MoveGoodsScreenState>(
            builder: (context, state) {
              return state.maybeWhen(
                loadedState: (
                  scannedProducts,
                  unscannedProducts,
                  selectedProductId,
                ) {
                  if (unscannedProducts.isNotEmpty) {
                    return SizedBox(
                      height: 80,
                      width: 80,
                      child: FloatingActionButton(
                        child: Image.asset(
                          'assets/images/png/scan_floating.png',
                        ),
                        onPressed: () {
                          AppRouter.push(
                            context,
                            MoveGoodsBarcodeScreen(
                              searchController: searchController,
                              orderId: widget.moveDataDTO.id,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
                orElse: () {
                  return const SizedBox();
                },
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
                        BlocProvider.of<MoveGoodsScreenCubit>(context);

                    if (value.isNotEmpty) {
                      productCubit.getMoveProducts(
                        orderId: widget.moveDataDTO.id,
                        search: value,
                      );
                    } else {
                      productCubit.getMoveProducts(
                        orderId: widget.moveDataDTO.id,
                      );
                    }
                  },
                  onChanged: (String? text) {
                    final productCubit =
                        BlocProvider.of<MoveGoodsScreenCubit>(context);

                    if (text != null) {
                      productCubit.getMoveProducts(
                        orderId: widget.moveDataDTO.id,
                        search: text,
                      );
                    }
                    if (text == null || text.isEmpty) {
                      productCubit.getMoveProducts(
                        orderId: widget.moveDataDTO.id,
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
                      ColorPalette.grey400,
                      BlendMode.srcIn,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 17,
                    bottom: 17,
                    left: 13,
                  ),
                ),
              ),
              Expanded(
                child: BlocConsumer<MoveGoodsScreenCubit, MoveGoodsScreenState>(
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
                          orderStatus: widget.moveDataDTO.accept!,
                          orderId: widget.moveDataDTO.id,
                          unscannedProducts: unscannedProducts,
                          scannedProducts: scannedProducts,
                          selectedProduct: selectedProduct,
                          moveDataDTO: widget.moveDataDTO,
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
                        for (int i = 0; i < unscannedProducts.length; i++) {
                          if (unscannedProducts[i].id == selectedProductId.id) {
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
  final List<ProductDTO> unscannedProducts;
  final List<ProductDTO> scannedProducts;
  final MoveDataDTO moveDataDTO;
  const _BuildBody({
    required this.orderId,
    required this.scannedProducts,
    required this.unscannedProducts,
    required this.selectedProduct,
    required this.orderStatus,
    required this.moveDataDTO,
    required this.searchController,
    required this.scrollController,
  });

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  int currentIndex = 0;
  RefreshController controller = RefreshController();
  int itemCount = 0;
  @override
  void initState() {
    itemCount = widget.unscannedProducts.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.5),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                    itemCount = widget.unscannedProducts.length;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                    color: currentIndex == 0
                        ? ColorPalette.white
                        : ColorPalette.main,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Не отсканированные",
                        style: ThemeTextStyle.textStyle14w500.copyWith(
                          color: currentIndex == 0
                              ? ColorPalette.grayText
                              : ColorPalette.grayTextDisabled,
                        ),
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
                          "${widget.unscannedProducts.length}",
                          style: ThemeTextStyle.textStyle12w600.copyWith(
                            color: ColorPalette.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                    itemCount = widget.scannedProducts.length;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                    color: currentIndex == 1
                        ? ColorPalette.white
                        : ColorPalette.main,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Отсканированные",
                        style: ThemeTextStyle.textStyle14w500.copyWith(
                          color: currentIndex == 1
                              ? ColorPalette.grayText
                              : ColorPalette.grayTextDisabled,
                        ),
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
              const SizedBox(
                width: 25,
              ),
            ],
          ),
        ),
        Expanded(
          child: SmartRefresher(
            onRefresh: () {
              BlocProvider.of<MoveGoodsScreenCubit>(context)
                  .getMoveProducts(orderId: widget.orderId);
            },
            controller: controller,
            child: itemCount == 0
                ? widget.orderStatus == 1
                    ? ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 100,
                                  vertical: 16,
                                ),
                                child: Image.asset(
                                  'assets/images/png/done_icon.png',
                                ),
                              ),
                              Text(
                                'Завершенный заказ!'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Center(
                            child:
                                Lottie.asset('assets/lotties/empty_box.json'),
                          ),
                        ],
                      )
                : ListView.builder(
                    controller: widget.scrollController,
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(left: 12.5, right: 12.5, top: 20),
                    itemCount: currentIndex == 0
                        ? widget.unscannedProducts.length
                        : widget.scannedProducts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (currentIndex == 0) {
                            AppRouter.push(
                              context,
                              DefectScreen(
                                isFromPharmacyPage: false,
                                searchController: widget.searchController,
                                product: widget.unscannedProducts[index],
                                orderId: widget.orderId,
                              ),
                            );
                          }
                        },
                        child: BuildMoveGoodsDetail(
                          searchController: widget.searchController,
                          currentIndex: currentIndex,
                          orderID: widget.orderId,
                          good: currentIndex == 0
                              ? widget.unscannedProducts[index]
                              : widget.scannedProducts[index],
                          selectedProduct: widget.selectedProduct,
                        ),
                      );
                    },
                  ),
          ),
        ),
        if (widget.unscannedProducts.isEmpty &&
            widget.orderStatus != 2 &&
            widget.searchController.text.isEmpty)
          BlocListener<MoveProductsScreenCubit, MoveProductsScreenState>(
            listener: (context, state) {
              state.when(
                initialState: () {
                  context.loaderOverlay.hide();
                },
                loadingState: () {
                  context.loaderOverlay.show();
                },
                loadedState: (list, isFinishable) {
                  context.loaderOverlay.hide();
                },
                finishedState: () {
                  BlocProvider.of<MoveProductsScreenCubit>(
                    context,
                  ).getProducts(
                    moveOrderId: widget.orderId,
                  );
                  Navigator.pop(context);
                  context.loaderOverlay.hide();
                },
                errorState: (String message) {
                  context.loaderOverlay.hide();
                  buildErrorCustomSnackBar(context, message);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 20,
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 40,
                color: ColorPalette.orange,
                onPressed: () {
                  BlocProvider.of<MoveProductsScreenCubit>(
                    context,
                  ).updateMovingOrderStatus(
                    moveOrderId: widget.orderId,
                    status: 2,
                    accept: 1,
                  );
                  // AppRouter.push(
                  //   context,
                  //   FillInvoiceScreen(
                  //     isFromPharmacyPage: widget.isFromPharmacyPage,
                  //     pharmacyOrder: widget.pharmacyOrder,
                  //     warehouseOrder: widget.warehouseOrder,
                  //   ),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      "Завершить".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
