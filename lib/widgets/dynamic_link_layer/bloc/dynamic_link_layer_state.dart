part of 'dynamic_link_layer_bloc.dart';

@immutable
abstract class DynamicLinkLayerState {}

class DynamicLinkLayerInitial extends DynamicLinkLayerState {}

class CreateNewPasswordState extends DynamicLinkLayerState {
  final bool isAuthorized;
  final String token;
  CreateNewPasswordState(this.isAuthorized, this.token);
}

class NotAuthorizedState extends DynamicLinkLayerState {
}

class AuthorizedState extends DynamicLinkLayerState {
}
