import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/main_button/main_button.dart';
import 'package:pharmacy_arrival/widgets/main_text_button/main_text_button.dart';
import 'package:flutter/material.dart';

import 'main_dialog_container.dart';

///Custom dialog window with two buttons
class TwoButtonsDialog extends StatelessWidget {
  ///Title of dialog
  final String title;

  ///Subtitle of dialog
  final String subtitle;

  ///Text of first dialog button
  final String firstButtonText;

  ///Text of second dialog button
  final String secondButtonText;

  ///Callback for first dialog button
  final VoidCallback? onFirstTap;

  ///Callback for second dialog button
  final VoidCallback? onSecondTap;

  const TwoButtonsDialog({
    Key? key,
    this.onFirstTap,
    this.onSecondTap,
    required this.title,
    required this.subtitle,
    required this.firstButtonText,
    required this.secondButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainDialogContainer(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: ProjectTextStyles.ui_20Medium,
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            style: ProjectTextStyles.ui_14Regular
                .copyWith(color: ColorPalette.gray),
          ),
          const SizedBox(height: 16.0),
          MainButton(
            title: firstButtonText,
            onTap: onFirstTap ?? () {},
            buttonHeight: 36.0,
            borderRadius: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Center(
              child: MainTextButton(
                  title: secondButtonText,
                  onPressed: () {
                    onSecondTap?.call();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
