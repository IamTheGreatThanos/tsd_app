import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'app_loading_indicator.dart';

export 'package:loader_overlay/src/overlay_controller_widget_extension.dart';

class AppLoaderOverlay extends StatelessWidget {
  const AppLoaderOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      disableBackButton: true,
      useDefaultLoading: false,
      overlayWidget: const AppLoadingIndicator(),
      child: child,
    );
  }
}
