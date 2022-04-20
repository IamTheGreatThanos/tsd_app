import 'package:flutter/cupertino.dart';

class AttachToClinicManager extends ChangeNotifier {
  bool _isAttached = false;

  bool get isAttached => _isAttached;

  set isAttached(bool isAttached) {
    _isAttached = isAttached;
    notifyListeners();
  }

}
