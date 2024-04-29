import 'dart:io';
import 'dart:typed_data';
import 'package:araba_shb_md_araba_bilgileri/main.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'araba_bilgileri.dart';
import 'package:araba_shb_md_araba_bilgileri/arabaDepo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
class arabaBilgileriDevam extends StatelessWidget {
  const arabaBilgileriDevam({Key? key});

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
  const BilgiYaz({Key? key});

  @override
  State<BilgiYaz> createState() => _BilgiYazState();
}

class _BilgiYazState extends State<BilgiYaz> {
  List<XFile>? _images;
  Future<void> arabaData(String marka, String model, String yil, String vites,
      String km, String motor_gucu, String yakit, String hasar_kaydi, String fiyat, String image) async {
    try {
      var url = Uri.parse(
          'http://******/arababilgileri'); // API endpoint'i
      var body = jsonEncode({
        'marka': marka,
        'model': model,
        'yil': yil,
        'vites': vites,
        'km': km,
        'motor_gucu': motor_gucu,
        'yakit': yakit,
        'hasar_kaydi': hasar_kaydi,
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
  Future<void> sahipData(String iban, String kasko_no, String ruhsatseri_no) async {
    try {
      var url = Uri.parse(
          'http://*********/arabasahibibilgileri'); // API endpoint'i
      var body = jsonEncode({
        'iban': iban,
        'kasko_no': kasko_no,
        'ruhsatseri_no': ruhsatseri_no ,

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
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File file = File(image.path);
      final Uint8List bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
      String base64Image = base64Encode(bytes);
      // Şimdi base64Image değişkeninde fotoğrafın base64 formatındaki verisi var, bu veriyi API'nize gönderebilirsiniz
    }
  }
  Future<void> _uploadImage() async {
    if (_imageBytes != null) {
      final String base64Image = base64Encode(_imageBytes!);
      try {
        var url = Uri.parse('http://192.168.1.113:3000/arababilgileri');
        var body = jsonEncode({
          'image': base64Image,
          // Diğer alanları da ekleyebilirsiniz
        });

        var response = await http.post(url, body: body, headers: {
          'Content-Type': 'application/json',
        });

        if (response.statusCode == 200) {
          debugPrint('Veri başarıyla eklendi: ${response.body}');
        } else {
          debugPrint('Hata: ${response.reasonPhrase}');
        }
      } catch (error) {
        debugPrint('İstek sırasında bir hata oluştu: $error');
      }
    } else {
      debugPrint('Fotoğraf seçilmedi');
    }
  }



  Future<void> _getImages() async {
    final imagePicker = ImagePicker();
    final List<XFile>? pickedFiles = await imagePicker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var arabaBlgDvmProvider = Provider.of<ArabaDepo>(context, listen: false);
    var arabaAktarmaProvider = Provider.of<ArabaDepo>(context, listen: false);
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
                const SizedBox(width: 115,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const arabaBilgileri()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Geri Git'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
    if(_yakitController.text.isNotEmpty && _hasarKaydiController.text.isNotEmpty && _arabaKiraController.text.isNotEmpty && _imageBytes != null) {
    arabaBlgDvmProvider.yakit = _yakitController.text;
    arabaBlgDvmProvider.hasarKaydi = _hasarKaydiController.text;
    arabaBlgDvmProvider.arabaKira = _arabaKiraController.text;

    if (_imageBytes != null) {
    final String base64Image = base64Encode(_imageBytes!);

    arabaData(
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

    sahipData(
    arabaAktarmaProvider.iban,
    arabaAktarmaProvider.kaskoNumarasi,
    arabaAktarmaProvider.ruhsatSeriNumarasi,
    );
    }
    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
