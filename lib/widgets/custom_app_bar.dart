import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/color_palette.dart';
import '../styles/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool rootNavigator;
  final PreferredSizeWidget? bottom;
  final double height;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.bottom,
    this.height = 60,
    this.rootNavigator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: ThemeTextStyle.textStyle20w400,
      ),
      bottom: bottom,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/images/svg/arrow_back.svg",
          color: ColorPalette.black,
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: rootNavigator).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
