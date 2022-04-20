import 'package:pharmacy_arrival/generated/l10n.dart';
import 'package:pharmacy_arrival/widgets/main_button/main_button.dart';
import 'package:flutter/material.dart';

Future<T?> showAppDialog<T>(
  BuildContext context, {
  String? title,
  String? body,
  Function? onTap,
  Widget Function(BuildContext context)? actions,
  bool barrierDismissible = false,
  bool showCancel = true,
}) =>
    showDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20.0,
                      20.0,
                      20.0,
                      0.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20.0),
                if (body != null)
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                      20.0,
                      0.0,
                      20.0,
                      20.0,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            body,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (showCancel)
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 16, right: 16),
                    child: MainButton(
                        title: S.of(context).okay,
                        onTap: () {
                          Navigator.of(context).pop(true);
                          onTap?.call();
                        }),
                  ),
                if (!showCancel && actions != null) actions(context),
              ],
            );
          },
        ),
      ),
    );
