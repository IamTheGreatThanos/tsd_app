import 'package:flutter/material.dart';

class DependenciesInitializer<T extends Object> extends StatefulWidget {
  final Widget loadingIndicatorScreen;

  final Future Function(BuildContext) initializer;

  final Widget child;

  const DependenciesInitializer({
    super.key,
    required this.loadingIndicatorScreen,
    required this.initializer,
    required this.child,
  });

  @override
  _DependenciesInitializerState<T> createState() =>
      _DependenciesInitializerState<T>();
}

class _DependenciesInitializerState<T extends Object>
    extends State<DependenciesInitializer<T>> {
  late final Future _future;

  @override
  void initState() {
    _future = widget.initializer(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.done) {
            return widget.child;
          } else {
            return widget.loadingIndicatorScreen;
          }
        } else {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            ),
          );
        }
      },
    );
  }
}
