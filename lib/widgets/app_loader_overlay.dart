import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pharmacy_arrival/widgets/app_loading_indicator.dart';
export 'package:loader_overlay/src/overlay_controller_widget_extension.dart';

class AppLoaderOverlay extends StatelessWidget {
  const AppLoaderOverlay({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const AppLoadingIndicator(),
      child: child,
    );
  }
}
