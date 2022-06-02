import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_arrival/widgets/custom_button.dart';

Future<void> buildAlertDialog(BuildContext context) async => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Разработка'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/lotties/sad_lottie.json'),
            const Text('Данный раздел в разработке!'),
          ],
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        actions: <Widget>[
          CustomButton(
            height: 56,
            onClick: () {
              Navigator.pop(context);
            },
            body: const Text(
              'Хорошо!',
              style: TextStyle(),
            ),
            style: pinkButtonStyle(),
          ),
        ],
      ),
    );
