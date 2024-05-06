import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arabakiralama/main.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:arabakiralama/anamenu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GirisYap extends StatelessWidget {
  const GirisYap({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Giriş yap',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const BilgiYaz(),
      ),
    );
  }
}

class BilgiYaz extends StatefulWidget {
  const BilgiYaz({super.key});

  @override
  State<BilgiYaz> createState() => _BilgiYazState();
}

class _BilgiYazState extends State<BilgiYaz> {
  String hata = "";

  String ad = "";
  String soyad = "";
  String tcno = "";
  String cinsiyet = "";
  DateTime dtarih = DateTime(0, 0, 0);
  String ehliyet = "";
  String telefonno = "";
  String mail = "";
  String sifre = "";

  String password = '';

  //ADRES BİLGİLERİ

  String il = "";
  String ilce = "";
  String mahalle = "";
  String cadde = "";
  String sokak = "";
  String apartmanno = "";
  String daireno = "";
  //ÖDEME BİLGİLERİ

  String kartno = "";
  String starih = "";
  String cvv = "";
  String kartisim = "";

  //ARABA & ARABA SAHİBİ BİLGİLERİ

  String marka = "";
  String model = "";
  String yil = "";
  String vites = "";
  String km = "";
  String motorgucu = "";
  String yakit = "";
  String hasarkaydi = "";
  String fiyat = "";
  String resim = "";
  String iban = "";
  String kaskono = "";
  String ruhsatseri = "";

  Future<void> girisYap(String email, String sifre ) async {
    try {
      var url =
          Uri.parse('http://*************girisyap'); // API endpoint'i
      var body = jsonEncode({
        'email': email,
        'sifre': sifre,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        hata = jsonResponse['message'];
        debugPrint('Veri durumu başarıyla kontrol edildi.');
        await kisiselGiris(email);
        await odemeGiris(email);
        await arabaGiris(email);
        Uint8List? arabaResim = await getArabaResim(email);
        if (arabaResim != null) {
          debugPrint("Resim verisi başarıyla alındı. (Resim bulundu!)");
        } else {
          debugPrint('Resim verisi başarıyla alındı. (Resim yok.)');
        }
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  Future<void> kisiselGiris(String email) async {
    try {
      var url = Uri.parse(
          'http://********/kisiselbilgigirisi'); // API endpoint'i
      var body = jsonEncode({
        'email': email,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        ad = jsonResponse['adbilgi'];
        soyad = jsonResponse['soyadbilgi'];
        tcno = jsonResponse['tcbilgi'];
        cinsiyet = jsonResponse['cinsiyetbilgi'];
        dtarih = DateTime.parse(jsonResponse['dtarihbilgi']);
        ehliyet = jsonResponse['ehliyetbilgi'];
        telefonno = jsonResponse['telefonbilgi'];
        mail = jsonResponse['mailbilgi'];
        sifre = jsonResponse['sifrebilgi'];

        il = jsonResponse['ilbilgi'];
        ilce = jsonResponse['ilcebilgi'];
        mahalle = jsonResponse['mahallebilgi'];
        cadde = jsonResponse['caddebilgi'];
        sokak = jsonResponse['sokakbilgi'];
        apartmanno = jsonResponse['apartmannobilgi'];
        daireno = jsonResponse['dairenobilgi'];
        debugPrint('Kişisel bilgiler başarıyla alındı.');
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  Future<void> odemeGiris(String email) async {
    try {
      var url = Uri.parse(
          'http://192.168.1.113:3000/odemebilgigirisi'); // API endpoint'i
      var body = jsonEncode({
        'email': email,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        kartno = jsonResponse['kartbilgi'];
        starih = jsonResponse['starihbilgi'];
        cvv = jsonResponse['cvvbilgi'];
        kartisim = jsonResponse['kartisimbilgi'];
        debugPrint('Ödeme bilgileri başarılı bir şekilde alındı.');
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  Future<void> arabaGiris(String email) async {
    try {
      var url = Uri.parse(
          'http://*********/arababilgigirisi'); // API endpoint'i
      var body = jsonEncode({
        'email': email,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        marka = jsonResponse['markabilgi'];
        model = jsonResponse['modelbilgi'];
        yil = jsonResponse['yilbilgi'];
        vites = jsonResponse['vitesbilgi'];
        km = jsonResponse['kmbilgi'];
        motorgucu = jsonResponse['motor_gucubilgi'];
        yakit = jsonResponse['yakitbilgi'];
        hasarkaydi = jsonResponse['hasar_kaydibilgi'];
        fiyat = jsonResponse['fiyatbilgi'];

        iban = jsonResponse['ibanbilgi'];
        kaskono = jsonResponse['kaskonobilgi'];
        ruhsatseri = jsonResponse['ruhsatseribilgi'];
        debugPrint('Araba bilgileri başarılı bir şekilde alındı.');
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  Future<Uint8List?> getArabaResim(String email) async {
    try {
      var url = Uri.parse(
          'http://********/arababilgigirisi'); // API endpoint'i
      var body = jsonEncode({
        'email': email,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        dynamic resimData = jsonResponse['resimbilgi'];
        if (resimData != null) {
          Uint8List? imageBytes =
              Uint8List.fromList(List<int>.from(resimData['data']));
          return imageBytes;
        } else {
          return null;
        }
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
      return null;
    }
  }

  final _mailController = TextEditingController();
  final _sifreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var girisYapProvider = Provider.of<DepoProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 80,
                child: TextFormField(
                  controller: _mailController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "E-mailinizi giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 80,
                child: TextFormField(
                  obscureText: true,
                  controller: _sifreController,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Şifrenizi Giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_mailController.text.isEmpty ||
                    _sifreController.text.isEmpty) {
                  setState(() {
                    hata = "Lütfen gerekli bilgileri giriniz...";
                  });
                } else {
                  await girisYap(_mailController.text, _sifreController.text);
                  if (hata == "") {
                    girisYapProvider.ad = ad;
                    girisYapProvider.soyad = soyad;
                    girisYapProvider.tcno = tcno;
                    girisYapProvider.cinsiyet = cinsiyet;
                    girisYapProvider.dogumtarihi = dtarih;
                    girisYapProvider.ehliyetno = ehliyet;
                    girisYapProvider.telno = telefonno;
                    girisYapProvider.mail = mail;
                    girisYapProvider.sifre = sifre;

                    girisYapProvider.il = il;
                    girisYapProvider.ilce = ilce;
                    girisYapProvider.mahalle = mahalle;
                    girisYapProvider.cadde = cadde;
                    girisYapProvider.sokak = sokak;
                    girisYapProvider.apartno = apartmanno;
                    girisYapProvider.daireno = daireno;

                    girisYapProvider.kartNo = kartno;
                    girisYapProvider.sonKullanmaTarihi = starih;
                    girisYapProvider.cvv = cvv;
                    girisYapProvider.kartIsim = kartisim;

                    girisYapProvider.marka = marka;
                    girisYapProvider.model = model;
                    girisYapProvider.vites = vites;
                    girisYapProvider.km = km;
                    girisYapProvider.motorGucu = motorgucu;
                    girisYapProvider.yakit = yakit;
                    girisYapProvider.hasarKaydi = hasarkaydi;
                    girisYapProvider.arabaKira = fiyat;
                    girisYapProvider.image = resim;
                    girisYapProvider.iban = iban;
                    girisYapProvider.kaskoNumarasi = kaskono;
                    girisYapProvider.ruhsatSeriNumarasi = ruhsatseri;
                    Navigator.pushAndRemoveUntil(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(builder: (context) => const AnaPanel()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    setState(() {
                      hata = hata;
                    });
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: const Text('Giriş Yap'),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hata,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Hesabınız yok mu?',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontStyle: FontStyle.italic),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KisiselPanel(),
                  ),
                );
              },
              child: const Text(
                'Hemen kayıt olun.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
