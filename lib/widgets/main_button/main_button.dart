import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///Base button which can be one of design button
class MainButton extends StatelessWidget {
  ///Title of button
  final String? title;

  ///Background color of button
  final Color color;

  ///Text color of button
  final Color textColor;

  ///If false, button becomes not available
  final bool isEnabled;

  ///On tap callback
  final VoidCallback onTap;

  ///Color of external border
  final Color? borderColor;

  ///Height of button
  final double buttonHeight;

  ///Icon before text (optional)
  final String? icon;
  final Color? iconColor;

  ///Width of button. If width not specified, than equals screen width
  final double? width;

  ///Font size of button text
  final double fontSize;

  ///Radius of button's border
  final double borderRadius;

  ///Disabled text color
  final Color? disabledTextColor;

  ///Disabled background color
  final Color? disabledBackgroundColor;

  const MainButton({
    Key? key,
    this.title,
    this.color = ColorPalette.main,
    this.isEnabled = true,
    this.textColor = ColorPalette.white,
    required this.onTap,
    this.buttonHeight = 50,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.width,
    this.fontSize = 16,
    this.borderRadius = 12,
    this.disabledTextColor,
    this.disabledBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: buttonHeight,
          width: width ?? MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
              backgroundColor: MaterialStateProperty.all<Color>(
                !isEnabled && disabledBackgroundColor != null
                    ? disabledBackgroundColor!
                    : color,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: (borderColor != null)
                      ? BorderSide(color: borderColor!)
                      : BorderSide.none,
                ),
              ),
            ),
            onPressed: isEnabled ? onTap : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          icon!,
                          color: iconColor,
                          width: 20,
                          height: 20,
                        ),
                      )
                    : const SizedBox.shrink(),
                title != null
                    ? Text(
                        title!,
                        style: ProjectTextStyles.ui_16Semi.copyWith(
                          color: !isEnabled && disabledBackgroundColor != null
                              ? disabledTextColor
                              : textColor,
                          height: 1.5,
                          fontSize: fontSize,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
        if (!isEnabled && disabledBackgroundColor == null)
          Positioned.fill(
            child: Container(
              height: buttonHeight,
              width: width ?? MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: ColorPalette.white.withOpacity(0.55),
              ),
            ),
          ),
      ],
    );
  }
}