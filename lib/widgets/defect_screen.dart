import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/common/goods_list/cubit/goods_list_screen_cubit.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/app_loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/snackbar/custom_snackbars.dart';

class DefectScreen extends StatefulWidget {
  final ProductDTO product;
  final int orderId;
  const DefectScreen({
    Key? key,
    required this.product,
    required this.orderId,
  }) : super(key: key);

  @override
  _DefectScreenState createState() => _DefectScreenState();
}

class _DefectScreenState extends State<DefectScreen> {
  late ProductDTO productInfo;
  int defective = 0;
  int surplus = 0;
  int underachievement = 0;
  int reSorting = 0;
  int allCount = 0;
  bool isAll = false;
  List<TextEditingController> defectControllers = [
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
  ];

  @override
  void initState() {
    defective = widget.product.defective ?? 0;
    surplus = widget.product.surplus ?? 0;
    underachievement = widget.product.underachievement ?? 0;
    reSorting = widget.product.reSorting ?? 0;
    productInfo = widget.product;
    allCount = defective + underachievement + reSorting;
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
      child: BlocConsumer<GoodsListScreenCubit, GoodsListScreenState>(
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
                        Image.network(
                          productInfo.image ?? "null",
                          width: 240,
                          height: 240,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  IntrinsicHeight(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F6FB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Количество",
                                  style: ThemeTextStyle.textStyle14w400
                                      .copyWith(color: ColorPalette.grayText),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${productInfo.totalCount ?? 0}",
                                  style: ThemeTextStyle.textTitleDella40w400
                                      .copyWith(color: ColorPalette.black),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 30.0,
                                right: 20,
                                left: 20,
                              ),
                              child: VerticalDivider(
                                color: ColorPalette.borderGrey,
                                thickness: 1.5,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Не отсканировано:",
                                  style: ThemeTextStyle.textStyle14w400
                                      .copyWith(color: ColorPalette.grayText),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${productInfo.totalCount! - (productInfo.scanCount!)}",
                                  style: ThemeTextStyle.textTitleDella40w400
                                      .copyWith(color: ColorPalette.black),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 30.0,
                                right: 20,
                                left: 20,
                              ),
                              child: VerticalDivider(
                                color: ColorPalette.borderGrey,
                                thickness: 1.5,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Брак",
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
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 30.0,
                                right: 20,
                                left: 20,
                              ),
                              child: VerticalDivider(
                                color: ColorPalette.borderGrey,
                                thickness: 1.5,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Излишек",
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
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 30.0,
                                right: 20,
                                left: 20,
                              ),
                              child: VerticalDivider(
                                color: ColorPalette.borderGrey,
                                thickness: 1.5,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Недостача",
                                  style: ThemeTextStyle.textStyle14w400
                                      .copyWith(color: ColorPalette.grayText),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "$underachievement",
                                  style: ThemeTextStyle.textTitleDella40w400
                                      .copyWith(color: ColorPalette.black),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 30.0,
                                right: 20,
                                left: 20,
                              ),
                              child: VerticalDivider(
                                color: ColorPalette.borderGrey,
                                thickness: 1.5,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Пересорт серий",
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
                          ],
                        ),
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
                        textFieldController: defectControllers[0],
                        isAll: isAll,
                        title: defectDetails[0],
                        onChanged: (index, isChecked, isFromTextField) {
                          if (isChecked) {
                            defective = index;
                            allCount = defective + underachievement + reSorting;
                            if (isFromTextField &&
                                defective >
                                    productInfo.totalCount! -
                                        productInfo.scanCount! -
                                        underachievement -
                                        reSorting) {
                              buildErrorCustomSnackBar(
                                context,
                                "Количество браков не может превышать ${productInfo.totalCount! - productInfo.scanCount! - underachievement - reSorting} шт",
                              );
                              defectControllers[0].text =
                                  (productInfo.totalCount! -
                                          productInfo.scanCount! -
                                          underachievement -
                                          reSorting)
                                      .toString();
                              defective = int.parse(defectControllers[0].text);
                              isAll = true;
                            } else {
                              if (allCount ==
                                  productInfo.totalCount! -
                                      productInfo.scanCount!) {
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
                            allCount = defective + underachievement + reSorting;
                            if (isFromTextField &&
                                underachievement >
                                    productInfo.totalCount! -
                                        productInfo.scanCount! -
                                        defective -
                                        reSorting) {
                              buildErrorCustomSnackBar(
                                context,
                                "Количество недостач не может превышать ${productInfo.totalCount! - productInfo.scanCount! - defective - reSorting} шт",
                              );
                              defectControllers[2].text =
                                  (productInfo.totalCount! -
                                          productInfo.scanCount! -
                                          defective -
                                          reSorting)
                                      .toString();
                              underachievement =
                                  int.parse(defectControllers[2].text);
                              isAll = true;
                            } else {
                              if (allCount ==
                                  productInfo.totalCount! -
                                      productInfo.scanCount!) {
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
                            allCount = defective + underachievement + reSorting;
                            if (isFromTextField &&
                                reSorting >
                                    productInfo.totalCount! -
                                        productInfo.scanCount! -
                                        defective -
                                        underachievement) {
                              buildErrorCustomSnackBar(
                                context,
                                "Количество паспорт серий не может превышать ${productInfo.totalCount! - productInfo.scanCount! - defective - underachievement} шт",
                              );
                              defectControllers[3].text =
                                  (productInfo.totalCount! -
                                          productInfo.scanCount! -
                                          underachievement -
                                          defective)
                                      .toString();
                              reSorting = int.parse(defectControllers[3].text);
                              isAll = true;
                            } else {
                              if (allCount ==
                                  productInfo.totalCount! -
                                      productInfo.scanCount!) {
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
                        BlocProvider.of<GoodsListScreenCubit>(context)
                            .changeToLoadingState();
                        BlocProvider.of<GoodsListScreenCubit>(context)
                            .updatePharmacyProductById(
                          orderId: widget.orderId,
                          productId: productInfo.id,
                          //    scanCount: productInfo.scanCount,
                          defective: defective,
                          surplus: surplus,
                          underachievement: underachievement,
                          reSorting: reSorting,
                        );
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
        },
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
    Key? key,
    required this.isAll,
    required this.title,
    required this.onChanged,
    required this.showDivider,
    required this.textFieldController,
  }) : super(key: key);

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
