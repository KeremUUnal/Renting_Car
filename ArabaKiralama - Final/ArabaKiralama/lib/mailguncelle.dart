import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MailGuncellePanel extends StatelessWidget {
  const MailGuncellePanel({super.key});

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
            'E-mail Adresini Güncelle',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const MailGuncelle(),
      ),
    );
  }
}

class MailGuncelle extends StatefulWidget {
  const MailGuncelle({super.key});

  @override
  State<MailGuncelle> createState() => _MailGuncelleState();
}

class _MailGuncelleState extends State<MailGuncelle> {
  final _yenimailController = TextEditingController();
  Future<void> mailGuncelle(String mail, String tckimlik) async {
    try {
      var url =
          Uri.parse('http://*--**********/maildegistir'); // API endpoint'i
      var body = jsonEncode({
        'email': mail,
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
    var mailGuncelleProvider =
        Provider.of<DepoProvider>(context, listen: false);
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
                  label: Text(mailGuncelleProvider.mail),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _yenimailController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  label: const Text("Yeni E-mail Adresiniz"),
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
                if (_yenimailController.text.isNotEmpty &&
                    _yenimailController.text != mailGuncelleProvider.mail) {
                  mailGuncelle(
                      _yenimailController.text, mailGuncelleProvider.tcno);
                  mailGuncelleProvider.mail = _yenimailController.text;
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "E-mail adresiniz başarılı bir şekilde güncellenmiştir.",
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
              child: const Text("Güncelle"),
            ),
          ],
        ),
      ),
    );
  }
}
