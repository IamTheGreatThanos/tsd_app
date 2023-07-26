import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/move_goods_screen_cubit.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

// TODO в папке common размещены страницы которые используется в нескольких местах
// TODO Defect Screen детальная страница брака
class DefectScreen extends StatefulWidget {
  final bool isFromPharmacyPage;
  final ProductDTO product;
  final TextEditingController searchController;
  final int orderId;
  const DefectScreen({
    super.key,
    required this.product,
    required this.orderId,
    required this.searchController,
    required this.isFromPharmacyPage,
  });

  @override
  _DefectScreenState createState() => _DefectScreenState();
}

class _DefectScreenState extends State<DefectScreen> {
  late ProductDTO productInfo;
  int defective = 0;
  int surplus = 0;
  int underachievement = 0;
  int reSorting = 0;
  int overdue = 0;
  int netovar = 0;
  int srok = 0;
  int allCount = 0;
  bool isAll = false;
  List<TextEditingController> defectControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<String> defectDetails = [
    "Брак",
    "Излишка",
    "Недосдача",
    "Пересорт серий",
    "Просрочен",
    "Нетоварный вид",
    "Неподходящий срок",
  ];

  @override
  void initState() {
    defective = widget.product.defective ?? 0;
    surplus = widget.product.surplus ?? 0;
    underachievement = widget.product.underachievement ?? 0;
    reSorting = widget.product.reSorting ?? 0;
    productInfo = widget.product;
    overdue = widget.product.overdue ?? 0;
    netovar = widget.product.netovar ?? 0;
    srok = widget.product.srok ?? 0;
    allCount =
        defective + underachievement + reSorting + overdue + netovar + srok;
    if (allCount == productInfo.totalCount! - productInfo.scanCount!) {
      isAll = true;
    } else {
      isAll = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLoaderOverlay(
      child: widget.isFromPharmacyPage
          ? BlocConsumer<GoodsListScreenCubit, GoodsListScreenState>(
              listener: (context, state) {
                state.when(
                  initialState: () {
                    context.loaderOverlay.hide();
                  },
                  loadingState: () {
                    context.loaderOverlay.show();
                  },
                  loadedState: (
                    scannedProducts,
                    unscannedProducts,
                    selectedProduct,
                  ) {
                    context.loaderOverlay.hide();
                    Navigator.pop(context);
                  },
                  successScannedState: (message) {},
                  errorState: (message) {
                    buildErrorCustomSnackBar(context, message);
                    context.loaderOverlay.hide();
                  },
                );
              },
              builder: (context, state) {
                return buildScaffold(context);
              },
            )
          : BlocConsumer<MoveGoodsScreenCubit, MoveGoodsScreenState>(
              listener: (context, state) {
                state.when(
                  initialState: () {
                    context.loaderOverlay.hide();
                  },
                  loadingState: () {
                    context.loaderOverlay.show();
                  },
                  loadedState: (
                    scannedProducts,
                    unscannedProducts,
                    selectedProduct,
                  ) {
                    context.loaderOverlay.hide();
                    Navigator.pop(context);
                  },
                  successScannedState: (message) {},
                  errorState: (message) {
                    buildErrorCustomSnackBar(context, message);
                    context.loaderOverlay.hide();
                  },
                );
              },
              builder: (context, state) {
                return buildScaffold(context);
              },
            ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: CustomAppBar(
        title: productInfo.barcode ?? 'No data',
        showLogo: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productInfo.name ?? "No data",
                          style: ThemeTextStyle.textTitleDella20w400
                              .copyWith(color: ColorPalette.black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          productInfo.producer ?? "No data",
                          style: ThemeTextStyle.textStyle14w400
                              .copyWith(color: ColorPalette.grayText),
                        ),
                      ],
                    ),
                  ),
                  // Image.network(
                  //   productInfo.image ?? "null",
                  //   width: 240,
                  //   height: 240,
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F6FB),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Количество",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${(productInfo.totalCount ?? 0) - underachievement}",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(color: ColorPalette.black),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 3,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorPalette.borderGrey,
                          ),
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //     right: 20,
                        //     left: 20,
                        //   ),
                        //   child: VerticalDivider(
                        //     color: ColorPalette.borderGrey,
                        //   ),
                        // ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Не отсканировано",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${productInfo.totalCount! - (productInfo.scanCount!)}",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(color: ColorPalette.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorPalette.borderGrey,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Просрочен",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$overdue",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(color: ColorPalette.black),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: 3,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorPalette.borderGrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Нетоварный вид",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$netovar",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(color: ColorPalette.black),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: 3,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorPalette.borderGrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Брак",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$defective",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(color: ColorPalette.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorPalette.borderGrey,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Излишек",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$surplus",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(color: ColorPalette.black),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: 3,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorPalette.borderGrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Пересорт серий",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$reSorting",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(color: ColorPalette.black),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: 3,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorPalette.borderGrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Недостача",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$underachievement",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(
                                  color: ColorPalette.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorPalette.borderGrey,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Неподходящий срок",
                                textAlign: TextAlign.center,
                                style: ThemeTextStyle.textStyle14w400
                                    .copyWith(color: ColorPalette.grayText),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$srok",
                                style: ThemeTextStyle.textTitleDella40w400
                                    .copyWith(
                                  color: ColorPalette.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _BuildDefectiveDetail(
                  textFieldController: defectControllers[4],
                  isAll: isAll,
                  title: defectDetails[4],
                  onChanged: (index, isChecked, isFromTextField) {
                    if (isChecked) {
                      overdue = index;
                      allCount = defective +
                          underachievement +
                          reSorting +
                          netovar +
                          overdue +
                          srok;
                      if (isFromTextField &&
                          overdue >
                              productInfo.totalCount! -
                                  productInfo.scanCount! -
                                  defective -
                                  underachievement -
                                  reSorting -
                                  netovar -
                                  srok) {
                        buildErrorCustomSnackBar(
                          context,
                          "Количество просроченных товаров не может превышать ${productInfo.totalCount! - productInfo.scanCount! - defective - underachievement - reSorting - netovar} шт",
                        );
                        defectControllers[4].text = (productInfo.totalCount! -
                                productInfo.scanCount! -
                                defective -
                                underachievement -
                                reSorting -
                                netovar -
                                srok)
                            .toString();
                        overdue = int.parse(defectControllers[4].text);
                        isAll = true;
                      } else {
                        if (allCount ==
                            productInfo.totalCount! - productInfo.scanCount!) {
                          isAll = true;
                        } else {
                          isAll = false;
                        }
                      }
                      setState(() {});
                    }
                  },
                  showDivider: 0 != defectDetails.length - 1,
                ),
                _BuildDefectiveDetail(
                  textFieldController: defectControllers[5],
                  isAll: isAll,
                  title: defectDetails[5],
                  onChanged: (index, isChecked, isFromTextField) {
                    if (isChecked) {
                      netovar = index;
                      allCount = defective +
                          underachievement +
                          reSorting +
                          overdue +
                          netovar +
                          srok;
                      if (isFromTextField &&
                          netovar >
                              productInfo.totalCount! -
                                  productInfo.scanCount! -
                                  defective -
                                  underachievement -
                                  reSorting -
                                  overdue -
                                  srok) {
                        buildErrorCustomSnackBar(
                          context,
                          "Количество товаров c неварным видом не может превышать ${productInfo.totalCount! - productInfo.scanCount! - defective - underachievement - reSorting - overdue} шт",
                        );
                        defectControllers[5].text = (productInfo.totalCount! -
                                productInfo.scanCount! -
                                defective -
                                underachievement -
                                reSorting -
                                overdue -
                                srok)
                            .toString();
                        netovar = int.parse(defectControllers[5].text);
                        isAll = true;
                      } else {
                        if (allCount ==
                            productInfo.totalCount! - productInfo.scanCount!) {
                          isAll = true;
                        } else {
                          isAll = false;
                        }
                      }
                      setState(() {});
                    }
                  },
                  showDivider: 0 != defectDetails.length - 1,
                ),
                _BuildDefectiveDetail(
                  textFieldController: defectControllers[0],
                  isAll: isAll,
                  title: defectDetails[0],
                  onChanged: (index, isChecked, isFromTextField) {
                    if (isChecked) {
                      defective = index;
                      allCount = defective +
                          underachievement +
                          reSorting +
                          overdue +
                          netovar +
                          srok;
                      if (isFromTextField &&
                          defective >
                              productInfo.totalCount! -
                                  productInfo.scanCount! -
                                  underachievement -
                                  reSorting -
                                  overdue -
                                  netovar -
                                  srok) {
                        buildErrorCustomSnackBar(
                          context,
                          "Количество браков не может превышать ${productInfo.totalCount! - productInfo.scanCount! - underachievement - reSorting - overdue - netovar} шт",
                        );
                        defectControllers[0].text = (productInfo.totalCount! -
                                productInfo.scanCount! -
                                underachievement -
                                reSorting -
                                overdue -
                                netovar -
                                srok)
                            .toString();
                        defective = int.parse(defectControllers[0].text);
                        isAll = true;
                      } else {
                        if (allCount ==
                            productInfo.totalCount! - productInfo.scanCount!) {
                          isAll = true;
                        } else {
                          isAll = false;
                        }
                      }
                      setState(() {});
                    }
                  },
                  showDivider: 0 != defectDetails.length - 1,
                ),
                _BuildDefectiveDetail(
                  textFieldController: defectControllers[1],
                  isAll: false,
                  title: defectDetails[1],
                  onChanged: (productInfo.scanCount! +
                              defective +
                              underachievement +
                              overdue +
                              netovar +
                              reSorting ==
                          productInfo.totalCount)
                      ? (index, isChecked, isFromTextField) {
                          if (isChecked) {
                            surplus = index;

                            setState(() {});
                          }
                        }
                      : null,
                  showDivider: 1 != defectDetails.length - 1,
                ),
                _BuildDefectiveDetail(
                  textFieldController: defectControllers[2],
                  isAll: isAll,
                  title: defectDetails[2],
                  onChanged: (index, isChecked, isFromTextField) {
                    if (isChecked) {
                      underachievement = index;
                      allCount = defective +
                          underachievement +
                          reSorting +
                          overdue +
                          netovar +
                          srok;
                      if (isFromTextField &&
                          underachievement >
                              productInfo.totalCount! -
                                  productInfo.scanCount! -
                                  defective -
                                  reSorting -
                                  overdue -
                                  netovar -
                                  srok) {
                        buildErrorCustomSnackBar(
                          context,
                          "Количество недостач не может превышать ${productInfo.totalCount! - productInfo.scanCount! - defective - reSorting - overdue - netovar} шт",
                        );
                        defectControllers[2].text = (productInfo.totalCount! -
                                productInfo.scanCount! -
                                defective -
                                reSorting -
                                overdue -
                                netovar -
                                srok)
                            .toString();
                        underachievement = int.parse(defectControllers[2].text);
                        isAll = true;
                      } else {
                        if (allCount ==
                            productInfo.totalCount! - productInfo.scanCount!) {
                          isAll = true;
                        } else {
                          isAll = false;
                        }
                      }
                      setState(() {});
                    }
                  },
                  showDivider: 2 != defectDetails.length - 1,
                ),
                _BuildDefectiveDetail(
                  textFieldController: defectControllers[3],
                  isAll: isAll,
                  title: defectDetails[3],
                  onChanged: (index, isChecked, isFromTextField) {
                    if (isChecked) {
                      reSorting = index;
                      allCount = defective +
                          underachievement +
                          reSorting +
                          overdue +
                          netovar +
                          srok;
                      if (isFromTextField &&
                          reSorting >
                              productInfo.totalCount! -
                                  productInfo.scanCount! -
                                  defective -
                                  underachievement -
                                  overdue -
                                  netovar -
                                  srok) {
                        buildErrorCustomSnackBar(
                          context,
                          "Количество паспорт серий не может превышать ${productInfo.totalCount! - productInfo.scanCount! - defective - underachievement - overdue - netovar} шт",
                        );
                        defectControllers[3].text = (productInfo.totalCount! -
                                productInfo.scanCount! -
                                underachievement -
                                defective -
                                overdue -
                                netovar -
                                srok)
                            .toString();
                        reSorting = int.parse(defectControllers[3].text);
                        isAll = true;
                      } else {
                        if (allCount ==
                            productInfo.totalCount! - productInfo.scanCount!) {
                          isAll = true;
                        } else {
                          isAll = false;
                        }
                      }
                      setState(() {});
                    }
                  },
                  showDivider: 3 != defectDetails.length - 1,
                ),
                _BuildDefectiveDetail(
                  textFieldController: defectControllers[6],
                  isAll: isAll,
                  title: defectDetails[6],
                  onChanged: (index, isChecked, isFromTextField) {
                    if (isChecked) {
                      srok = index;
                      allCount = defective +
                          underachievement +
                          reSorting +
                          overdue +
                          netovar +
                          srok;
                      if (isFromTextField &&
                          reSorting >
                              productInfo.totalCount! -
                                  productInfo.scanCount! -
                                  defective -
                                  underachievement -
                                  overdue -
                                  netovar -
                                  srok) {
                        buildErrorCustomSnackBar(
                          context,
                          "Количество паспорт серий не может превышать ${productInfo.totalCount! - productInfo.scanCount! - defective - underachievement - overdue - netovar - srok} шт",
                        );
                        defectControllers[6].text = (productInfo.totalCount! -
                                productInfo.scanCount! -
                                underachievement -
                                defective -
                                overdue -
                                netovar -
                                srok)
                            .toString();
                        srok = int.parse(defectControllers[6].text);
                        isAll = true;
                      } else {
                        if (allCount ==
                            productInfo.totalCount! - productInfo.scanCount!) {
                          isAll = true;
                        } else {
                          isAll = false;
                        }
                      }
                      setState(() {});
                    }
                  },
                  showDivider: 3 != defectDetails.length - 1,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
                top: 24,
              ),
              child: GestureDetector(
                onTap: () async {
                  if (widget.isFromPharmacyPage) {
                    BlocProvider.of<GoodsListScreenCubit>(context)
                        .changeToLoadingState();
                    BlocProvider.of<GoodsListScreenCubit>(context)
                        .updatePharmacyProductById(
                      search: widget.searchController.text.isNotEmpty
                          ? widget.searchController.text
                          : null,
                      orderId: widget.orderId,
                      productId: productInfo.id,
                      //    scanCount: productInfo.scanCount,
                      defective: defective,
                      surplus: surplus,
                      underachievement: underachievement,
                      reSorting: reSorting,
                      overdue: overdue,
                      netovar: netovar,
                      srok: srok,
                    );
                  } else {
                    BlocProvider.of<MoveGoodsScreenCubit>(context)
                        .changeToLoadingState();
                    BlocProvider.of<MoveGoodsScreenCubit>(context)
                        .updateMoveProductById(
                      search: widget.searchController.text.isNotEmpty
                          ? widget.searchController.text
                          : null,
                      orderId: widget.orderId,
                      productDTO: productInfo.copyWith(
                        defective: defective,
                        surplus: surplus,
                        underachievement: underachievement,
                        reSorting: reSorting,
                        overdue: overdue,
                        netovar: netovar,
                      ),
                      //    scanCount: productInfo.scanCount,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: ColorPalette.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      "Отправить",
                      style: ThemeTextStyle.textStyle14w600
                          .copyWith(color: ColorPalette.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildDefectiveDetail extends StatefulWidget {
  final String title;
  final Function(int, bool, bool)? onChanged;
  final bool showDivider;
  final bool isAll;
  final TextEditingController textFieldController;
  const _BuildDefectiveDetail({
    required this.isAll,
    required this.title,
    required this.onChanged,
    required this.showDivider,
    required this.textFieldController,
  });

  @override
  _BuildDefectiveDetailState createState() => _BuildDefectiveDetailState();
}

class _BuildDefectiveDetailState extends State<_BuildDefectiveDetail> {
  bool checked = false;
  //int count = 0;
  @override
  void initState() {
    super.initState();
    widget.textFieldController.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: ThemeTextStyle.textStyle14w600,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  if (checked && widget.onChanged != null)
                    Expanded(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (int.parse(widget.textFieldController.text) >
                                    0) {
                                  if (int.parse(
                                        widget.textFieldController.text,
                                      ) ==
                                      1) {
                                    widget.textFieldController.text = "0";
                                  } else {
                                    int count = int.parse(
                                      widget.textFieldController.text,
                                    );
                                    count--;
                                    widget.textFieldController.text =
                                        count.toString();
                                  }
                                }
                                widget.onChanged!(
                                  int.parse(widget.textFieldController.text),
                                  checked,
                                  false,
                                );
                                // if (count > 0) count--;
                                // widget.onChanged!(count, checked);
                              });
                            },
                            child: Image.asset(
                              "assets/images/svg/minus.png",
                            ),
                          ),
                          SizedBox(
                            width: 51,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: widget.textFieldController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                hintText:
                                    int.parse(widget.textFieldController.text)
                                        .toString(),
                                hintStyle: ThemeTextStyle.textStyle18w400
                                    .copyWith(color: ColorPalette.black),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                // if (value == '') {
                                //   count = 0;
                                // } else {
                                //   count = int.parse(value);
                                // }

                                widget.onChanged!(
                                  int.parse(widget.textFieldController.text),
                                  checked,
                                  true,
                                );
                                setState(() {});
                              },
                              style: ThemeTextStyle.textStyle18w400
                                  .copyWith(color: ColorPalette.black),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!widget.isAll) {
                                  int count = int.parse(
                                    widget.textFieldController.text,
                                  );
                                  count++;
                                  widget.textFieldController.text =
                                      count.toString();
                                  widget.onChanged!(count, checked, false);
                                }
                              });
                            },
                            child: Image.asset("assets/images/svg/plus.png"),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: widget.onChanged != null
                    ? () {
                        setState(() {
                          checked = !checked;
                        });
                      }
                    : () {
                        buildErrorCustomSnackBar(
                          context,
                          'Сначала отсканируйте все товары',
                        );
                      },
                child: Image.asset(
                  "assets/images/svg/checkbox_${(!checked || widget.onChanged == null) ? "un" : ""}checked.png",
                ),
              ),
            ),
          ],
        ),
        if (widget.showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(
              color: ColorPalette.borderGrey,
            ),
          ),
      ],
    );
  }
}
