import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/repository/global_repository.dart';
import '../../network/repository/hive_repository.dart';
import 'constants/constants.dart';

part 'push_notifications_event.dart';

part 'push_notifications_state.dart';

const String _TAG = 'PushNotificationsBloc';

class PushNotificationsBloc
    extends Bloc<PushNotificationsEvent, PushNotificationsState> {
  final HiveRepository _hiveRepository;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final GlobalRepository _repository;
  String _firebaseMessagingToken = '';
  StreamSubscription<RemoteMessage>? messageSub;
  StreamSubscription<RemoteMessage>? messageOpenedAppSub;
  StreamSubscription<String>? tokenRefreshSub;

  PushNotificationsBloc(this._repository, this._hiveRepository,)
      : super(PushNotificationsInitial()) {
    on<NavigateToScreenPushNotifyEvent>(_onNavigateToScreenPushNotifyEvent);
    on<InitialPushNotifyEvent>(_onInitialPushNotifyEvent);
  }

  void _onMessageHandler(RemoteMessage message) {
    jsonEncode(message.data);
    // final notificationData =
    //     DTONotification.fromJson(jsonDecode(message.data['data']));
    // add(NavigateToScreenPushNotifyEvent(notificationData.notification));
    // log('Push notification open notification type: ${notificationData.notification.runtimeType.toString()}',
    //     name: _TAG);
  }

  void _subscribeChangeToken() {
    tokenRefreshSub = _firebaseMessaging.onTokenRefresh.listen((event) async {
      // await _repository.setFcmToken(event);
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  @override
  Future<void> close() async {
    await messageSub?.cancel();
    await messageOpenedAppSub?.cancel();
    await tokenRefreshSub?.cancel();
    await _firebaseMessaging.deleteToken();
    await FlutterLocalNotificationsPlugin().cancelAll();
    return super.close();
  }

  FutureOr<void> _onNavigateToScreenPushNotifyEvent(
      NavigateToScreenPushNotifyEvent event,
      Emitter<PushNotificationsState> emit) {
    // emit(NavigateToScreenState(event.notification));
  }

  FutureOr<void> _onInitialPushNotifyEvent(InitialPushNotifyEvent event,
      Emitter<PushNotificationsState> emit) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
          sound: true, alert: true, badge: true);
    }
    messageSub = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Push Notification received', name: _TAG);
    });

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    messageOpenedAppSub =
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _preferences.setString(lastFcmMessageId, message.messageId ?? '');
      _onMessageHandler(message);
    });
    _subscribeChangeToken();

    try {
      _firebaseMessagingToken = (await _firebaseMessaging.getToken()) ?? '';
      // await _repository.setFcmToken(_firebaseMessagingToken);
      log('fcmToken: $_firebaseMessagingToken', name: _TAG);
    } catch (e) {
      print(e);
    }

    final message = await FirebaseMessaging.instance.getInitialMessage();
    var lastMessageId = _preferences.getString(lastFcmMessageId);
    // if (message != null &&
    //     _hiveRepository.isGetFBInitialMessage() == false &&
    //     lastMessageId != message.messageId) {
    //   _hiveRepository.setIsGetFBInitialMessage(true);
    //   _onMessageHandler(message);
    // }
  }
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  final messageData = jsonDecode(message.data['data']);
}
