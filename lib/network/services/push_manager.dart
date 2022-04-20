// import 'dart:convert';
// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class PushManager {
//   late final BottomNavBarViewModel _bottomNavBarViewModel;
//   Timer? _timer;
//   final Duration duration = const Duration(seconds: 2);
//   late String _payload;
//   OverlayState? _overlayState;
//
//   OverlayEntry? _overlayEntry;
//
//   Future<void> init({
//     required BottomNavBarViewModel bottomNavBarViewModel,
//     required OverlayState? overlayState,
//   }) async {
//     _bottomNavBarViewModel = bottomNavBarViewModel;
//     _overlayState = overlayState;
//   }
//
//   Future<void> onSelectNotification(String payload) async {
//     final _payload = jsonDecode(payload);
//
//     final transitionType = _payload["transition_type"] == null
//         ? null
//         : _payload["transition_type"].toString();
//
//     final transitionId = _payload["transition_id"] == null
//         ? null
//         : int.parse(_payload["transition_id"].toString().isEmpty
//             ? "-1"
//             : _payload["transition_id"].toString());
//
//     final transitionAppbarName = _payload["transition_appbar_name"] == null
//         ? null
//         : _payload["transition_appbar_name"].toString();
//
//     _bottomNavBarViewModel.index = Constants.navBarProfileKey;
//
//     _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState
//         ?.popUntil((route) => route.isFirst);
//
//     if (transitionType == Constants.pushMessagingTypeOrder) {
//       _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState
//           ?.push(userOrderDetailsRoute());
//
//       if (transitionId != null) {
//         _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState?.push(
//           orderDetailsRoute(orderId: transitionId, isFromPush: true),
//         );
//       }
//     } else {
//       _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState
//           ?.push(mainMessagesRoute());
//     }
//
//     if (transitionType == Constants.pushMessagingTypeNews) {
//       _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState?.push(
//         newsMessageRoute(),
//       );
//
//       if (transitionId != null && transitionId > 0) {
//         _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState?.push(
//           catalogGoodsRoute(
//             transitionId,
//             [],
//             transitionAppbarName ?? "",
//           ),
//         );
//       }
//     } else if (transitionType == Constants.pushMessagingTypeAppeal) {
//       _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState?.push(
//         appealMessageRoute(),
//       );
//     } else if (transitionType == Constants.pushMessagingTypePromotions) {
//       _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState?.push(
//         stocksMessageRoute(),
//       );
//
//       if (transitionId != null && transitionId > 0) {
//         _bottomNavBarViewModel.routes[Constants.navBarProfileKey].key.currentState?.push(
//           catalogGoodsRoute(
//             transitionId,
//             [],
//             transitionAppbarName ?? "",
//           ),
//         );
//       }
//     }
//   }
//
//   void show(PopupNotificationModel message, {String? payload}) {
//     if (payload != null) {
//       _payload = payload;
//     }
//     if (_timer != null) {
//       _timer?.cancel();
//     }
//
//     if (_overlayEntry != null) {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     }
//
//     _overlayEntry = _getOverlayEntry(message);
//
//     _overlayState?.insert(_overlayEntry!);
//
//     _timer = Timer(duration, _close);
//   }
//
//   void _close() {
//     if (_overlayEntry != null) {
//       try {
//         _overlayEntry?.remove();
//       } catch (e) {
//         print(e.toString());
//       } finally {
//         _overlayEntry = null;
//       }
//     }
//   }
//
//   OverlayEntry _getOverlayEntry(PopupNotificationModel message) {
//     return OverlayEntry(
//       builder: (_) => Positioned(
//         right: 0,
//         left: 0,
//         top: 0,
//         child: OverlayNotification(
//           onTap: () async => onSelectNotification(_payload),
//           onDismissed: (_) => _close(),
//           onTapDown: (_) => _timer?.cancel(),
//           onTapUp: (_) => _timer = Timer(duration, _close),
//           title: message.title,
//           message: message.body,
//         ),
//       ),
//     );
//   }
// }
