import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/screens/move_data/ui/_vmodel.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class MoveDataScreen extends StatefulWidget {
  const MoveDataScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MoveDataScreen> createState() => _MoveDataScreenState();
}

class _MoveDataScreenState extends State<MoveDataScreen> {
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MoveDataVModel _vmodel = context.read<MoveDataVModel>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Перемещение".toUpperCase()),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Отправитель",
                          style: ThemeTextStyle.textStyle14w400.copyWith(
                            color: ColorPalette.grey400,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(child: _vmodel.sender)
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Divider(
                        color: ColorPalette.borderGrey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Получатель",
                          style: ThemeTextStyle.textStyle14w400.copyWith(
                            color: ColorPalette.grey400,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(child: _vmodel.recipient)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Организация",
                      style: ThemeTextStyle.textStyle14w400.copyWith(
                        color: ColorPalette.grey400,
                      ),
                    ),
                    Flexible(child: _vmodel.organization),
                    SvgPicture.asset("assets/images/svg/chevron_right.svg"),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Вид перемещения",
                      style: ThemeTextStyle.textStyle14w400.copyWith(
                        color: ColorPalette.grey400,
                      ),
                    ),
                    Flexible(child: _vmodel.moveType),
                    SvgPicture.asset("assets/images/svg/chevron_right.svg"),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF87615),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: const Color(0xFFd86814)),
                    ),
                    child: SvgPicture.asset("assets/images/svg/move_plus.svg"),
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
