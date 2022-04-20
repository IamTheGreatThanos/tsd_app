import 'package:flutter/material.dart';



///Base dialog for user as container for other dialogs widgets, inspired by ui kit
class MainDialogContainer extends StatelessWidget {
  const MainDialogContainer(
      {Key? key, required this.child, this.padding = EdgeInsets.zero})
      : super(key: key);

  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(padding: padding, child: child),
    );
  }
}
