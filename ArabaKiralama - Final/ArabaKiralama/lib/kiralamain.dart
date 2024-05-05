import 'package:arabakiralama/kirabilgiDepo.dart';
import 'package:flutter/material.dart';
import 'package:arabakiralama/kiralamaIslem.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KiraArayuz extends StatelessWidget {
  final String ruhsatbilgi;

  const KiraArayuz({super.key, required this.ruhsatbilgi});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Kira Arayüz',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: BilgiYaz(
          ruhsatbilgi: ruhsatbilgi,
        ),
      ),
    );
  }
}

class BilgiYaz extends StatefulWidget {
  final String ruhsatbilgi;

  const BilgiYaz({super.key, required this.ruhsatbilgi});

  @override
  State<BilgiYaz> createState() => _BilgiYazState();
}

class _BilgiYazState extends State<BilgiYaz> {
  String marka = "";
  String model = "";
  String yil = "";
  String vites = "";
  String km = "";
  String motorgucu = "";
  String yakit = "";
  String hasarkaydi = "";
  String fiyat = "";
  String ruhsatseri = "895655";
  String ad = "";
  String soyad = "";
  String telefon = "";
  String il = "";
  String ilce = "";
  String mahalle = "";
  String cadde = "";
  String sokak = "";
  String apartmanno = "";

  Future<void> arabacekData(String ruhsat) async {
    try {
      var url = Uri.parse(
          'http://***********/arababilgicek'); // API endpoint'i
      var body = jsonEncode({
        'ruhsatseri_no': ruhsat,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        marka = jsonResponse['markabilgi'];
        model = jsonResponse['modelbilgi'];
        yil = jsonResponse['yilbilgi'];
        vites = jsonResponse['vitesbilgi'];
        km = jsonResponse['kmbilgi'];
        motorgucu = jsonResponse['motor_gucubilgi'];
        yakit = jsonResponse['yakitbilgi'];
        hasarkaydi = jsonResponse['hasar_kaydibilgi'];
        fiyat = jsonResponse['fiyatbilgi'];
        ad = jsonResponse['adbilgi'];
        soyad = jsonResponse['soyadbilgi'];
        telefon = jsonResponse['telefonbilgi'];
        il = jsonResponse['sehirbilgi'];
        ilce = jsonResponse['ilcebilgi'];
        mahalle = jsonResponse['mahallebilgi'];
        cadde = jsonResponse['caddebilgi'];
        sokak = jsonResponse['sokakbilgi'];
        apartmanno = jsonResponse['apartmannobilgi'];
        debugPrint('Veriler başarıyla alındı');
        // Başarılı yanıt
      } else {
        // Hatalı yanıt
        throw Exception('Sunucudan yanıt alınamadı');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: arabacekData(widget.ruhsatbilgi),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Hata: ${snapshot.error}');
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Image.memory(base64Decode(snapshot.data!)),
                      const SizedBox(height: 16),
                      Text('Kişisel Bilgiler',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: '$ad $soyad',
                        decoration: const InputDecoration(
                          labelText: 'İsim Soyisim',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () {}, // Boş bir işlev
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: telefon,
                        decoration: const InputDecoration(
                          labelText: 'Telefon',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () {}, // Boş bir işlev
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue:
                            '$mahalle Mahallesi $cadde Caddesi $sokak Sokak Apartman No: $apartmanno $il / $ilce',
                        decoration: const InputDecoration(
                          labelText: 'Adres',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () {}, // Boş bir işlev
                      ),
                      const SizedBox(height: 16),
                      Text('Araba Bilgileri',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Marka:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: marka,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Model:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: model,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Yıl:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: yil,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text('Vites:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: vites,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Km:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: km,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text('Motor Gücü:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: motorgucu,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Yakıt:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: yakit,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text('Hasar Kaydı:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: hasarkaydi,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Fiyat:'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: fiyat,
                              readOnly: true,
                              onTap: () {}, // Boş bir işlev
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        KiralamaIslem(ruhsatkontrol: widget.ruhsatbilgi,),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Kirala'),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }
            }),
      ),
    );
  }
}
