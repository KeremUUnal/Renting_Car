import 'package:arabakiralama/iletisim.dart';
import 'package:flutter/material.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EhliyetPanel extends StatelessWidget {
  const EhliyetPanel({super.key});

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
            'Ehliyet Bilgileri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const EhliyetBilgi(),
      ),
    );
  }
}

class EhliyetBilgi extends StatefulWidget {
  const EhliyetBilgi({super.key});

  @override
  State<EhliyetBilgi> createState() => _EhliyetBilgiState();
}

class _EhliyetBilgiState extends State<EhliyetBilgi> {
  final _ehliyetController = TextEditingController();
  bool buttonActive = true;
  double alan = 300;
  String ehliyetuyari = "";
  bool ehliyetbool = false;
  String ehliyettext = "Ehliyet Seri Numarası";
  Future<void> checkLicense(String serino) async {
    try {
      var url =
          Uri.parse('http://*******/ehliyetkontrol'); // API endpoint'i
      var body = jsonEncode({
        'ehliyet_serino': serino,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        ehliyetuyari = jsonResponse['message'];
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var ehliyetBilgiProvider = Provider.of<DepoProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  controller: _ehliyetController,
                  onChanged: (value) {
                    ehliyetBilgiProvider.ehliyetno = value;
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    label: const Text("Ehliyet Seri Numarası"),
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
              visible: ehliyetbool,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  const Padding(
                    padding: EdgeInsets.only(top: 2.6),
                    child: Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      ehliyetuyari,
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
                if (_ehliyetController.text.length == 6) {
                  await checkLicense(_ehliyetController.text);
                }
                setState(() {
                  if (_ehliyetController.text.length != 6) {
                    ehliyetuyari =
                        "Lütfen sürücü sicil numaranızı 6 haneli olacak şekilde giriniz.";
                    ehliyetbool = true;
                    alan = 260;
                  } else if (ehliyetuyari ==
                      "Girdiğiniz seri numarası, kimlik bilgilerinizdeki ile uyuşmuyor.") {
                    ehliyetbool = true;
                    alan = 260;
                  } else {
                    ehliyetbool = false;
                    alan = 300;
                  }
                });
                if (ehliyetuyari == "") {
                  ehliyetBilgiProvider.ehliyetno = _ehliyetController.text;
                  Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const IletisimPanel(),
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
            SizedBox(
              height: alan,
            ),
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
                    'Sürücü belgenizin ön yüzünün 5. maddesinde\nbulunan 6 haneli "Sürücü Sicil Numarası" kodunu\ngirmeniz gerekmektedir.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
