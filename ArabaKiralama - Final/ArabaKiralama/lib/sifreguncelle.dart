import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SifreGuncellePanel extends StatelessWidget {
  const SifreGuncellePanel({super.key});

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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Şifre Değiştirme Paneli',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const SifreGuncelle(),
      ),
    );
  }
}

class SifreGuncelle extends StatefulWidget {
  const SifreGuncelle({super.key});

  @override
  State<SifreGuncelle> createState() => _SifreGuncelleState();
}

class _SifreGuncelleState extends State<SifreGuncelle> {
  String password = '';
  bool guncelsifre = false;
  bool aktiflik = true;
  bool uyarimesaj = false;
  final _eskisifreController = TextEditingController();

  final _yenisifreController = TextEditingController();
  final _yenidogrulaController = TextEditingController();

  Future<void> sifreDegistir(String sifre, String tckimlik) async {
    try {
      var url =
          Uri.parse('http://*************/sifredegistir'); // API endpoint'i
      var body = jsonEncode({
        'sifre': sifre,
        'tc_kimlik': tckimlik,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        debugPrint("İşlem Başarılı!");
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var sifreDogrula = Provider.of<DepoProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: true,
                controller: _eskisifreController,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Mevcut şifreniz",
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
            ElevatedButton(
              onPressed: aktiflik
                  ? () {
                      setState(() {
                        if (_eskisifreController.text == sifreDogrula.sifre) {
                          guncelsifre = true;
                          aktiflik = false;
                          uyarimesaj = false;
                        } else {
                          guncelsifre = false;
                          aktiflik = true;
                          uyarimesaj = true;
                        }
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Doğrula"),
            ),
            const SizedBox(height: 8),
            Visibility(
              visible: uyarimesaj,
              child: const Text(
                'Hatalı Şifre.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: guncelsifre,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _yenisifreController,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Yeni şifreniz",
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
            Visibility(
              visible: guncelsifre,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _yenidogrulaController,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Şifrenizi doğrulayınız",
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
            Visibility(
              visible: guncelsifre,
              child: ElevatedButton(
                onPressed: () {
                  if (_yenisifreController.text ==
                          _yenidogrulaController.text &&
                      _eskisifreController.text != _yenisifreController.text) {
                    sifreDogrula.sifre = _yenisifreController.text;
                    sifreDegistir(_yenisifreController.text, sifreDogrula.tcno);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Şifreniz başarılı bir şekilde değiştirilmiştir.",
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
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Değiştir"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
