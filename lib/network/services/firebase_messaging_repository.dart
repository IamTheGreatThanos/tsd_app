import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingRepository {
  late final StreamController<String?> _tokenStream;
  late final RemoteMessage? _initialMessage;
  late String? _token;

  Future<void> init() async {
    _token = await generateNewToken();
    _tokenStream = StreamController<String?>.broadcast();

    if (Platform.isIOS) await FirebaseMessaging.instance.requestPermission();

    _initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.instance.onTokenRefresh.listen(
      (token) async {
        _logToken(token);
        _token = token;
        _tokenStream.add(token);
      },
      onError: (error) {
        _logException('OnFirebaseTokenRefresh', error.toString());
      },
    );
  }

  RemoteMessage? get initialMessage => _initialMessage;

  String? get token => _token;

  Future<void> configureListeners({
    void Function(RemoteMessage)? onData,
    void Function(RemoteMessage)? localPush,
  }) async {
    FirebaseMessaging.onMessage.listen((message) async {
      _logNotification(message);

      localPush?.call(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        _logNotification(message);
        onData?.call(message);
      },
      onError: (error) {
        _logException("on Message Opened App", error);
      },
    );
  }

  // Future<void> sendDeviceToken() async {
  //   try {
  //     _logToken('$_token');
  //     await _networkRepository.sendDeviceToken(token: _token ?? "");

  //     FirebaseMessaging.instance.onTokenRefresh.listen(
  //       (token) async {
  //         _logToken(token);

  //         await _networkRepository.sendDeviceToken(token: _token ?? "");
  //       },
  //       onError: (error) {
  //         _logException('OnFirebaseTokenRefresh', error.toString());
  //       },
  //     );
  //   } catch (e) {
  //     _logException('OnSendFirebaseToken', e.toString());
  //   }
  // }

  StreamSubscription<String?> onTokenRefresh(
    void Function(String?)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      _tokenStream.stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  Future<void> deleteDeviceToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (e) {
      _logException('OnDeleteFirebaseToken', e.toString());
    }
  }

    Future<String?> generateNewToken() async {
    try {
       _token = await FirebaseMessaging.instance.getToken();
       return _token;
    } catch (e) {
      _logException('OnDeleteFirebaseToken', e.toString());
    }
  }

  Future<void> subscriptionToTopic(String subscribeToTopic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(subscribeToTopic);
    } catch (e) {
      _logException('subscriptionToTopic', e.toString());
    }
  }

  Future<void> unsubscribeFromTopic(String unsubscribeFromTopic) async {
    try {
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(unsubscribeFromTopic);
    } catch (e) {
      _logException('unsubscribeFromTopic', e.toString());
    }
  }

  void _logNotification(RemoteMessage message) {
    log(
      'onMessage: $message\nTitle: ${message.notification?.title}\nBody: ${message.notification?.body}',
      name: 'NOTIFICATION',
    );
  }

  void _logException(String title, Object message) {
    log(
      'Title: $title\nMessage: $message',
      name: 'NOTIFICATION EXCEPTION',
    );
  }

  void _logToken(String token) {
    log(
      'Token: $token',
      name: 'FIREBASE TOKEN',
    );
  }
}
