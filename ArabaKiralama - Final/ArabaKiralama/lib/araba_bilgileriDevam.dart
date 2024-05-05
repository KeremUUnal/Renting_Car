// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'arababilgileri.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:arabakiralama/anamenu.dart';

class ArabaBilgileriDevam extends StatelessWidget {
  const ArabaBilgileriDevam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Araba Bilgileri',
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
  Future<void> arabaData(
      String marka,
      String model,
      String yil,
      String vites,
      String km,
      String motorgucu,
      String yakit,
      String hasarkaydi,
      String fiyat,
      String image) async {
    try {
      var url = Uri.parse(
          'http://********/arababilgileri'); // API endpoint'i
      var body = jsonEncode({
        'marka': marka,
        'model': model,
        'yil': yil,
        'vites': vites,
        'km': km,
        'motor_gucu': motorgucu,
        'yakit': yakit,
        'hasar_kaydi': hasarkaydi,
        'fiyat': fiyat,
        'image': image,
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

  Future<void> sahipData(
      String iban, String kaskono, String ruhsatserino, String tckimlik) async {
    try {
      var url = Uri.parse(
          'http://**********/arabasahibibilgileri'); // API endpoint'i
      var body = jsonEncode({
        'iban': iban,
        'kasko_no': kaskono,
        'ruhsatseri_no': ruhsatserino,
        'tc_kimlik': tckimlik
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

  final _yakitController = TextEditingController();
  final _hasarKaydiController = TextEditingController();
  final _arabaKiraController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File file = File(image.path);
      final Uint8List bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var arabaBlgDvmProvider = Provider.of<DepoProvider>(context, listen: false);
    var arabaAktarmaProvider =
        Provider.of<DepoProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: SizedBox(
                        height: 70,
                        child: TextFormField(
                          controller: _yakitController,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: "Yakıt",
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
                    height: 70,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: SizedBox(
                        height: 70,
                        child: TextFormField(
                          controller: _hasarKaydiController,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: "Hasar Kaydı",
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
                  keyboardType: TextInputType.number,
                  controller: _arabaKiraController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Arabanın Günlük Kira Fiyatı",
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
              height: 45,
            ),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Fotoğraf Yükle'),
            ),
            if (_imageBytes != null)
              Image.memory(
                _imageBytes!,
                width: 200,
                height: 200,
              ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 115,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ArabaBilgileri()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Geri Git'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_yakitController.text.isNotEmpty &&
                        _hasarKaydiController.text.isNotEmpty &&
                        _arabaKiraController.text.isNotEmpty &&
                        _imageBytes != null) {
                      arabaBlgDvmProvider.yakit = _yakitController.text;
                      arabaBlgDvmProvider.hasarKaydi =
                          _hasarKaydiController.text;
                      arabaBlgDvmProvider.arabaKira = _arabaKiraController.text;

                      if (_imageBytes != null) {
                        final String base64Image = base64Encode(_imageBytes!);

                        await arabaData(
                          arabaAktarmaProvider.marka,
                          arabaAktarmaProvider.model,
                          arabaAktarmaProvider.yil,
                          arabaAktarmaProvider.vites,
                          arabaAktarmaProvider.km,
                          arabaAktarmaProvider.motorGucu,
                          arabaAktarmaProvider.yakit,
                          arabaAktarmaProvider.hasarKaydi,
                          arabaAktarmaProvider.arabaKira,
                          base64Image, // image değişkeni yerine base64Image kullanıyoruz
                        );
                      } else {
                        debugPrint('Fotoğraf seçilmedi');
                      }

                     await sahipData(
                          arabaAktarmaProvider.iban,
                          arabaAktarmaProvider.kaskoNumarasi,
                          arabaAktarmaProvider.ruhsatSeriNumarasi,
                          arabaAktarmaProvider.tcno);
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnaPanel(),
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Artık bir araba sahibi olarak kayıt oldunuz. Artık kendi arabanızı kiraya verebilirsiniz.",
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Kaydet'),
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
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
                    '"Fotoğraf Yükle" tuşuna basarak arabanıza ait fotoğrafı yükleyiniz ardından "Kaydet" tuşuna bastığınız an arabanınız sisteme yüklenir ve kiralanmak üzere herkese açık şekilde görünür.',
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
