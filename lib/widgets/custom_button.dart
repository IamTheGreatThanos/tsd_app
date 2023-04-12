import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/core/styles/color_palette.dart';

class CustomButton extends StatefulWidget {
  final Widget body;
  final Function() onClick;
  final ButtonStyle style;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.body,
    required this.onClick,
    required this.style,
    this.width,
    this.height,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height == 0 ? null : widget.height,
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: ElevatedButton(
        onPressed: () {
          widget.onClick();
        },
        style: widget.style,
        child: widget.body,
      ),
    );
  }
}

ButtonStyle whiteButtonStyle() {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    // shadowColor: MaterialStateProperty.all<Color>(
    //   Colors.black,
    //   // const Color.fromRGBO(255, 255, 255, 0),
    // ),
    // backgroundColor: MaterialStateProperty.all<Color>(
    //   const Color.fromRGBO(255, 255, 255, 1),
    // ),
    // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //   RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(7),
    //   ),
    // ),
  );
}

ButtonStyle blackButtonStyle() {
  return ButtonStyle(
    shadowColor: MaterialStateProperty.all<Color>(
      const Color.fromRGBO(255, 255, 255, 1),
    ),
    backgroundColor:
        MaterialStateProperty.all<Color>(const Color.fromRGBO(0, 0, 0, 1.0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white),
      ),
    ),
  );
}

ButtonStyle pinkButtonStyle() {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: ColorPalette.orange,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

ButtonStyle gray50ButtonStyle({
  Color color = ColorPalette.orange,
  double elevation = 1,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: color,
    elevation: elevation,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

ButtonStyle gray100ButtonStyle({
  Color color = ColorPalette.orange,
  double elevation = 1,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: color,
    elevation: elevation,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

ButtonStyle yellowButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color.fromRGBO(255, 221, 0, 1),
    ),
    shadowColor: MaterialStateProperty.all<Color>(
      const Color.fromRGBO(255, 255, 255, 0),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        // side: BorderSide(color: Colors.black),
      ),
    ),
  );
}

ButtonStyle redButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      Colors.red,
    ),
    shadowColor: MaterialStateProperty.all<Color>(
      const Color.fromRGBO(255, 255, 255, 0),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        // side: BorderSide(color: Colors.black),
      ),
    ),
  );
}
