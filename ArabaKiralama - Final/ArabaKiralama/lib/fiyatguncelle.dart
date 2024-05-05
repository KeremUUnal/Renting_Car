import 'package:arabakiralama/anamenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class fiyatguncelpanel extends StatelessWidget {
  const fiyatguncelpanel({super.key});

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
            'Yeni kira fiyatını değiştir',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const Fiyatguncel(),
      ),
    );
  }
}

class Fiyatguncel extends StatefulWidget {
  const Fiyatguncel({super.key});

  @override
  State<Fiyatguncel> createState() => _FiyatguncelState();
}

class _FiyatguncelState extends State<Fiyatguncel> {
  final _fiyatController = TextEditingController();
  Future<void> fiyatguncelle(String fiyat, String ruhsat) async {
    try {
      var url =
      Uri.parse('http://*************/fiyatdegistir'); // API endpoint'i
      var body = jsonEncode({
        'fiyat': fiyat,
        'ruhsatseri_no': ruhsat,
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
    var fiyatProvider = Provider.of<DepoProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                enabled: false,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  label: Text(fiyatProvider.arabaKira),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _fiyatController,

                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  label: const Text("Güncel fiyat"),
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
              onPressed: () {
                if (_fiyatController.text.isNotEmpty &&
                    _fiyatController.text != fiyatProvider.arabaKira) {
                  fiyatguncelle(
                      _fiyatController.text, fiyatProvider.ruhsatSeriNumarasi);
                  fiyatProvider.arabaKira = _fiyatController.text;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnaPanel(
                        // İlgili ilanın ruhsat numarasını kullan
                    ),
                    ),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Fiyatınız güncellenmiştir..",
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
          ],
        ),
      ),
    );
  }
}