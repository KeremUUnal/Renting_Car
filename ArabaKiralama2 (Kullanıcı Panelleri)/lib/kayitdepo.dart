import 'package:flutter/material.dart';

class DepoProvider extends ChangeNotifier {
  String _ad = '';

  String get ad => _ad;

  set ad(String value) {
    _ad = value;
    notifyListeners();
  }

  String _soyad = '';

  String get soyad => _soyad;

  set soyad(String value) {
    _soyad = value;
    notifyListeners();
  }

  String _tcno = '';

  String get tcno => _tcno;

  set tcno(String value) {
    _tcno = value;
    notifyListeners();
  }

  String _cinsiyet = '';

  String get cinsiyet => _cinsiyet;

  set cinsiyet(String value) {
    _cinsiyet = value;
    notifyListeners();
  }

  DateTime _dogumtarihi = DateTime(0, 0, 0);

  DateTime get dogumtarihi => _dogumtarihi;

  set dogumtarihi(DateTime value) {
    _dogumtarihi = value;
    notifyListeners();
  }

  String _ehliyetno = '';

  String get ehliyetno => _ehliyetno;

  set ehliyetno(String value) {
    _ehliyetno = value;
    notifyListeners();
  }

  String _telno = '';

  String get telno => _telno;

  set telno(String value) {
    _telno = value;
    notifyListeners();
  }

  String _mail = '';

  String get mail => _mail;

  set mail(String value) {
    _mail = value;
    notifyListeners();
  }

  String _il = '';

  String get il => _il;

  set il(String value) {
    _il = value;
    notifyListeners();
  }

  String _ilce = '';

  String get ilce => _ilce;

  set ilce(String value) {
    _ilce = value;
    notifyListeners();
  }

  String _mahalle = '';

  String get mahalle => _mahalle;

  set mahalle(String value) {
    _mahalle = value;
    notifyListeners();
  }

  String _cadde = '';

  String get cadde => _cadde;

  set cadde(String value) {
    _cadde = value;
    notifyListeners();
  }

  String _sokak = '';

  String get sokak => _sokak;

  set sokak(String value) {
    _sokak = value;
    notifyListeners();
  }

  String _apartno = '';

  String get apartno => _apartno;

  set apartno(String value) {
    _apartno = value;
    notifyListeners();
  }

  String _daireno = '';

  String get daireno => _daireno;

  set daireno(String value) {
    _daireno = value;
    notifyListeners();
  }

  String _sifre = '';

  String get sifre => _sifre;

  set sifre(String value) {
    _sifre = value;
    notifyListeners();
  }
}
