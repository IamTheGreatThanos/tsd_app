import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/dialogs/main_dialog_container.dart';
import 'package:pharmacy_arrival/widgets/main_button/main_button.dart';



class OneButtonDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonTitle;
  final String? iconAsset;
  final VoidCallback buttonHandler;

  const OneButtonDialog(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.buttonTitle,
      required this.buttonHandler,
      this.iconAsset,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainDialogContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: ThemeTextStyle.textStyle20w400,
                  ),
                ),
                const SizedBox(width: 8.0),
                if (iconAsset != null) Image.asset(iconAsset!),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              style: ThemeTextStyle.textStyle14w400.copyWith(
                color: ColorPalette.gray,
              ),
            ),
            const SizedBox(height: 16.0),
            MainButton(
              title: buttonTitle,
              onTap: buttonHandler,
              buttonHeight: 36.0,
              borderRadius: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
