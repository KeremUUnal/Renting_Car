
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kiraarayuz/kirabilgiDepo.dart';
import 'package:kiraarayuz/kiralamaIslem.dart';

import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => kirabilgiDepo(),
      child: const kiraArayuz(),
    ),
  );
}


class kiraArayuz extends StatelessWidget {
  const kiraArayuz({Key? key}) : super(key: key);

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
        body: BilgiYaz(),
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
  String marka = "";
  String model = "";
  String yil = "";
  String vites = "";
  String km = "";
  String motor_gucu = "";
  String yakit = "";
  String hasar_kaydi = "";
  String fiyat = "";
  String ruhsatseri= "456";
 String ad = "";
 String soyad = "";
String telefon = "";
  String il = "";
  String ilce = "";
  String mahalle = "";
  String cadde = "";
  String sokak = "";
  String apartmanno = "";
  String daireno = "";



   Future<void> arabacekData(String ruhsat) async {
    try {
      var url = Uri.parse(
          'http://*******/arababilgicek'); // API endpoint'i
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
        motor_gucu = jsonResponse['motor_gucubilgi'];
        yakit = jsonResponse['yakitbilgi'];
        hasar_kaydi = jsonResponse['hasar_kaydibilgi'];
        fiyat  = jsonResponse['fiyatbilgi'];
        ad  = jsonResponse['adbilgi'];
        soyad  = jsonResponse['soyadbilgi'];
        telefon  = jsonResponse['telefonbilgi'];
        il = jsonResponse['sehirbilgi'];
        ilce = jsonResponse['ilcebilgi'];
        mahalle = jsonResponse['mahallebilgi'];
        cadde = jsonResponse['caddebilgi'];
        sokak = jsonResponse['sokakbilgi'];
        apartmanno = jsonResponse['apartmannobilgi'];
        daireno = jsonResponse['dairenobilgi'];


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
            future: Future.wait([
               arabacekData(ruhsatseri),
]),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Veri beklerken bir dönen çember göster
      } else if (snapshot.hasError) {
        return Text(
            'Hata: ${snapshot.error}'); // Hata oluşursa hatayı göster
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),


            Text('Kişisel Bilgiler',
                style: Theme
                .of(context)
                .textTheme
                .headline6),
            SizedBox(height: 8),
            TextFormField(
              initialValue: '$ad $soyad',
              decoration: InputDecoration(
                labelText: 'İsim Soyisim',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () {}, // Boş bir işlev
            ),
            SizedBox(height: 8),
            TextFormField(
              initialValue: telefon,
              decoration: InputDecoration(
                labelText: 'Telefon',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () {}, // Boş bir işlev
            ),
            SizedBox(height: 8),
            TextFormField(
              initialValue: '$mahalle mahallesi $cadde caddesi $sokak sokak $il / $ilce' ,
              decoration: InputDecoration(
                labelText: 'Adres',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () {}, // Boş bir işlev
            ),
            SizedBox(height: 16),
            Text('Araba Bilgileri', style: Theme
                .of(context)
                .textTheme
                .headline6),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Marka:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: marka,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Model:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: model,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Yıl:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: yil,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
                SizedBox(width: 16),
                Text('Vites:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: vites,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Km:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: km,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
                SizedBox(width: 16),
                Text('Motor Gücü:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: motor_gucu,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Yakıt:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: yakit,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
                SizedBox(width: 16),
                Text('Hasar Kaydı:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: hasar_kaydi,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Fiyat:'),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: fiyat,
                    readOnly: true,
                    onTap: () {}, // Boş bir işlev
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const kiralamaIslem()),
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
    } ),


      ),
    );
  }
}
