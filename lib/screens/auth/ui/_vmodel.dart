import 'package:flutter/material.dart';

import '../../../widgets/main_text_field/app_text_field.dart';

class SignInVModel extends ChangeNotifier {
  // SignInVModel();

  late final login = AppTextField(
    hintText: "Логин",
    capitalize: false,
  );
  late final password = AppTextField(
    hintText: "Пароль",
    capitalize: false,
  );
  late final name = AppTextField(
    hintText: "Имя",
  );
  late final phone = AppTextField(
    hintText: "Номер телефона",
    capitalize: false,
  );

  late final bool isValidated = login.validated && password.validated;
}
