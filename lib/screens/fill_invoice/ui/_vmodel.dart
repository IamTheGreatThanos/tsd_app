import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles/color_palette.dart';
import '../../../styles/text_styles.dart';
import '../../../widgets/main_text_field/app_text_field.dart';

class FillInvoiceVModel extends ChangeNotifier {
  AppTextField? _incomeNumber;

  AppTextField get incomeNumber => _incomeNumber!;
  AppTextField? _incomeNumberDate;

  AppTextField get incomeNumberDate => _incomeNumberDate!;

  AppTextField? _bin;

  AppTextField get bin => _bin!;

  AppTextField? _recipient;

  AppTextField get recipient => _recipient!;

  AppTextField? _authPassword;

  AppTextField get authPassword => _authPassword!;

  AppTextField? _certificatePassword;

  AppTextField get certificatePassword => _certificatePassword!;

  TextEditingController? _incomeNumberDateController;

  TextEditingController get incomeNumberDateController =>
      _incomeNumberDateController!;

  TextEditingController? _invoiceDate;

  TextEditingController get invoiceDate => _invoiceDate!;

  String? _auth;

  String get auth => _auth!;

  String? _cert;

  String get cert => _cert!;

  bool? _isOnePassword;

  bool get isOnePassword => _isOnePassword!;

  void init() {
    _incomeNumber = AppTextField(
      contentPadding: EdgeInsets.zero,
      capitalize: false,
      textAlign: TextAlign.right,
      showErrorMessages: false,
      onChanged: (value) => notifyListeners(),
    );
    _incomeNumberDate = AppTextField(
      contentPadding: EdgeInsets.zero,
      capitalize: false,
      readonly: true,
      textAlign: TextAlign.right,
      showErrorMessages: false,
      suffixIcon: SvgPicture.asset("assets/images/svg/calendar_circle_ic.svg"),
    );
    _bin = AppTextField(
      contentPadding: const EdgeInsets.all(12),
      hintText: "Контрагент поставщика(БИН)",
      hintStyle:
          ThemeTextStyle.textStyle14w400.copyWith(color: ColorPalette.grey400),
      keyboardType: TextInputType.number,
      showErrorMessages: false,
    );
    _recipient = AppTextField(
      contentPadding: EdgeInsets.zero,
      capitalize: false,
      textAlign: TextAlign.right,
      showErrorMessages: false,
    );
    _authPassword = AppTextField(
      capitalize: false,
      showErrorMessages: false,
      hintText: "Пароль AUTH",
      onChanged: (value) => notifyListeners(),
    );
    _certificatePassword = AppTextField(
      capitalize: false,
      showErrorMessages: false,
      hintText: "Пароль RSA/GOST",
      onChanged: (value) => notifyListeners(),
    );
    _incomeNumberDateController = TextEditingController();
    _invoiceDate = TextEditingController();
    _auth = "";
    _cert = "";
    _isOnePassword = false;
  }

  void setCertName(String value, {bool isAuth = true}) {
    if (isAuth) {
      _auth = value;
    } else {
      _cert = value;
    }
    notifyListeners();
  }

  void changeSwitch(bool value) {
    _isOnePassword = value;
    notifyListeners();
  }
}
