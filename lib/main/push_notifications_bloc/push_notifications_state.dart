part of 'push_notifications_bloc.dart';

@immutable
abstract class PushNotificationsState {}

class PushNotificationsInitial extends PushNotificationsState {}

class NavigateToScreenState extends PushNotificationsState {
  // final BaseNotification notification;
  //
  // NavigateToScreenState(this.notification);
}
