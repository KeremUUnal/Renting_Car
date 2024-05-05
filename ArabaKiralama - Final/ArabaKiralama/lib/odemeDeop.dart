import 'package:flutter/material.dart';
class odemeDeop extends ChangeNotifier {
  String _kartIsim = '';

  String get kartIsim => _kartIsim;

  set kartIsim(String value) {
    _kartIsim = value;
    notifyListeners();
  }
  String _kartNo = '';

  String get kartNo => _kartNo;

  set kartNo(String value) {
    _kartNo = value;
    notifyListeners();
  }
  DateTime _sonKullanmaTarihi = DateTime(0,0,0);

  DateTime get sonKullanmaTarihi => _sonKullanmaTarihi;

  set sonKullanmaTarihi(DateTime value) {
    _sonKullanmaTarihi = value;
    notifyListeners();
  }
  String _cvv = '';

  String get cvv => _cvv;

  set cvv(String value) {
    _cvv = value;
    notifyListeners();
  }

}