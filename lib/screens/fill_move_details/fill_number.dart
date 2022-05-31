import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_move_data.dart';
import 'package:pharmacy_arrival/screens/move_data_scanned/bloc/bloc_move_data.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';

class FillNumberScreen extends StatefulWidget {
  final DTOMoveData moveData;
  final int index;

  const FillNumberScreen({
    Key? key,
    required this.moveData,
    required this.index,
  }) : super(key: key);

  @override
  _FillNumberScreenState createState() => _FillNumberScreenState();
}

class _FillNumberScreenState extends State<FillNumberScreen> {
  late final DTOMoveData productInfo;
  TextEditingController numberController = TextEditingController();
  int count = 0;

  @override
  void initState() {
    productInfo = widget.moveData;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
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
                      errorBuilder: (_, child, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 29,
                  bottom: 48,
                  right: 29,
                ),
                child: Column(
                  children: [
                    Text(
                      "Количество",
                      style: ThemeTextStyle.textStyle14w600
                          .copyWith(color: ColorPalette.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (count > 0) count--;
                            });
                          },
                          child: Image.asset(
                            "assets/images/svg/minus.png",
                            width: 48,
                            height: 48,
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Text(
                          "$count",
                          style: ThemeTextStyle.textStyle48w300
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
                          child: Image.asset(
                            "assets/images/svg/plus.png",
                            width: 48,
                            height: 48,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppTextField(
                showErrorMessages: false,
                hintText: "№ Серии",
                controller: numberController,
                fillColor: ColorPalette.background,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0,
                  top: 24,
                ),
                child: GestureDetector(
                  onTap: () {
                    context.read<BlocMoveData>().add(
                          EventChangeMoveData(
                            index: widget.index,
                            count: count,
                            number: numberController.text,
                          ),
                        );
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: numberController.text.isNotEmpty
                          ? ColorPalette.orange
                          : ColorPalette.orangeInactive,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "Завершить",
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
      ),
    );
  }
}
