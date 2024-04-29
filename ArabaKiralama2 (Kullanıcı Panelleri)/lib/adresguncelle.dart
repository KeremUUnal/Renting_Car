import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdresGuncellePanel extends StatelessWidget {
  const AdresGuncellePanel({super.key});

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
            'Adres Bilgileri Güncelleme Paneli',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const AdresGuncelle(),
      ),
    );
  }
}

class AdresGuncelle extends StatefulWidget {
  const AdresGuncelle({super.key});

  @override
  State<AdresGuncelle> createState() => _AdresGuncelleState();
}

class _AdresGuncelleState extends State<AdresGuncelle> {
  final _ilController = TextEditingController();
  final _ilceController = TextEditingController();
  final _mahalleController = TextEditingController();
  final _caddeController = TextEditingController();
  final _sokakController = TextEditingController();
  final _apartController = TextEditingController();
  final _daireController = TextEditingController();
  Future<void> adresGuncelle(
      String il,
      String ilce,
      String mahalle,
      String cadde,
      String sokak,
      String apartno,
      String daireno,
      String tckimlik) async {
    try {
      var url =
          Uri.parse('http://***************/adresguncelle'); // API endpoint'i
      var body = jsonEncode({
        'il': il,
        'ilce': ilce,
        'mahalle': mahalle,
        'cadde': cadde,
        'sokak': sokak,
        'apartmanno': apartno,
        'daireno': daireno,
        'tc_kimlik': tckimlik
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
    var adresGuncelleProvider =
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
                        controller: _ilController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("İl"),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        controller: _ilceController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("İlçe"),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  controller: _mahalleController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    label: const Text("Mahalle"),
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        controller: _caddeController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Cadde"),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        controller: _sokakController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Sokak"),
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        controller: _apartController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Apartman No"),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        controller: _daireController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Daire No"),
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
            const SizedBox(height: 20),
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
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'Lütfen güncel adres bilgilerinizi eksiksiz bir şekilde doldurunuz.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_ilController.text.isNotEmpty &&
                    _ilceController.text.isNotEmpty &&
                    _mahalleController.text.isNotEmpty &&
                    _caddeController.text.isNotEmpty &&
                    _sokakController.text.isNotEmpty &&
                    _apartController.text.isNotEmpty &&
                    _daireController.text.isNotEmpty) {
                  if (_ilController.text != adresGuncelleProvider.il &&
                      _ilceController.text != adresGuncelleProvider.ilce &&
                      _mahalleController.text !=
                          adresGuncelleProvider.mahalle &&
                      _caddeController.text != adresGuncelleProvider.cadde &&
                      _sokakController.text != adresGuncelleProvider.sokak &&
                      _apartController.text != adresGuncelleProvider.apartno &&
                      _daireController.text != adresGuncelleProvider.daireno) {
                    adresGuncelle(
                        _ilController.text,
                        _ilceController.text,
                        _mahalleController.text,
                        _caddeController.text,
                        _sokakController.text,
                        _apartController.text,
                        _daireController.text,
                        adresGuncelleProvider.tcno);
                    adresGuncelleProvider.il = _ilController.text;
                    adresGuncelleProvider.ilce = _ilceController.text;
                    adresGuncelleProvider.mahalle = _mahalleController.text;
                    adresGuncelleProvider.cadde = _caddeController.text;
                    adresGuncelleProvider.sokak = _sokakController.text;
                    adresGuncelleProvider.apartno = _apartController.text;
                    adresGuncelleProvider.daireno = _daireController.text;

                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Adres bilgileriniz başarılı bir şekilde güncellenmiştir..",
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
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Devam Et'),
            ),
          ],
        ),
      ),
    );
  }
}
