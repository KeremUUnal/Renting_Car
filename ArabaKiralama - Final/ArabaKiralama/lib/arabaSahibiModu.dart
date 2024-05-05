// ignore_for_file: file_names

import 'package:arabakiralama/arababilgileri.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArabaSahibi extends StatelessWidget {
  const ArabaSahibi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Araba Sahibi Modu',
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
  String ruhsatkontrol = "";
  bool ruhsatbool = false;
  String kaskokontrol = "";
  bool kaskobool = false;
  Future<void> ruhsatData(String ruhsatserino) async {
    try {
      var url = Uri.parse(
          'http://**********/ruhsatnokontrol'); // API endpoint'i
      var body = jsonEncode({
        'ruhsatseri_no': ruhsatserino,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        ruhsatkontrol = jsonResponse['message'];
        // Başarılı yanıt
      } else {
        // Hatalı yanıt
        throw Exception('Sunucudan yanıt alınamadı');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  Future<void> kaskoData(String kaskono) async {
    try {
      var url =
          Uri.parse('http://********/kaskokontrol'); // API endpoint'i
      var body = jsonEncode({
        'kasko_no': kaskono,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        kaskokontrol = jsonResponse['message'];
        // Başarılı yanıt
      } else {
        // Hatalı yanıt
        throw Exception('Sunucudan yanıt alınamadı');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  final _kaskoController = TextEditingController();
  final _ruhsatController = TextEditingController();
  final _ibanController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var arabashbProvider = Provider.of<DepoProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 70,
              child: TextFormField(
                maxLength: 19,
                controller: _kaskoController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Kasko Numarası",
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
            visible: kaskobool,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                const Padding(
                  padding: EdgeInsets.only(top: 2.6),
                  child: Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 19,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    kaskokontrol,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 70,
              child: TextFormField(
                maxLength: 6,
                controller: _ruhsatController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Ruhsat Seri Numarası",
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
            visible: ruhsatbool,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                const Padding(
                  padding: EdgeInsets.only(top: 2.6),
                  child: Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 19,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ruhsatkontrol,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 70,
              child: TextFormField(
                maxLength: 26,
                controller: _ibanController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "IBAN",
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
          const SizedBox(height: 40.0),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Padding(
                padding: EdgeInsets.only(top: 2.6),
                child: Icon(
                  Icons.info,
                  size: 19,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Girilmesi zorunlu bilgilerdir. Arabanızı uygulamaya eklemek için alanları doldurunuz',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              if (_ruhsatController.text.isNotEmpty) {
                await ruhsatData(_ruhsatController.text);
              }
              if (_kaskoController.text.isNotEmpty) {
                await kaskoData(_kaskoController.text);
              }
              setState(() {
                if (_ruhsatController.text.isEmpty) {
                  ruhsatkontrol = "Ruhsat Seri Numarasını doldurunuz.";
                  ruhsatbool = true;
                } else if (ruhsatkontrol ==
                    "Girdiğiniz ruhsat seri numarası daha önce kullanılmış.") {
                  ruhsatbool = true;
                } else {
                  ruhsatbool = false;
                }

                if (_kaskoController.text.isEmpty) {
                  kaskokontrol = "Kasko Numarası doldurunuz.";
                  kaskobool = true;
                } else if (kaskokontrol ==
                    "Girdiğiniz kasko numarası daha önce kullanılmış.") {
                  kaskobool = true;
                } else {
                  kaskobool = false;
                }
              });
              if (ruhsatkontrol == "" &&
                  kaskokontrol == "" &&
                  _ibanController.text.length == 26) {
                arabashbProvider.kaskoNumarasi = _kaskoController.text;
                arabashbProvider.ruhsatSeriNumarasi = _ruhsatController.text;
                arabashbProvider.iban = _ibanController.text;

                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ArabaBilgileri()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Devam Et'),
          ),
        ]),
      ),
    );
  }
}
