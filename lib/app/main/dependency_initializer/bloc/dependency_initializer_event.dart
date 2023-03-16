part of 'dependency_initializer_bloc.dart';

@immutable
abstract class DependencyInitializerEvent {}

class InitialDependencyInitializedEvent extends DependencyInitializerEvent {
  final Future<bool> Function(BuildContext context) _initializer;
  final BuildContext context;

  InitialDependencyInitializedEvent(this._initializer, this.context);
}
