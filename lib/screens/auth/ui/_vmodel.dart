import '../../../widgets/main_text_field/app_text_field.dart';

class SignInVModel {
  // SignInVModel();

  late final login = AppTextField(
    hintText: "Логин",
    capitalize: false,
  );
  late final password = AppTextField(
    hintText: "Пароль",
    capitalize: false,
  );

  late final bool isValidated = login.validated && password.validated;
}
