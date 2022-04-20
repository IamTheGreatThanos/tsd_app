part of 'after_login_layer_bloc.dart';

@immutable
abstract class AfterLoginLayerState {}

class LoadingAfterLoginState extends AfterLoginLayerState {
  LoadingAfterLoginState();
}

class AuthenticatedAfterLoginState extends AfterLoginLayerState {}

class NotConfirmedAccountState extends AfterLoginLayerState {
  final String email;
  NotConfirmedAccountState(this.email);
}

class ConfirmedAccountState extends AfterLoginLayerState {}

class AttachedToClinicState extends AfterLoginLayerState {
  final String? email;
  final String? name;
  AttachedToClinicState({this.email, this.name,});
}

class NotAttachedToClinicState extends AfterLoginLayerState {}

class ErrorAfterLoginState extends AfterLoginLayerState {
  final error;
  ErrorAfterLoginState(this.error);
}

