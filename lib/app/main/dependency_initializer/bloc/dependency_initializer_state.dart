part of 'dependency_initializer_bloc.dart';

@immutable
abstract class DependencyInitializerState {}

class InitializedDependencyInitializer extends DependencyInitializerState {}

class NotInitializedDependencyInitializer extends DependencyInitializerState {}
