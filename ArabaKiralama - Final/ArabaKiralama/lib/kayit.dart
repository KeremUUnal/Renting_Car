import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:arabakiralama/anamenu.dart';

class KayitPanel extends StatelessWidget {
  const KayitPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        // ignore: deprecated_member_use
        builder: (context) => WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              centerTitle: true,
              title: const Text(
                'Kullanıcı Bilgileri',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: const KayitBilgi(),
          ),
        ),
      ),
    );
  }
}

class KayitBilgi extends StatefulWidget {
  const KayitBilgi({super.key});

  @override
  State<KayitBilgi> createState() => _KayitBilgiState();
}

class _KayitBilgiState extends State<KayitBilgi> {
  Future<void> kullaniciData(
      String ad,
      String soyad,
      String tckimlik,
      String cinsiyet,
      String dogumTarihi,
      String ehliyetno,
      String telno,
      String email,
      String sifre) async {
    try {
      var url =
          Uri.parse('http://*********/kisiselbilgiler'); // API endpoint'i
      var body = jsonEncode({
        'ad': ad,
        'soyad': soyad,
        'tc_kimlik': tckimlik,
        'cinsiyet': cinsiyet,
        'dogum_tarihi': dogumTarihi,
        'ehliyet_serino': ehliyetno,
        'telefon_no': telno,
        'email': email,
        'sifre': sifre
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        // Başarılı yanıt
        debugPrint('Veri başarıyla eklendi: ${response.body}');
      } else {
        // Hatalı yanıt
        debugPrint('Hata: ${response.reasonPhrase}');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  Future<void> adresData(String il, String ilce, String mahalle, String cadde,
      String sokak, String apartmanno, String daireno) async {
    try {
      var url =
          Uri.parse('http://***********/adresbilgileri'); // API endpoint'i
      var body = jsonEncode({
        'il': il,
        'ilce': ilce,
        'mahalle': mahalle,
        'cadde': cadde,
        'sokak': sokak,
        'apartmanno': apartmanno,
        'daireno': daireno,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        // Başarılı yanıt
        debugPrint('Veri başarıyla eklendi: ${response.body}');
      } else {
        // Hatalı yanıt
        debugPrint('Hata: ${response.reasonPhrase}');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  String? errorcontrol = "";
  String password = '';
  final _sifreController = TextEditingController();
  final _dogrulaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var kayitBilgiProvider = Provider.of<DepoProvider>(context);
    var mailYaziProvider = Provider.of<DepoProvider>(context);
    var aktarimProvider = Provider.of<DepoProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  enabled: false,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    label: Text(mailYaziProvider.mail),
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
                height: 70,
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  obscureText: true,
                  controller: _dogrulaController,
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_sifreController.text.isNotEmpty &&
                      _dogrulaController.text.isNotEmpty) {
                    if (_sifreController.text == _dogrulaController.text) {
                      debugPrint("Kayıt İşlemi Başarılı!");
                      errorcontrol = "";

                      kayitBilgiProvider.sifre = _sifreController.text;
                      adresData(
                          aktarimProvider.il,
                          aktarimProvider.ilce,
                          aktarimProvider.mahalle,
                          aktarimProvider.cadde,
                          aktarimProvider.sokak,
                          aktarimProvider.apartno,
                          aktarimProvider.daireno);
                      kullaniciData(
                        aktarimProvider.ad,
                        aktarimProvider.soyad,
                        aktarimProvider.tcno,
                        aktarimProvider.cinsiyet,
                        aktarimProvider.dogumtarihi.toString(),
                        aktarimProvider.ehliyetno,
                        aktarimProvider.telno,
                        aktarimProvider.mail,
                        aktarimProvider.sifre,
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnaPanel()),
                            (Route<dynamic> route) => false,
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Kayıt işleminiz Tamamlanmıştır.",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Mesaj kutusunu kapat
                                },
                                child: const Text("Tamam"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      errorcontrol = "Girdiğiniz şifre ile doğrulama uymuyor.";
                    }
                  } else {
                    errorcontrol = "Lütfen bir şifre belirleyiniz.";
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Kaydet'),
            ),
            Text(
              errorcontrol!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
