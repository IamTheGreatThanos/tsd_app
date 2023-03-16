import 'package:flutter/material.dart';

import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';

///Main text button
class MainTextButton extends StatelessWidget {
  ///Button title
  final String title;

  ///Bool for disable button if required
  final bool isButtonEnabled;

  ///Callback, that invoke when press on button
  final VoidCallback onPressed;

  ///Depends on font size of button text
  final bool isCentered;

  const MainTextButton({
    super.key,
    this.isButtonEnabled = true,
    required this.title,
    required this.onPressed,
    this.isCentered = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: isCenteredButton(),
      ),
    );
  }

  TextStyle isCenteredButton() {
    if (isCentered) {
      return ThemeTextStyle.textStyle16w400.copyWith(
        color: isButtonEnabled
            ? ColorPalette.black
            : ColorPalette.gray.withOpacity(0.25),);
    } else {
      return ThemeTextStyle.textStyle14w400.copyWith(
        color: isButtonEnabled
            ? ColorPalette.main
            : ColorPalette.gray.withOpacity(0.25),);
    }
  }

}
