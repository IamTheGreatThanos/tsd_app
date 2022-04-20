import 'package:flutter/material.dart';

class Knob extends StatelessWidget {
  const Knob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.15,
      height: 7.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFDDE1E5),
      ),
    );
  }
}
