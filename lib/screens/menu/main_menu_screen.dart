import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.purpleLight,
      body: Stack(
        children: [
          Positioned(
              top: 85,
              left: 12,
              right: 12,
              child: Column(
                children: [
                  AppTextField(
                    hintText: "Искать по номеру заказа",
                    hintStyle: ThemeTextStyle.textStyle14w400
                        .copyWith(color: ColorPalette.white),
                    fillColor: ColorPalette.white.withOpacity(0.24),
                    prefixIcon: SvgPicture.asset(
                      "assets/images/svg/search.svg",
                    ),
                    contentPadding:
                        EdgeInsets.only(top: 17, bottom: 17, left: 13),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: ColorPalette.white.withOpacity(0.32),
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: ColorPalette.white.withOpacity(0.32),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: ColorPalette.white.withOpacity(0.32),
                        width: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Шевченко 90",
                        style: ThemeTextStyle.textStyle16w600,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        "assets/images/svg/chevrone_down.svg",
                        color: ColorPalette.black,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 30,
                            left: 60,
                            child: SvgPicture.asset(
                              "assets/images/svg/move_vector.svg",
                            )),
                        Positioned(
                            top: 84,
                            right: 26,
                            child: SvgPicture.asset(
                              "assets/images/svg/pharmacy_arrival_vector.svg",
                            )),
                        Positioned(
                            top: 154,
                            left: 33,
                            child: SvgPicture.asset(
                              "assets/images/svg/arrival_stock_vector.svg",
                            )),
                        Positioned(
                            top: 240,
                            right: 71,
                            child: SvgPicture.asset(
                              "assets/images/svg/return_vector.svg",
                            )),
                        Positioned(
                            top: 320,
                            left: 38,
                            child: SvgPicture.asset(
                              "assets/images/svg/order_history_vector.svg",
                            )),
                      ],
                    ),
                  ),
                ],
              )),
          Image.asset(
            "assets/images/png/noise.png",
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
