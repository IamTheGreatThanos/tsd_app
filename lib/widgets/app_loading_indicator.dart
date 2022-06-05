import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    Key? key,
    this.value,
  })  : color = ColorPalette.dark,
        isCircular = true,
        super(key: key);

  const AppLoadingIndicator.inverted({
    Key? key,
    this.value,
  })  : color = ColorPalette.white,
        isCircular = true,
        super(key: key);

  const AppLoadingIndicator.linear({
    Key? key,
    this.value,
  })  : color = ColorPalette.dark,
        isCircular = false,
        super(key: key);

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
