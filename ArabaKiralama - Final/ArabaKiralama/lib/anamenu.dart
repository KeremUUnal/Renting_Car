import 'package:arabakiralama/arabaSahibiModu.dart';
import 'package:arabakiralama/arabam.dart';
import 'package:flutter/material.dart';
import 'package:arabakiralama/kullanicikategori.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:arabakiralama/kiralamain.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String genelarabauyari = "";

class AnaPanel extends StatelessWidget {
  const AnaPanel({super.key});

  Future<void> arabaGenelKontrol(String tckimlik) async {
    try {
      var url = Uri.parse(
          'http://*******/arabaverigenel'); // API endpoint'i
      var body = jsonEncode({
        'tc_kimlik': tckimlik,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        genelarabauyari = jsonResponse['message'];
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var arabaGenelProvider = Provider.of<DepoProvider>(context, listen: false);
    return MaterialApp(
      home: Builder(
        // ignore: deprecated_member_use
        builder: (context) => WillPopScope(
          onWillPop: () async {
            final result = await _showExitConfirmationDialog(context);
            if (result == true) {
              return true;
            } else {
              return false;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 33,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const KategoriPanel(),
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
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.car_rental,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await arabaGenelKontrol(arabaGenelProvider.tcno);
                    if (genelarabauyari != "") {
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              genelarabauyari,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: [],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Hayır",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const ArabaSahibi(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var tween =
                                              Tween(begin: begin, end: end);
                                          var offsetAnimation =
                                              animation.drive(tween);

                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                      ));
                                },
                                child: const Text(
                                  "Evet",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ArabamPanel()),
                      );
                    }
                  },
                ),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              centerTitle: true,
              title: const Text(
                'Car Rental',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: const AnaMenu(),
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
          onPressed: () {},
          child: const Text('Evet'),
        ),
      ],
    ),
  );
}

class AnaMenu extends StatefulWidget {
  const AnaMenu({super.key});

  @override
  State<AnaMenu> createState() => _AnaMenuState();
}

class _AnaMenuState extends State<AnaMenu> {
  String marka = "";
  String model = "";
  String yil = "";
  String vites = "";
  String km = "";

  // ignore: non_constant_identifier_names
  String motor_gucu = "";
  String yakit = "";

  // ignore: non_constant_identifier_names
  String hasar_kaydi = "";
  String fiyat = "";
  String ruhsatseri = "322655";
  String ruhsatseri2 = "899635";
  String ad = "";
  String soyad = "";
  String telefon = "";
  String il = "";
  String ilce = "";
  String mahalle = "";
  String cadde = "";
  String sokak = "";
  String apartmanno = "";

  Future<Map<String, dynamic>> arabacekData(String ruhsat) async {
    Map<String, dynamic> arabaBilgileri = {};

    try {
      var url = Uri.parse(
          'http://*********/arababilgicek'); // API endpoint'i
      var body = jsonEncode({
        'ruhsatseri_no': ruhsat,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        arabaBilgileri = jsonDecode(response.body);
        debugPrint('Veriler başarıyla alındı');
      } else {
        throw Exception('Sunucudan yanıt alınamadı');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }

    return arabaBilgileri;
  }

  List<String> ruhsatNumaralari = [];

  Future<void> ruhsatNumaralariniCek() async {
    try {
      var url = Uri.parse(
          'http://***********/tum_ruhsat_serileri'); // API endpoint'i
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          ruhsatNumaralari = List<String>.from(jsonDecode(response.body));
        });
        debugPrint('Ruhsat numaraları başarıyla alındı');
      } else {
        throw Exception('Sunucudan yanıt alınamadı');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    ruhsatNumaralariniCek();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Future.wait(ruhsatNumaralari
          .map((ruhsat) => arabacekData(ruhsat))
          .toList()), // Tüm Future'ların tamamlanmasını bekle
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Veri beklenirken dönen bir yükleniyor göstergesi göster
        } else if (snapshot.hasError) {
          return Text(
              'Hata: ${snapshot.error}'); // Hata oluştuysa hata mesajını göster
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _buildArabaIlan(
                  context,
                  snapshot.data![index],
                  ruhsatNumaralari[
                      index]); // API'den gelen verileri kullanarak ilan oluştur
            },
          );
        }
      },
    );
  }

  Widget _buildArabaIlan(
      BuildContext context, Map<String, dynamic> data, String ruhsat) {
    var kontrolProvider =
    Provider.of<DepoProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        onPressed: () {
          if(ruhsat == kontrolProvider.ruhsatSeriNumarasi) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ArabamPanel(
                    ),  // İlgili ilanın ruhsat numarasını kullan
              ),
             );
          }
          else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    KiraArayuz(
                        ruhsatbilgi:
                        ruhsat), // İlgili ilanın ruhsat numarasını kullan
              ),
            );

          }
        },
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.grey, // Placeholder image
              // child: Image.network('https://example.com/car-image.jpg'), // Real image
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data['markabilgi']} ${data['modelbilgi']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Yıl: ${data['yilbilgi']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Fiyat: ${data['fiyatbilgi']}',
                    style: const TextStyle(fontSize: 16),
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
