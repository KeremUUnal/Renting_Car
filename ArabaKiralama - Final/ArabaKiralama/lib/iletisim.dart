import 'package:arabakiralama/adres.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IletisimPanel extends StatelessWidget {
  const IletisimPanel({super.key});

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
            'İletişim Bilgileri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const IletisimBilgi(),
      ),
    );
  }
}

class IletisimBilgi extends StatefulWidget {
  const IletisimBilgi({super.key});

  @override
  State<IletisimBilgi> createState() => _IletisimBilgiState();
}

class _IletisimBilgiState extends State<IletisimBilgi> {
  String mailuyari = "";
  String teluyari = "";
  bool mailbool = false;
  bool telbool = false;
  Future<void> checkMail(String email) async {
    try {
      var url =
          Uri.parse('http://***********/mailkontrol'); // API endpoint'i
      var body = jsonEncode({
        'email': email,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        mailuyari = jsonResponse['message'];
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  Future<void> checkPhone(String telefonno) async {
    try {
      var url =
          Uri.parse('http://***********/telkontrol'); // API endpoint'i
      var body = jsonEncode({
        'telefon_no': telefonno,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        teluyari = jsonResponse['message'];
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  final _telefonController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var iletisimBilgiProvider =
        Provider.of<DepoProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  maxLength: 11,
                  controller: _telefonController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    label: const Text("Telefon Numarası"),
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
              visible: telbool,
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
                      teluyari,
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
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _emailController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  label: const Text("E-mail Adres"),
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
            Visibility(
              visible: mailbool,
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
                      mailuyari,
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (_emailController.text.isNotEmpty) {
                  await checkMail(_emailController.text);
                }
                if (_telefonController.text.length == 11) {
                  await checkPhone(_telefonController.text);
                }
                setState(() {
                  if (_emailController.text.isEmpty) {
                    mailuyari = "Lütfen e-mail alanını doldurunuz.";
                    mailbool = true;
                  } else if (mailuyari ==
                      "Girdiğiniz e-posta adresi zaten kullanılmış.") {
                    mailbool = true;
                  } else {
                    mailbool = false;
                  }
                  if (_telefonController.text.length != 11) {
                    teluyari =
                        "Lütfen telefon numaranızı uygun formatta giriniz.";
                    telbool = true;
                  } else if (teluyari ==
                      "Girdiğiniz telefon numarası zaten kullanılmış.") {
                    telbool = true;
                  } else {
                    telbool = false;
                  }
                });
                if (mailuyari == "" && teluyari == "") {
                  iletisimBilgiProvider.telno = _telefonController.text;
                  iletisimBilgiProvider.mail = _emailController.text;
                  Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const AdresPanel(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var tween = Tween(begin: begin, end: end);
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Devam Et'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
