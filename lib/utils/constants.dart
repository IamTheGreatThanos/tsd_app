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
