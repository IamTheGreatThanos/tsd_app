import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class GoodsListScreen extends StatefulWidget {
  @override
  State<GoodsListScreen> createState() => _GoodsListScreenState();
}

class _GoodsListScreenState extends State<GoodsListScreen> {
  @override
  void initState() {
    BlocProvider.of<GoodsListScreenCubit>(context).getProducts(1);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: Scaffold(
        backgroundColor: ColorPalette.main,
        appBar: CustomAppBar(
          title: "Список товаров".toUpperCase(),
          showLogo: false,
        ),
        body: BlocConsumer<GoodsListScreenCubit, GoodsListScreenState>(
          builder: (context, state) {
            return state.maybeWhen(
              loadedState: (scannedProducts,unscannedProducts) {
                return SingleChildScrollView(
                    child: _BuildBody(
                  unscannedProducts: unscannedProducts,
                  scannedProducts: scannedProducts,
                ));
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
              loadedState: (unscannedProducts, scannedProducts) {},
              errorState: (String message) {
                buildErrorCustomSnackBar(context, message);
              },
            );
          },
        ),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
  final List<ProductDTO> unscannedProducts;
  final List<ProductDTO> scannedProducts;

  const _BuildBody({
    Key? key,
    required this.scannedProducts,
    required this.unscannedProducts,
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
            ],
          ),
        ),
        if (currentIndex == 0)
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 12.5, right: 12.5, top: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.unscannedProducts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
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
                child: _BuildGoodDetails(good: widget.unscannedProducts[index]),
              );
            },
          ),
        if (currentIndex == 1)
          widget.scannedProducts.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text("Отсканированных товаров нет"),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.only(left: 12.5, right: 12.5, top: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.scannedProducts.length,
                  itemBuilder: (context, index) {
                    return _BuildGoodDetails(
                        good: widget.scannedProducts[index]);
                  },
                ),
        const SizedBox(
          height: 90,
        ),
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
          height: 90,
        ),
      ],
    );
  }
}

class _BuildGoodDetails extends StatelessWidget {
  final ProductDTO good;

  const _BuildGoodDetails({Key? key, required this.good}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorPalette.white,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Image.network(
                  good.image ?? 'null',
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
                      "${good.totalCount} шт.",
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
                        "${good.totalCount}x",
                        style: ThemeTextStyle.textStyle14w400
                            .copyWith(color: ColorPalette.black),
                      ),
                      Text(
                        good.barcode ?? 'null',
                        style: ThemeTextStyle.textStyle14w600
                            .copyWith(color: ColorPalette.grayText),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${good.name}',
                    overflow: TextOverflow.fade,
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${good.producer}",
                    style: ThemeTextStyle.textStyle14w400.copyWith(
                      color: ColorPalette.grayText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
