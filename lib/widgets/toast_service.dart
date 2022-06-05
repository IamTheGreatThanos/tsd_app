
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void toastServiceSuccess(String msg) {
  BotToast.showCustomText(
    duration: const Duration(seconds: 4),
    toastBuilder: (textCancel) => Align(
      alignment:  Alignment.topCenter,
      child: Container(
        width: 414,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          children: [Expanded(child: Text(msg))],
        ),
      ),
    ),
  );
}
