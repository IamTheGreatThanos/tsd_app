import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/common/signature/cubit/signature_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/cubit/pharmacy_arrival_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/pharmacy_arrival/ui/pharmacy_arrival_screen.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/defect_screen.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

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
  String _currentScan = '';
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    if (widget.isFromPharmacyPage) {
      BlocProvider.of<GoodsListScreenCubit>(context)
          .getPharmacyProducts(widget.pharmacyOrder!.id);
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
              scanResult,
              widget.isFromPharmacyPage
                  ? widget.pharmacyOrder!.id
                  : widget.warehouseOrder!.id,
              1,
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
          backgroundColor: ColorPalette.main,
          appBar: CustomAppBar(
            title: "Список товаров".toUpperCase(),
            showLogo: false,
          ),
          body: BlocConsumer<GoodsListScreenCubit, GoodsListScreenState>(
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
                  discrepancy,
                ) {
                  return _BuildBody(
                    orderId: widget.isFromPharmacyPage
                        ? widget.pharmacyOrder!.id
                        : widget.warehouseOrder!.id,
                    unscannedProducts: unscannedProducts,
                    scannedProducts: scannedProducts,
                    selectedProduct: selectedProduct,
                    discrepancy: discrepancy,
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
                loadedState: (
                  unscannedProducts,
                  scannedProducts,
                  selectedProductId,
                  discrepancy,
                ) {},
                errorState: (String message) {
                  buildErrorCustomSnackBar(context, message);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
  final int orderId;
  final ProductDTO selectedProduct;
  final List<ProductDTO> unscannedProducts;
  final List<ProductDTO> scannedProducts;
  final List<ProductDTO> discrepancy;
  const _BuildBody({
    Key? key,
    required this.orderId,
    required this.scannedProducts,
    required this.unscannedProducts,
    required this.selectedProduct,
    required this.discrepancy,
  }) : super(key: key);

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  int currentIndex = 0;
  @override
  void initState() {
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                    color: currentIndex == 2
                        ? ColorPalette.white
                        : ColorPalette.main,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Расхождение",
                        style: ThemeTextStyle.textStyle14w500.copyWith(
                          color: currentIndex == 2
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
                          "${widget.discrepancy.length}",
                          style: ThemeTextStyle.textStyle12w600.copyWith(
                            color: ColorPalette.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (currentIndex == 0)
          Expanded(
            flex: 12,
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.only(left: 12.5, right: 12.5, top: 20),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.unscannedProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppRouter.push(
                        context,
                        DefectScreen(
                          product: widget.unscannedProducts[index],
                          orderId: widget.orderId,
                        ),
                      );
                      // AppRouter.push(
                      //   context,
                      //   BlocProvider.value(
                      //     value: context.read<BlocGoodsList>(),
                      //     child: const BarcodeScannerScreen(),
                      //   ),
                      // );
                      // await FlutterBarcodeScanner.scanBarcode(
                      //     "F87615", "Cancel", false, ScanMode.BARCODE);
                      // FlutterBarcodeScanner.getBarcodeStreamReceiver("F87615", "Cancel", false, ScanMode.BARCODE);
                    },
                    child: _BuildGoodDetails(
                      orderID: widget.orderId,
                      good: widget.unscannedProducts[index],
                      selectedProduct: widget.selectedProduct,
                    ),
                  );
                },
              ),
            ),
          ),
        if (currentIndex == 1)
          widget.scannedProducts.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text("Отсканированных товаров нет"),
                  ),
                )
              : Expanded(
                  flex: 12,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        left: 12.5,
                        right: 12.5,
                        top: 20,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.scannedProducts.length,
                      itemBuilder: (context, index) {
                        return _BuildGoodDetails(
                          orderID: widget.orderId,
                          selectedProduct: const ProductDTO(id: -1),
                          good: widget.scannedProducts[index],
                        );
                      },
                    ),
                  ),
                ),
        if (currentIndex == 2)
          widget.discrepancy.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text("Нет несоответствий"),
                  ),
                )
              : Expanded(
                  flex: 12,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        left: 12.5,
                        right: 12.5,
                        top: 20,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.discrepancy.length,
                      itemBuilder: (context, index) {
                        return _BuildGoodDetails(
                          orderID: widget.orderId,
                          selectedProduct: const ProductDTO(id: -1),
                          good: widget.discrepancy[index],
                        );
                      },
                    ),
                  ),
                ),
        const Spacer(),
        if (widget.unscannedProducts.isEmpty)
          BlocListener<SignatureScreenCubit, SignatureScreenState>(
            listener: (context, state) {
              state.when(
                initialState: () {
                  context.loaderOverlay.hide();
                },
                loadingState: () {
                  context.loaderOverlay.show();
                },
                loadedState: () {
                  context.loaderOverlay.hide();
                  BlocProvider.of<PharmacyArrivalScreenCubit>(context)
                      .getOrders();

                  Navigator.pop(context);
                },
                errorState: (message) {
                  context.loaderOverlay.hide();
                  buildErrorCustomSnackBar(context, message);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 40,
                color: ColorPalette.orange,
                onPressed: () {
                  BlocProvider.of<SignatureScreenCubit>(context)
                      .updateOrderStatus(orderId: widget.orderId, status: 3);
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
          )
        else
          const SizedBox(),

        // IntrinsicHeight(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Заказ",
        //             style: ThemeTextStyle.textStyle14w600
        //                 .copyWith(color: ColorPalette.grayText),
        //           ),
        //           const SizedBox(
        //             height: 8,
        //           ),
        //           Text(
        //             NumberFormat.simpleCurrency(locale: 'kk', decimalDigits: 0)
        //                 .format(
        //               widget.totalPrice,
        //             ),
        //             style: ThemeTextStyle.textStyle24w400,
        //           ),
        //         ],
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.only(top: 21.0),
        //         child: VerticalDivider(
        //           color: ColorPalette.dashGrey,
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Поступление",
        //             style: ThemeTextStyle.textStyle14w600
        //                 .copyWith(color: ColorPalette.grayText),
        //           ),
        //           const SizedBox(
        //             height: 8,
        //           ),
        //           Text(
        //             NumberFormat.simpleCurrency(locale: 'kk', decimalDigits: 0)
        //                 .format(
        //               goods.totalScannedPrice,
        //             ),
        //             style: ThemeTextStyle.textStyle24w400,
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class _BuildGoodDetails extends StatefulWidget {
  final ProductDTO good;
  final ProductDTO selectedProduct;
  final int orderID;
  const _BuildGoodDetails({
    Key? key,
    required this.good,
    required this.selectedProduct,
    required this.orderID,
  }) : super(key: key);

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
          children: [
            Stack(
              children: [
                Image.network(
                  widget.good.image ?? 'null',
                  width: 104,
                  height: 104,
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.good.scanCount!}x",
                        style: ThemeTextStyle.textStyle14w400
                            .copyWith(color: ColorPalette.black),
                      ),
                      Text(
                        widget.good.barcode ?? 'null',
                        style: ThemeTextStyle.textStyle14w600
                            .copyWith(color: ColorPalette.grayText),
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
                  if (widget.good.id == widget.selectedProduct.id)
                    MaterialButton(
                      color: ColorPalette.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _bottomSheet(
                          _SpecifyingNumberManually(
                            productDTO: widget.good,
                            orderID: widget.orderID,
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Указать вручную',
                          style: TextStyle(
                            color: ColorPalette.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox()
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
  final ProductDTO productDTO;
  final int orderID;
  const _SpecifyingNumberManually({
    Key? key,
    required this.productDTO,
    required this.orderID,
  }) : super(key: key);

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
              'Укажите число вручную ',
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
                hintText: 'Укажите число вручную',
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
                  if (int.parse(controller.text) >
                      widget.productDTO.totalCount! -
                          widget.productDTO.scanCount!) {
                    Navigator.pop(context);
                    buildErrorCustomSnackBar(
                      context,
                      'Укажите правильную количеству',
                    );
                  } else {
                    BlocProvider.of<GoodsListScreenCubit>(context)
                        .scannerBarCode(
                      widget.productDTO.barcode!,
                      widget.orderID,
                      int.parse(controller.text),
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
