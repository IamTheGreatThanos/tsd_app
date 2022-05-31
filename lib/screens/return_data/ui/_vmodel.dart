import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../styles/color_palette.dart';
import '../../../styles/text_styles.dart';
import '../../../widgets/main_text_field/app_text_field.dart';

class ReturnDataVModel extends ChangeNotifier {
  late AppTextField organization;
  late AppTextField counterparty;
  late AppTextField stock;

  void init() {
    organization = AppTextField(
      contentPadding: EdgeInsets.zero,
      textAlign: TextAlign.right,
      showErrorMessages: false,
      onChanged: onChanged,
    );
    counterparty = AppTextField(
      contentPadding: EdgeInsets.zero,
      textAlign: TextAlign.right,
      showErrorMessages: false,
      onChanged: onChanged,
    );
    stock = AppTextField(
      contentPadding: EdgeInsets.zero,
      textAlign: TextAlign.right,
      showErrorMessages: false,
      onChanged: onChanged,
    );
  }

  void onChanged(String value) {
    notifyListeners();
  }

  bool get validated =>
      counterparty.controller.text.isNotEmpty &&
      organization.controller.text.isNotEmpty &&
      stock.controller.text.isNotEmpty;
}
