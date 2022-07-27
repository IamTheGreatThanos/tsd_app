import 'package:flutter/cupertino.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';

class MoveFilterVmodel extends ChangeNotifier {
  int? _sortType;
  int? get sortType => _sortType;
  set sortType(int? value) {
    _sortType = value;
    notifyListeners();
  }

  CounteragentDTO? _recipient;
  CounteragentDTO? get recipient => _recipient;
  set recipient(CounteragentDTO? value) {
    _recipient = value;
    notifyListeners();
  }

  CounteragentDTO? _sender;
  CounteragentDTO? get sender => _sender;
  set sender(CounteragentDTO? value) {
    _sender = value;
    notifyListeners();
  }

  String? _date;
  String? get date => _date;
  set date(String? value) {
    _date = value;
    notifyListeners();
  }

  int _filterCount = 0;
  int get filterCount => _filterCount;
  set filterCount(int filterCount) {
    _filterCount = filterCount;
    notifyListeners();
  }

  void clear() {
    filterCount = 0;
    _sortType = null;
    _date = null;
    _sender = null;
    _recipient = null;

    notifyListeners();
  }
}
