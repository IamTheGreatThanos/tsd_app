import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.value,
  })  : color = ColorPalette.dark,
        isCircular = true;

  const AppLoadingIndicator.inverted({
    super.key,
    this.value,
  })  : color = ColorPalette.white,
        isCircular = true;

  const AppLoadingIndicator.linear({
    super.key,
    this.value,
  })  : color = ColorPalette.dark,
        isCircular = false;

  final Color color;
  final bool isCircular;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return isCircular
        ? Center(
            child: CircularProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation(
                color,
              ),
            ),
          )
        : LinearProgressIndicator(
            minHeight: 2.0,
            value: value,
            valueColor: AlwaysStoppedAnimation(
              color,
            ),
          );
  }
}
