import 'package:arabakiralama/baslangicMain.dart';
import 'package:arabakiralama/odemebilgileri.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:provider/provider.dart';

class KullaniciPanel extends StatelessWidget {
  const KullaniciPanel({super.key});

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
            'Kullanıcı Bilgileri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const KullaniciBilgi(),
      ),
    );
  }
}

class KullaniciBilgi extends StatefulWidget {
  const KullaniciBilgi({super.key});

  @override
  State<KullaniciBilgi> createState() => _KullaniciBilgiState();
}

class _KullaniciBilgiState extends State<KullaniciBilgi> {
  String ad = "";
  String soyad = "";
  String tc = "";
  String cinsiyet = "";
  DateTime dtarih = DateTime(0, 0, 0);
  String telefon = "";
  String mail = "";
  String tckimlik = "";
  String tarihformat = "";

  Future<void> kullaniciVerileri(String tckimlik) async {
    try {
      var url = Uri.parse(
          'http://******/kullanicibilgicek'); // API endpoint'i
      var body = jsonEncode({
        'tc_kimlik': tckimlik,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        ad = jsonResponse['adbilgi'];
        soyad = jsonResponse['soyadbilgi'];
        tc = jsonResponse['tcbilgi'];
        cinsiyet = jsonResponse['cinsiyetbilgi'];
        dtarih = DateTime.parse(jsonResponse['dtarihbilgi']);
        tarihformat = DateFormat('dd-MM-yyyy').format(dtarih);
        telefon = jsonResponse['telefonbilgi'];
        mail = jsonResponse['mailbilgi'];
        debugPrint("Kişisel veriler başarıyla alındı.");
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  String il = "";
  String ilce = "";
  String mahalle = "";
  String cadde = "";
  String sokak = "";
  String apartmanno = "";
  String daireno = "";

  Future<void> adresVerileri(String tckimlik) async {
    try {
      var url = Uri.parse(
          'http://**********/adresbilgicek'); // API endpoint'i
      var body = jsonEncode({'tc_kimlik': tckimlik}); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        il = jsonResponse['ilbilgi'];
        ilce = jsonResponse['ilcebilgi'];
        mahalle = jsonResponse['mahallebilgi'];
        cadde = jsonResponse['caddebilgi'];
        sokak = jsonResponse['sokakbilgi'];
        apartmanno = jsonResponse['apartmannobilgi'];
        daireno = jsonResponse['dairenobilgi'];

        debugPrint("Adres verileri başarıyla alındı.");
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  String kartno = "";
  String cvv = "";
  String starih = "";
  bool butonpaneli = true;
  bool bilgipaneli = true;

  Future<void> odemeVerileri(String tckimlik) async {
    try {
      var url = Uri.parse(
          'http://************/odemebilgicek'); // API endpoint'i
      var body = jsonEncode({
        'tc_kimlik': tckimlik,
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
            'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        kartno = jsonResponse['kartbilgi'];
        starih = jsonResponse['starihbilgi'];
        cvv = jsonResponse['cvvbilgi'];
        butonpaneli = jsonResponse['butonpanel'];
        bilgipaneli = jsonResponse['bilgipanel'];
        debugPrint("Ödeme verileri başarıyla alındı.");
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }
  Future<void> kullaniciSil(String ruhsatseri, String tckimlik) async {
    try {
      var url =
      Uri.parse('http://*************/kullanicisil'); // API endpoint'i
      var body = jsonEncode({
        'ruhsatseri_no': ruhsatseri,
        'tc_kimlik': tckimlik
      }); // Gönderilecek veri

      var response = await http.post(url, body: body, headers: {
        'Content-Type':
        'application/json', // JSON veri gönderildiği belirtiliyor
      });

      if (response.statusCode == 200) {
        debugPrint('Hesap silme işlemleri başarılı!');
      } else {
        throw Exception('Sunucudan yanıt alınamadı.');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    var veriEkle = Provider.of<DepoProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Future.wait([
             kullaniciVerileri(veriEkle.tcno),
             adresVerileri(veriEkle.tcno),
             odemeVerileri(veriEkle.tcno),
            ]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Veri beklerken bir dönen çember göster
              } else if (snapshot.hasError) {
                return Text(
                    'Hata: ${snapshot.error}'); // Hata oluşursa hatayı göster
              } else {
                return Column(
                  children: [
                    const SizedBox(height: 20), // Ekstra boşluk ekledim
                    const Center(
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 150,
                        color: Colors.blue, // İkon rengini değiştirdim
                      ),
                    ),
                    Text(
                      "$ad $soyad",
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight:
                              FontWeight.bold), // Yazı tipini kalınlaştırdım
                    ),
                    const SizedBox(height: 20), // Ekstra boşluk ekledim
                    Card(
                      margin:
                          const EdgeInsets.all(15), // Card'a dış boşluk ekledim
                      child: Padding(
                        // Card'a iç boşluk ekledim
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // İçerikleri sola yasladım
                          children: [
                            const Text(
                              'Kullanıcı Bilgileri',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight
                                      .bold), // Yazı tipini kalınlaştırdım
                            ),
                            const SizedBox(height: 10), // Ekstra boşluk ekledim
                            Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.perm_identity,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  "T.C. $tc",
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "SourceSans",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.cake,
                                        color: Colors.blue,
                                      ),
                                      title: Text(
                                        tarihformat,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: "SourceSans",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      leading: Icon(
                                        veriEkle.cinsiyet == 'Erkek'
                                            ? Icons.male
                                            : Icons.female,
                                        color: veriEkle.cinsiyet == 'Erkek'
                                            ? Colors.blue
                                            : Colors.pink,
                                      ),
                                      title: Text(
                                        cinsiyet,
                                        style: const TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: "SourceSans",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin:
                          const EdgeInsets.all(15), // Card'a dış boşluk ekledim
                      child: Padding(
                        // Card'a iç boşluk ekledim
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // İçerikleri sola yasladım
                          children: [
                            const Text(
                              'İletişim Bilgileri',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight
                                      .bold), // Yazı tipini kalınlaştırdım
                            ),
                            const SizedBox(height: 20), // Ekstra boşluk ekledim
                            Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  telefon,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "SourceSans",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10), // Ekstra boşluk ekledim
                            Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.mail,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  mail,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "SourceSans",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Adres Bilgileri',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Card(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      leading: Text(
                                        "Şehir: $il",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: "SourceSans",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      leading: Text(
                                        "İlçe: $ilce",
                                        style: const TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: "SourceSans",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Açık Adres:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.home,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  "$mahalle Mahallesi $cadde Caddesi $sokak Sokak No: $apartmanno/$daireno",
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "SourceSans",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ödeme Bilgileri',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Visibility(
                              visible: butonpaneli,
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.credit_card,
                                    color: Colors.blue,
                                  ),
                                  title: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OdemeBilgileri(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text("Ödeme Bilgisi Ekle"),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: bilgipaneli,
                              child: Column(
                                children: [
                                  Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.credit_card,
                                        color: Colors.blue,
                                      ),
                                      title: Text(
                                        kartno,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    GestureDetector(
                      onTap: () {
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Hesabınızdan çıkış yapmak istediğinizden emin misiniz?",
                                style: TextStyle(
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
                                    Navigator.pushAndRemoveUntil(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const IlkGiris()),
                                          (Route<dynamic> route) => false,
                                    );
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
                      },
                      child: const Text(
                        'Çıkış Yap',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 120.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Hesabınızı sildiğiniz zaman kişisel bilgileriniz, ödeme bilgileriniz ve varsa araba bilgileriniz tamamen silinecektir. Emin misiniz?",
                                style: TextStyle(
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
                                    kullaniciSil(veriEkle.ruhsatSeriNumarasi,
                                        veriEkle.tcno);
                                    Navigator.pushAndRemoveUntil(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const IlkGiris()),
                                          (Route<dynamic> route) => false,
                                    );
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
                      },
                      child: const Text(
                        'Hesabı Sil',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              }
            }),
      ),
    );
  }
}
