import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/color_palette.dart';
import '../styles/text_styles.dart';

class AppListTile extends StatelessWidget {
  ///typically [leading] is a CircleAvatar with radius 30.0
  AppListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.leading,
    this.trailing,
    this.contentPadding = const EdgeInsets.all(16.0),
    this.leadingPadding = const EdgeInsets.only(right: 16.0),
    this.color = ColorPalette.white,
    this.titleStyle = ThemeTextStyle.textStyle16w400,
    this.chevronVisible = true,
    TextStyle? subtitleStyle,
  })  : subtitleStyle = subtitleStyle ??
      ThemeTextStyle.textStyle14w400,
        super(key: key);

  final Color color;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry leadingPadding;
  final CircleAvatar? leading;
  final VoidCallback? onTap;
  final String? subtitle;
  final String title;
  final TextStyle? titleStyle;
  final Widget? trailing;
  final bool chevronVisible;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        color: color,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            if (leading != null)
              Padding(
                padding: leadingPadding,
                child: leading!,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: titleStyle,
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        right: 16.0,
                      ),
                      child: Text(
                        subtitle!,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: subtitleStyle,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
            (chevronVisible && onTap != null)
                ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                "assets/images/svg/arrow_right.svg",
              ),
            )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
