import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:pharmacy_arrival/core/styles/color_palette.dart';
import 'package:pharmacy_arrival/core/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';

class FillInvoiceVModel extends ChangeNotifier {
  late AppTextField incomeNumber;
  late AppTextField incomeNumberDate;
  late AppTextField bin;
  late AppTextField recipient;
  late AppTextField authPassword;
  late AppTextField certificatePassword;
  late TextEditingController incomeNumberDateController;
  late TextEditingController invoiceDate;
  late String auth;
  late String cert;
  late int recipientId;
  late bool isTwoPassword;

  void setIncomeNumberDate(DateTime value) {
    incomeNumberDateController.text = DateFormat("dd.MM.yyyy").format(value);
    notifyListeners();
  }

  void setInvoiceDate(DateTime value) {
    invoiceDate.text = DateFormat("dd.MM.yyyy").format(value);
    notifyListeners();
  }

  void init() {
    recipientId=-1;
    incomeNumber = AppTextField(
      contentPadding: EdgeInsets.zero,
      capitalize: false,
      showErrorMessages: false,
      onChanged: onChanged,
      hintText: 'Входящий номер',
      hintStyle: ThemeTextStyle.textStyle14w400.copyWith(
        color: ColorPalette.grey400,
      ),
    );
    incomeNumberDate = AppTextField(
      contentPadding: EdgeInsets.zero,
      capitalize: false,
      readonly: true,
      textAlign: TextAlign.right,
      showErrorMessages: false,
      onChanged: onChanged,
      suffixIcon: SvgPicture.asset("assets/images/svg/calendarcircleic.svg"),
    );
    bin = AppTextField(
      contentPadding: const EdgeInsets.all(12),
      hintText: "Контрагент поставщика(БИН)",
      hintStyle:
          ThemeTextStyle.textStyle14w400.copyWith(color: ColorPalette.grey400),
      keyboardType: TextInputType.number,
      showErrorMessages: false,
      onChanged: onChanged,
    );
    recipient = AppTextField(
      contentPadding: EdgeInsets.zero,
      capitalize: false,
      showErrorMessages: false,
      hintText: 'Получатель',
      hintStyle: ThemeTextStyle.textStyle14w400.copyWith(
        color: ColorPalette.grey400,
      ),
      onChanged: onChanged,
    );
    authPassword = AppTextField(
      capitalize: false,
      showErrorMessages: false,
      hintText: "Пароль AUTH",
      onChanged: onChanged,
    );
    certificatePassword = AppTextField(
      capitalize: false,
      showErrorMessages: false,
      hintText: "Пароль RSA/GOST",
      onChanged: onChanged,
    );
    incomeNumberDateController = TextEditingController();
    invoiceDate = TextEditingController();
    auth = "";
    cert = "";
    isTwoPassword = false;
  }

  void onChanged(String value) {
    notifyListeners();
  }

  bool get validated =>
      incomeNumber.controller.text.isNotEmpty &&
      bin.controller.text.isNotEmpty &&
      recipient.controller.text.isNotEmpty &&
      incomeNumberDateController.text.isNotEmpty &&
      invoiceDate.text.isNotEmpty;

  bool digitalSignatureFillValidated() {
    if (!isTwoPassword) {
      return auth.isNotEmpty &&
          cert.isNotEmpty &&
          authPassword.controller.text.isNotEmpty;
    } else {
      return auth.isNotEmpty &&
          cert.isNotEmpty &&
          authPassword.controller.text.isNotEmpty &&
          certificatePassword.controller.text.isNotEmpty;
    }
  }

  void setCertName(String value, {bool isAuth = true}) {
    if (isAuth) {
      auth = value;
    } else {
      cert = value;
    }
    notifyListeners();
  }

  void changeSwitch({required bool value}) {
    isTwoPassword = value;
    notifyListeners();
  }
}
