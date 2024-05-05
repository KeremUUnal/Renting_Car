import 'dart:convert';
import 'package:arabakiralama/kullanicikategori.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;

class OdemeBilgileri extends StatelessWidget {
  const OdemeBilgileri({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Ödeme Bilgileri',
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
  Future<void> odemeData(String kartIsim, String kartno, String sonkullanma,
      String cvv, String tckimlik) async {
    try {
      var url = Uri.parse(
          'http://*************/odemebilgileri'); // API endpoint'i
      var body = jsonEncode({
        'kartIsim': kartIsim,
        'kart_no': kartno,
        'son_kullanma_tarihi': sonkullanma,
        'cvv': cvv,
        'tc_kimlik': tckimlik,
      });
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

  final _isimController = TextEditingController();
  final _kartNoController = TextEditingController();
  final _sonKullanmaController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var odemeBilgiProvider = Provider.of<DepoProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  controller: _isimController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Kartın Üstündeki İsim",
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
                  maxLength: 16,
                  controller: _kartNoController,
                  style: const TextStyle(fontSize: 20),

                  decoration: InputDecoration(

                    labelText: "Kart Numarası",
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
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _sonKullanmaController,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'MM/YY',
                      ),
                      onChanged: (text) {
                        if (text.length == 2 && !text.contains('/')) {
                          _sonKullanmaController.text = '$text/';
                          _sonKullanmaController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: _sonKullanmaController.text.length));
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      controller: _cvvController,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35.0),
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
                    'Kartınızın arka yüzündeki 3 haneli kodu "CVV" kısmına,\nön yüzündeki tarih kısmını da "Son Kullanma Tarihi" kısmına giriniz.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_isimController.text.isNotEmpty &&
                    _kartNoController.text.isNotEmpty &&
                    _sonKullanmaController.text.isNotEmpty &&
                    _cvvController.text.isNotEmpty) {
                  odemeBilgiProvider.kartIsim = _isimController.text;
                  odemeBilgiProvider.kartNo = _kartNoController.text;
                  odemeBilgiProvider.sonKullanmaTarihi =
                      _sonKullanmaController.text;
                  odemeBilgiProvider.cvv = _cvvController.text;

                  odemeData(
                    odemeBilgiProvider.kartIsim,
                    odemeBilgiProvider.kartNo,
                    odemeBilgiProvider.sonKullanmaTarihi,
                    odemeBilgiProvider.cvv,
                    odemeBilgiProvider.tcno,
                  );
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KategoriPanel(),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Ödeme bilgileriniz başarılı bir şekilde kaydedilmiştir.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Mesaj kutusunu kapat
                          },
                          child: const Text("Tamam"),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
