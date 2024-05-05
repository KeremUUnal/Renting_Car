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

  String _sonKullanmaTarihi = "";

  String get sonKullanmaTarihi => _sonKullanmaTarihi;

  set sonKullanmaTarihi(String value) {
    _sonKullanmaTarihi = value;
    notifyListeners();
  }

  String _cvv = '';

  String get cvv => _cvv;

  set cvv(String value) {
    _cvv = value;
    notifyListeners();
  }

  //_______________________ARABA BİLGİLERİ____________________
  String _kaskoNumarasi = '';

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

  String _yil = '';

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
  DateTime _baslangic_tarihi = DateTime(0, 0, 0);

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


