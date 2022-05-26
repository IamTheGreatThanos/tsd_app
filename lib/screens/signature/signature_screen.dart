import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:signature/signature.dart';

import '../../widgets/custom_app_bar.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: ColorPalette.main,
  );

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: ColorPalette.main,
        title: "Распишитесь",
        showLogo: false,
        isChevrone: true,
      ),
      body: Stack(
        children: [
          Signature(
            controller: _controller,
            height: MediaQuery.of(context).size.height,
            backgroundColor: ColorPalette.main,
          ),
          Positioned(
              bottom: 32,
              right: 16,
              child: Row(
                children: [
                  _BuildButton(onTap: (){
                    setState(() {
                      _controller.clear();
                    });
                  }, title: "Очистить", icon: "clear_signature", color: ColorPalette.white),
                  const SizedBox(width: 8,),
                  _BuildButton(onTap: (){}, title: "Отправить", icon: "done_signature", color: ColorPalette.orange),
                ],
              ))
        ],
      ),
    );
  }
}

class _BuildButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;
  final Color color;

  const _BuildButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              RotatedBox(
                  quarterTurns: -45,
                  child: SvgPicture.asset("assets/images/svg/$icon.svg")),
              const SizedBox(
                width: 8,
              ),
              Text(
                title.toUpperCase(),
                style: ThemeTextStyle.textStyle14w600.copyWith(
                  color: color == Colors.white
                      ? ColorPalette.grey400
                      : Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}
