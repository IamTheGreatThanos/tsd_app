import 'package:flutter/cupertino.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';

class PharmacyFilterVmodel extends ChangeNotifier {
  int? _sortType;
  int? get sortType => _sortType;
  set sortType(int? value) {
    _sortType = value;
    notifyListeners();
  }

  CounteragentDTO? _sender;
  CounteragentDTO? get sender => _sender;

  set sender(CounteragentDTO? value) {
    _sender = value;
    notifyListeners();
  }

  String? _departureDate;
  String? get departureDate => _departureDate;
  set departureDate(String? value) {
    _departureDate = value;
    notifyListeners();
  }

  String? _amountStart;
  String? get amountStart => _amountStart;
  set amountStart(String? value) {
    _amountStart = value;
    notifyListeners();
  }

  String? _amountEnd;
  String? get amountEnd => _amountEnd;
  set amountEnd(String? value) {
    _amountEnd = value;
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
    _sender = null;
    _departureDate = null;
    _amountStart = null;
    _amountEnd = null;

    notifyListeners();
  }
}
