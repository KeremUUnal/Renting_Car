import 'package:flutter/material.dart';
import 'ehliyetbilgi.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DepoProvider(),
      child: const KisiselPanel(),
    ),
  );
}

class KisiselPanel extends StatelessWidget {
  const KisiselPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        // ignore: deprecated_member_use
        builder: (context) => WillPopScope(
          onWillPop: () async {
            // Kullanıcı geri tuşuna bastığında yapılacak işlemler burada
            // Diyalog kutusunu doğrudan göstermek yerine showDialog fonksiyonunu kullanmadan işlem yapabiliriz
            final result = await _showExitConfirmationDialog(context);
            // Kullanıcı "Evet" düğmesine basarsa uygulamadan çıkma işlemini gerçekleştiririz
            if (result == true) {
              return true; // Varsayılan geri tuşu işlemini gerçekleştir
            } else {
              return false; // Varsayılan geri tuşu işlemini iptal et
            }
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
            body: const KullaniciKaydi(),
          ),
        ),
      ),
    );
  }
}

Future<bool?> _showExitConfirmationDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Uygulamadan çıkmak istiyor musunuz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Hayır'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Evet'),
        ),
      ],
    ),
  );
}

class KullaniciKaydi extends StatefulWidget {
  const KullaniciKaydi({super.key});

  @override
  State<KullaniciKaydi> createState() => _KullaniciKaydiState();
}

class _KullaniciKaydiState extends State<KullaniciKaydi> {
  String tcuyari =
      "Lütfen T.C. kimlik numaranızı 11 haneli olacak şekilde giriniz.";
  Future<void> checkTC(String tckimlik) async {
    try {
      var url = Uri.parse('http://***************/tckontrol'); // API endpoint'i
      var body = jsonEncode({
        'tc_kimlik': tckimlik,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        tcuyari = jsonResponse['message'];
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  String? secilenCinsiyet = "Cinsiyet";
  DateTime? secilenTarih;
  bool warning = false;
  bool general = false;
  final _adController = TextEditingController();
  final _soyadController = TextEditingController();
  final _kimlikController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var kisiselBilgiProvider =
        Provider.of<DepoProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        controller: _adController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Ad"),
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
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _soyadController,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        label: const Text("Soyad"),
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
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                maxLength: 11,
                keyboardType: TextInputType.number,
                controller: _kimlikController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  label: const Text("T.C. Kimlik Numarası"),
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
              visible: warning,
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
                      tcuyari,
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(secilenCinsiyet!),
                      items: <String>['Erkek', 'Kadın'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          secilenCinsiyet = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            secilenTarih = pickedDate;
                          });
                        }
                      },
                      child: Text(secilenTarih == null
                          ? 'Doğum Tarihi'
                          : '${secilenTarih!.day}/${secilenTarih!.month}/${secilenTarih!.year}'),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (_kimlikController.text.length == 11) {
                  await checkTC(_kimlikController.text);
                } else {
                  tcuyari =
                      "Lütfen T.C. kimlik numaranızı 11 haneli olacak şekilde giriniz.";
                }
                setState(() {
                  if (_kimlikController.text.length != 11) {
                    warning = true;
                  } else if (tcuyari ==
                      "Girdiğiniz T.C. kimlik numarası daha önce kullanılmış.") {
                    warning = true;
                  } else {
                    warning = false;
                  }
                  if (_adController.text.isNotEmpty &&
                      _soyadController.text.isNotEmpty &&
                      _kimlikController.text.isNotEmpty &&
                      (secilenCinsiyet == "Erkek" ||
                          secilenCinsiyet == "Kadın") &&
                      secilenTarih != null) {
                    general = false;
                  } else {
                    general = true;
                  }
                });
                if (_kimlikController.text.length == 11 &&
                    tcuyari !=
                        "Girdiğiniz T.C. kimlik numarası daha önce kullanılmış." &&
                    _adController.text.isNotEmpty &&
                    _soyadController.text.isNotEmpty &&
                    (secilenCinsiyet == "Erkek" ||
                        secilenCinsiyet == "Kadın") &&
                    secilenTarih != null) {
                  kisiselBilgiProvider.ad = _adController.text;
                  kisiselBilgiProvider.soyad = _soyadController.text;
                  kisiselBilgiProvider.tcno = _kimlikController.text;
                  kisiselBilgiProvider.cinsiyet = secilenCinsiyet!;
                  kisiselBilgiProvider.dogumtarihi = secilenTarih!;
                  debugPrint(kisiselBilgiProvider.mail);
                  Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const EhliyetPanel(),
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
            Visibility(
              visible: general,
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.only(top: 2.6),
                    child: Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 19,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Lütfen tüm bilgileri eksiksiz bir şekilde doldurunuz.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
