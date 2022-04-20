import 'package:flutter/cupertino.dart';

abstract class AppRouter {
  static Future push(
    BuildContext? context,
    Widget screen, {
    bool rootNavigator = false,
  }) {
    if (context == null) {
      return Future.value();
    }
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      CupertinoPageRoute(builder: (context) => screen),
    );
  }

  static Future pushOff(
    BuildContext context,
    Widget screen, {
    bool rootNavigator = false,
  }) {
    return Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => screen,
      ),
      (route) => false,
    );
  }

  static Future pushReplacement(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static Future pushAndRemoveUntilRoot(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => screen,
      ),
      (route) => route.isFirst,
    );
  }
}
