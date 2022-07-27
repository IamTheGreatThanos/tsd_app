import 'package:flutter/cupertino.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';

class PharmacyFilterVmodel extends ChangeNotifier {
  String? _incomingNumber;
  String? get incomingNumber => _incomingNumber;
  set incomingNumber(String? value) {
    _incomingNumber = value;
    notifyListeners();
  }

  String? _incomingDate;
  String? get incomingDate => _incomingDate;
  set incomingDate(String? value) {
    _incomingDate = value;
    notifyListeners();
  }

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
    _incomingDate = null;
    _incomingNumber = null;
    _sortType = null;
    _sender = null;
    _departureDate = null;
    _amountStart = null;
    _amountEnd = null;

    notifyListeners();
  }
}
