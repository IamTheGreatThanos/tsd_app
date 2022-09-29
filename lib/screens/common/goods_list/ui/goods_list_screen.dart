import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/ui/goods_barcode_screen.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/ui/widgets/build_pharmacy_good_datail.dart';
import 'package:pharmacy_arrival/screens/common/ui/fill_invoice_screen.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_alert_dialog.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/defect_screen.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodsListScreen extends StatefulWidget {
  final bool isFromPharmacyPage;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;

  const GoodsListScreen({
    Key? key,
    required this.isFromPharmacyPage,
    this.pharmacyOrder,
    this.warehouseOrder,
  }) : super(key: key);

  @override
  State<GoodsListScreen> createState() => _GoodsListScreenState();
}

class _GoodsListScreenState extends State<GoodsListScreen> {
  final ScrollController _controller = ScrollController();

  void _animateToIndex(int index, double height) {
    _controller.animateTo(
      index * height,
      duration: const Duration(seconds: 2),
      curve: Curves.linear,
    );
  }

  bool isFloatingButtonVisible = true;
  String _currentScan = '';
  FocusNode focusNode = FocusNode();

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    if (widget.isFromPharmacyPage) {
      BlocProvider.of<GoodsListScreenCubit>(context).getPharmacyProducts(
        orderId: widget.pharmacyOrder!.id,
      );
    } else {}
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
              if (i % 2 == 0) {
                scanResult += _currentScan[i];
              }
            }

            scanResult = scanResult.replaceAll(' ', '').toLowerCase();
            setState(() {
              _currentScan = '';
            });
            BlocProvider.of<GoodsListScreenCubit>(context).scannerBarCode(
              scannedResult: scanResult,
              orderId: widget.isFromPharmacyPage
                  ? widget.pharmacyOrder!.id
                  : widget.warehouseOrder!.id,
              search: searchController.text.isNotEmpty
                  ? searchController.text
                  : null,
              quantity: 1,
              scanType: 0,
            );
          }
        },
        child: Scaffold(
          floatingActionButton:
              BlocBuilder<GoodsListScreenCubit, GoodsListScreenState>(
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
                            GoodsBarcodeScreen(
                              isFromPharmacyPage: true,
                              searchController: searchController,
                              orderId: widget.isFromPharmacyPage
                                  ? widget.pharmacyOrder!.id
                                  : widget.warehouseOrder!.id,
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
            actions: [
              IconButton(
                onPressed: () {
                  buildAlertDialog(context);
                },
                icon: const Icon(
                  Icons.document_scanner_rounded,
                  color: Colors.black,
                ),
              )
            ],
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
                        orderId: widget.isFromPharmacyPage
                            ? widget.pharmacyOrder!.id
                            : widget.warehouseOrder!.id,
                        search: value,
                      );
                    } else {
                      productCubit.getPharmacyProducts(
                        orderId: widget.isFromPharmacyPage
                            ? widget.pharmacyOrder!.id
                            : widget.warehouseOrder!.id,
                      );
                    }
                  },
                  onChanged: (String? text) {
                    final productCubit =
                        BlocProvider.of<GoodsListScreenCubit>(context);

                    if (text != null) {
                      productCubit.getPharmacyProducts(
                        orderId: widget.isFromPharmacyPage
                            ? widget.pharmacyOrder!.id
                            : widget.warehouseOrder!.id,
                        search: text,
                      );
                    }
                    if (text == null || text.isEmpty) {
                      productCubit.getPharmacyProducts(
                        orderId: widget.isFromPharmacyPage
                            ? widget.pharmacyOrder!.id
                            : widget.warehouseOrder!.id,
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
                    color: ColorPalette.grey400,
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
                          orderStatus: widget.isFromPharmacyPage
                              ? widget.pharmacyOrder?.status ?? 0
                              : widget.warehouseOrder?.status ?? 0,
                          orderId: widget.isFromPharmacyPage
                              ? widget.pharmacyOrder!.id
                              : widget.warehouseOrder!.id,
                          unscannedProducts: unscannedProducts,
                          scannedProducts: scannedProducts,
                          selectedProduct: selectedProduct,
                          pharmacyOrder: widget.pharmacyOrder,
                          warehouseOrder: widget.warehouseOrder,
                          isFromPharmacyPage: widget.isFromPharmacyPage,
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
                                i, MediaQuery.of(context).size.height * 0.4);
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
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  final bool isFromPharmacyPage;
  const _BuildBody({
    Key? key,
    required this.orderId,
    required this.scannedProducts,
    required this.unscannedProducts,
    required this.selectedProduct,
    required this.orderStatus,
    this.pharmacyOrder,
    this.warehouseOrder,
    required this.isFromPharmacyPage,
    required this.searchController,
    required this.scrollController,
  }) : super(key: key);

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
              BlocProvider.of<GoodsListScreenCubit>(context)
                  .getPharmacyProducts(orderId: widget.orderId);
            },
            controller: controller,
            child: itemCount == 0
                ? widget.orderStatus == 3
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
                                isFromPharmacyPage: true,
                                searchController: widget.searchController,
                                product: widget.unscannedProducts[index],
                                orderId: widget.orderId,
                              ),
                            );
                          }
                        },
                        child: BuildPharmacyGoodDetails(
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
            widget.orderStatus != 3 &&
            widget.searchController.text.isEmpty)
          Padding(
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
                AppRouter.push(
                  context,
                  FillInvoiceScreen(
                    isFromPharmacyPage: widget.isFromPharmacyPage,
                    pharmacyOrder: widget.pharmacyOrder,
                    warehouseOrder: widget.warehouseOrder,
                  ),
                );
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
      ],
    );
  }
}
