import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';

class SuccessfullySendScreen extends StatelessWidget {
  const SuccessfullySendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/png/successfully_send.png"),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Успешно\nотправлено!)".toUpperCase(),
              style: ThemeTextStyle.textTitleDella24w400
                  .copyWith(color: ColorPalette.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
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
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  "назад на главную страницу".toUpperCase(),
                  style: ThemeTextStyle.textStyle14w600
                      .copyWith(color: ColorPalette.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
