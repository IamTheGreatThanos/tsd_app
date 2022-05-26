import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/screens/barcode_scanner/barcode_scanner_screen.dart';
import 'package:pharmacy_arrival/screens/goods_list/bloc/bloc_goods_list.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';

import '../../../widgets/custom_app_bar.dart';

class GoodsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocGoodsList()..add(EventInitialGoodsList()),
      child: AppLoaderOverlay(
        child: Scaffold(
          backgroundColor: ColorPalette.main,
          appBar: CustomAppBar(
            title: "Список товаров".toUpperCase(),
            showLogo: false,
          ),
          body: SingleChildScrollView(
            child: BlocConsumer<BlocGoodsList, StateBlocGoodsList>(
              builder: (context, state) {
                if (state is StateGoodsListLoadData) {
                  return _BuildBody(goodsResponse: state.goodsResponse);
                }
                return const SizedBox.shrink();
              },
              listener: (context, state) {
                if (state is StateGoodsListLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
              },
              buildWhen: (p, c) => c is! StateGoodsListLoading,
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
  final GoodsResponse goodsResponse;

  const _BuildBody({Key? key, required this.goodsResponse}) : super(key: key);

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  int currentIndex = 0;
  late GoodsResponse goods;

  @override
  void initState() {
    goods = widget.goodsResponse;
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
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          "146",
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
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          "146",
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
        ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
                left: 12.5, right: 12.5, top: 20, bottom: 50),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: goods.goods.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    AppRouter.push(context, BarcodeScannerScreen());
                    // await FlutterBarcodeScanner.scanBarcode(
                    //     "F87615", "Cancel", false, ScanMode.BARCODE);
                    // FlutterBarcodeScanner.getBarcodeStreamReceiver("F87615", "Cancel", false, ScanMode.BARCODE);
                  },
                  child: _BuildGoodDetails(good: goods.goods[index]));
            }),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Заказ",
                    style: ThemeTextStyle.textStyle14w600
                        .copyWith(color: ColorPalette.grayText),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    NumberFormat.simpleCurrency(locale: 'kk', decimalDigits: 0)
                        .format(
                      goods.price,
                    ),
                    style: ThemeTextStyle.textStyle24w400,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 21.0),
                child: VerticalDivider(
                  color: ColorPalette.dashGrey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Поступление",
                    style: ThemeTextStyle.textStyle14w600
                        .copyWith(color: ColorPalette.grayText),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    NumberFormat.simpleCurrency(locale: 'kk', decimalDigits: 0)
                        .format(
                      56000,
                    ),
                    style: ThemeTextStyle.textStyle24w400,
                  ),
                ],
              ),
            ],
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       NumberFormat.simpleCurrency(
        //               locale: 'kk', decimalDigits: 0)
        //           .format(
        //         goods.price,
        //       ),
        //       style: ThemeTextStyle.textStyle24w400,
        //     ),
        //     VerticalDivider(
        //       color: ColorPalette.dashGrey,
        //     ),
        //     Text(
        //       NumberFormat.simpleCurrency(
        //               locale: 'kk', decimalDigits: 0)
        //           .format(
        //         56000,
        //       ),
        //       style: ThemeTextStyle.textStyle24w400,
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 90,
        ),
      ],
    );
  }
}

class _BuildGoodDetails extends StatelessWidget {
  final GoodDetails good;

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
                Image.asset(
                  good.image,
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
                        )),
                    child: Text("${good.count} шт.",
                        style: ThemeTextStyle.textStyle12w600.copyWith(
                          color: ColorPalette.red,
                        )),
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
                        "${good.count}x",
                        style: ThemeTextStyle.textStyle14w400
                            .copyWith(color: ColorPalette.black),
                      ),
                      Text(
                        good.number,
                        style: ThemeTextStyle.textStyle14w600
                            .copyWith(color: ColorPalette.grayText),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    good.title,
                    overflow: TextOverflow.fade,
                    style: ThemeTextStyle.textStyle20w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    good.company,
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
