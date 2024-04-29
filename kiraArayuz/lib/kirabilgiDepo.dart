import 'package:flutter/material.dart';

class kirabilgiDepo extends ChangeNotifier {
  String _kaskoNumarasi = '' ;

  String get kaskoNumarasi => _kaskoNumarasi;

  set kaskoNumarasi(String value) {
    _kaskoNumarasi = value;
    notifyListeners();
  }
  String _ruhsatSeriNumarasi = '';

  String get ruhsatSeriNumarasi => _ruhsatSeriNumarasi;

  set ruhsatSeriNumarasi(String value) {
    _ruhsatSeriNumarasi = value;
    notifyListeners();
  }
  String _iban = '';

  String get iban => _iban;

  set iban(String value) {
    _iban = value;
    notifyListeners();
  }
  String _marka = '';

  String get marka => _marka;

  set marka(String value) {
    _marka = value;
    notifyListeners();
  }
  String _model = '';

  String get model => _model;

  set model(String value) {
    _model = value;
    notifyListeners();
  }
  String _yil = '' ;

  String get yil => _yil;

  set yil(String value) {
    _yil = value;
    notifyListeners();
  }
  String _vites = '';

  String get vites => _vites;

  set vites(String value) {
    _vites = value;
    notifyListeners();
  }
  String _km = '';

  String get km => _km;

  set km(String value) {
    _km = value;
    notifyListeners();
  }
  String _motorGucu = '';

  String get motorGucu => _motorGucu;

  set motorGucu(String value) {
    _motorGucu = value;
    notifyListeners();
  }
  String _yakit = '';

  String get yakit => _yakit;

  set yakit(String value) {
    _yakit = value;
    notifyListeners();
  }
  String _hasarKaydi = '';

  String get hasarKaydi => _hasarKaydi;

  set hasarKaydi(String value) {
    _hasarKaydi = value;
    notifyListeners();
  }
  String _arabaKira = '';

  String get arabaKira => _arabaKira;

  set arabaKira(String value) {
    _arabaKira = value;
    notifyListeners();
  }
  String _image = '';

  String get image => _image;

  set image(String value) {
    _image = value;
    notifyListeners();
  }
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
DateTime _baslangic_tarihi = DateTime(0,0,0);

  DateTime get baslangic_tarihi => _baslangic_tarihi;

  set baslangic_tarihi(DateTime value) {
    _baslangic_tarihi = value;
    notifyListeners();
  }
  DateTime _bitis_tarihi = DateTime(0,0,0);

  DateTime get bitis_tarihi => _bitis_tarihi;

  set bitis_tarihi(DateTime value) {
    _bitis_tarihi = value;
    notifyListeners();
  }

}
