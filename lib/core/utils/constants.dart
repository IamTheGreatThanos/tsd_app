import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter maskPhoneFormatter = MaskTextInputFormatter(
  mask: '(###) ###-##-##',
  filter: {"#": RegExp('[0-9]')},
);

Map<int?, String> totalStatuses = {
  null: 'Ошибка статуса',
  1: "новый",
  2: "отгружен",
  3: "в пути",
  4: "доставлен",
};

String moneyFormatter(String money) {
  String temp = "";
  final String tempReversed = money.split('').reversed.join();

  for (int i = 0; i < tempReversed.length; i++) {
    temp += tempReversed[i];
    if ((i + 1) % 3 == 0) {
      temp += ' ';
    }
  }

  return temp.split('').reversed.join();
}

Future bottomSheet(
  Widget widget,
  BuildContext context,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    enableDrag: true,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return widget;
    },
  );
}

const List<String> sortByDate = [
  "Сначало новые",
  "Сначало старые"
];
