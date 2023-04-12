import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool rootNavigator;
  final PreferredSizeWidget? bottom;
  final double height;
  final bool showLogo;
  final bool isChevrone;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? leadingColor;
  final List<Widget>? actions;
  final Function()? onBackTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.bottom,
    this.height = 60,
    this.rootNavigator = false,
    this.showLogo = true,
    this.isChevrone = false,
    this.backgroundColor,
    this.textStyle,
    this.leadingColor,
    this.actions, this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? ColorPalette.white,
      elevation: 0.5,
      centerTitle: true,
      title: Text(
        title,
        style: textStyle ?? ThemeTextStyle.textTitleDella16w400,
      ),
      bottom: bottom,
      actions: actions ??
          [
            if (showLogo)
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SvgPicture.asset(
                  "assets/images/svg/europharm_logo.svg",
                  height: 22,
                ),
              ),
          ],
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/images/svg/${isChevrone ? "chevron_left" : "cross"}.svg",
          colorFilter: ColorFilter.mode(
            leadingColor ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        onPressed: onBackTap??() {
          Navigator.of(context, rootNavigator: rootNavigator).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
