import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter maskPhoneFormatter = MaskTextInputFormatter(
    mask: '(###) ###-##-##', filter: {"#": RegExp('[0-9]')});