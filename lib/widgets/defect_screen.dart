import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/screens/goods_list/cubit/goods_list_screen_cubit.dart';
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
              discrepancy,
            ) {
              context.loaderOverlay.hide();
              Navigator.pop(context);
            },
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
                                  "${productInfo.totalCount! - productInfo.scanCount! ?? 0}",
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
                        isAll: isAll,
                        title: defectDetails[0],
                        onChanged: (index, isChecked) {
                          if (isChecked) {
                            defective = index;
                            allCount = defective +
                                surplus +
                                underachievement +
                                reSorting;
                            if (allCount ==
                                productInfo.totalCount! -
                                    productInfo.scanCount!) {
                              isAll = true;
                            } else {
                              isAll = false;
                            }
                            setState(() {});
                          }
                        },
                        showDivider: 0 != defectDetails.length - 1,
                      ),
                      _BuildDefectiveDetail(
                        isAll: isAll,
                        title: defectDetails[1],
                        onChanged: (index, isChecked) {
                          if (isChecked) {
                            surplus = index;
                            allCount = defective +
                                surplus +
                                underachievement +
                                reSorting;
                            if (allCount ==
                                productInfo.totalCount! -
                                    productInfo.scanCount!) {
                              isAll = true;
                            } else {
                              isAll = false;
                            }
                            setState(() {});
                          }
                        },
                        showDivider: 1 != defectDetails.length - 1,
                      ),
                      _BuildDefectiveDetail(
                        isAll: isAll,
                        title: defectDetails[2],
                        onChanged: (index, isChecked) {
                          if (isChecked) {
                            underachievement = index;
                            allCount = defective +
                                surplus +
                                underachievement +
                                reSorting;
                            if (allCount ==
                                productInfo.totalCount! -
                                    productInfo.scanCount!) {
                              isAll = true;
                            } else {
                              isAll = false;
                            }
                            setState(() {});
                          }
                        },
                        showDivider: 2 != defectDetails.length - 1,
                      ),
                      _BuildDefectiveDetail(
                        isAll: isAll,
                        title: defectDetails[3],
                        onChanged: (index, isChecked) {
                          if (isChecked) {
                            reSorting = index;
                            allCount = defective +
                                surplus +
                                underachievement +
                                reSorting;
                            if (allCount ==
                                productInfo.totalCount! -
                                    productInfo.scanCount!) {
                              isAll = true;
                            } else {
                              isAll = false;
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
                        if (isAll) {
                          BlocProvider.of<GoodsListScreenCubit>(context).changeToLoadingState();
                          BlocProvider.of<GoodsListScreenCubit>(context)
                              .updatePharmacyProductById(
                            orderId: widget.orderId,
                            productId: productInfo.id,
                            scanCount: productInfo.scanCount,
                            status: "2",
                            defective: defective,
                            surplus: surplus,
                            underachievement: underachievement,
                            reSorting: reSorting,
                          );
                        } else {
                          buildErrorCustomSnackBar(
                            context,
                            'Выберите все товары!!!',
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
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
  final Function(int, bool) onChanged;
  final bool showDivider;
  final bool isAll;
  const _BuildDefectiveDetail({
    Key? key,
    required this.isAll,
    required this.title,
    required this.onChanged,
    required this.showDivider,
  }) : super(key: key);

  @override
  _BuildDefectiveDetailState createState() => _BuildDefectiveDetailState();
}

class _BuildDefectiveDetailState extends State<_BuildDefectiveDetail> {
  bool checked = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                  if (checked)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (count > 0) count--;
                              widget.onChanged(count, checked);
                            });
                          },
                          child: Image.asset("assets/images/svg/minus.png"),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Text(
                          "$count",
                          style: ThemeTextStyle.textStyle18w400
                              .copyWith(color: ColorPalette.black),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (!widget.isAll) {
                                count++;
                                widget.onChanged(count, checked);
                              }
                            });
                          },
                          child: Image.asset("assets/images/svg/plus.png"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  checked = !checked;
                });
              },
              child: Image.asset(
                "assets/images/svg/checkbox_${!checked ? "un" : ""}checked.png",
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
