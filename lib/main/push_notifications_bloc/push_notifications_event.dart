part of 'push_notifications_bloc.dart';

@immutable
abstract class PushNotificationsEvent {}

class NavigateToScreenPushNotifyEvent extends PushNotificationsEvent {
  // final BaseNotification notification;
  //
  // NavigateToScreenPushNotifyEvent(this.notification);
}

class InitialPushNotifyEvent extends PushNotificationsEvent {}
