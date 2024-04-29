import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelGuncellePanel extends StatelessWidget {
  const TelGuncellePanel({super.key});

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
            'Telefon Numaranı Değiştir',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const TelGuncelle(),
      ),
    );
  }
}

class TelGuncelle extends StatefulWidget {
  const TelGuncelle({super.key});

  @override
  State<TelGuncelle> createState() => _TelGuncelleState();
}

class _TelGuncelleState extends State<TelGuncelle> {
  final _yenitelefonController = TextEditingController();
  Future<void> telGuncelle(String telno, String tckimlik) async {
    try {
      var url =
          Uri.parse('http://***************/telnodegistir'); // API endpoint'i
      var body = jsonEncode({
        'telefon_no': telno,
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
    var telGuncelleProvider = Provider.of<DepoProvider>(context, listen: false);
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
                  label: Text(telGuncelleProvider.telno),
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
                controller: _yenitelefonController,
                maxLength: 11,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  label: const Text("Yeni Telefon Numaranız"),
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
                if (_yenitelefonController.text.isNotEmpty &&
                    _yenitelefonController.text != telGuncelleProvider.telno) {
                  telGuncelle(
                      _yenitelefonController.text, telGuncelleProvider.tcno);
                  telGuncelleProvider.telno = _yenitelefonController.text;
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Telefon numaranız başarılı bir şekilde değiştirilmiştir.",
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
