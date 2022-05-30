import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class DefectScreen extends StatefulWidget {
  final ProductDTO product;

  const DefectScreen({Key? key, required this.product}) : super(key: key);

  @override
  _DefectScreenState createState() => _DefectScreenState();
}

class _DefectScreenState extends State<DefectScreen> {
  late ProductDTO productInfo;
  List<String> defectDetails = [
    "Не товарный вид",
    "Брак",
    "Излишка",
    "Недосдача",
    "Пересорт серий",
  ];

  @override
  void initState() {
    productInfo = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        padding: EdgeInsets.only(top: 30.0, right: 20, left: 20),
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
                            "${productInfo.totalCount ?? 0}",
                            style: ThemeTextStyle.textTitleDella40w400
                                .copyWith(color: ColorPalette.black),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0, right: 20, left: 20),
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
                            "${productInfo.defective ?? 0}",
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _BuildDefectiveDetail(
                  title: defectDetails[index],
                  onChanged: (index, isChecked) {},
                  showDivider: index != defectDetails.length - 1,
                );
              },
              itemCount: defectDetails.length,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0, top: 24),
              child: GestureDetector(
                onTap: () {},
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
  }
}

class _BuildDefectiveDetail extends StatefulWidget {
  final String title;
  final Function(int, bool) onChanged;
  final bool showDivider;

  const _BuildDefectiveDetail({
    Key? key,
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
                              });
                            },
                            child: Image.asset("assets/images/svg/minus.png")),
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
                                count++;
                              });
                            },
                            child: Image.asset("assets/images/svg/plus.png")),
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
        if(widget.showDivider)
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
