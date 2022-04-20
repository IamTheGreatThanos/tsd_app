// import 'package:europharm_flutter/styles/color_palette.dart';
// import 'package:europharm_flutter/styles/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// ///Main text field widget inspired by ui kit
// class MainTextField extends StatelessWidget {
//   ///Controller of text field value
//   final TextEditingController? controller;
//
//   ///Hint text for empty value text field
//   final String? hintText;
//
//   ///Focus node for focus control
//   final FocusNode? focusNode;
//
//   ///Max lines of text field, affects height of text field
//   final int? maxLines;
//
//   ///Icon before input text
//   final String? prefixIcon;
//
//   ///Icon after input text
//   final String? suffixIcon;
//
//   ///On changed callback, invokes after text field value changing
//   final Function(String)? onChanged;
//
//   ///On editing complete callback, invokes after complete editing text field
//   final VoidCallback? onEditingComplete;
//
//   ///Validation callback
//   final String? Function(String?)? validate;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType? keyboardType;
//
//   const MainTextField({
//     Key? key,
//     this.controller,
//     this.hintText,
//     this.focusNode,
//     this.maxLines,
//     this.onChanged,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.validate,
//     this.onEditingComplete,
//     this.inputFormatters,
//     this.keyboardType,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: keyboardType,
//       onEditingComplete: onEditingComplete,
//       validator: validate,
//       maxLines: maxLines,
//       controller: controller,
//       focusNode: focusNode,
//       inputFormatters: inputFormatters,
//       onChanged: onChanged,
//       style: ProjectTextStyles.ui_14Regular.copyWith(
//         color: ColorPalette.black,
//       ),
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 16.0,
//           vertical: 14.0,
//         ),
//         hintText: hintText,
//         prefixIcon: _getIcon(prefixIcon),
//         suffixIcon: _getIcon(suffixIcon),
//         hintStyle: ProjectTextStyles.ui_14Regular.copyWith(
//           color: ColorPalette.lightGray,
//           height: 1.0,
//         ),
//         border: _buildBorder(),
//         focusedBorder: _buildBorder(),
//         errorBorder: _buildBorder(),
//         enabledBorder: _buildBorder(),
//         disabledBorder: _buildBorder(),
//         focusedErrorBorder: _buildBorder(),
//       ),
//     );
//   }
//
//   Widget? _getIcon(String? fieldIcon) {
//     final icon = fieldIcon;
//     if (icon != null) {
//       return Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: 16.25,
//           horizontal: 20.11,
//         ),
//         child: SvgPicture.asset(icon),
//       );
//     }
//     return null;
//   }
//
//   OutlineInputBorder _buildBorder(
//       {Color color = ColorPalette.borderLightGray}) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide(color: color),
//     );
//   }
// }
