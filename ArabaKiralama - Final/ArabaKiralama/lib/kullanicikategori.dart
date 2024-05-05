import 'package:arabakiralama/adresguncelle.dart';
import 'package:arabakiralama/iletisimguncelle.dart';
import 'package:arabakiralama/sifreguncelle.dart';
import 'package:flutter/material.dart';
import 'package:arabakiralama/kullanicipaneli.dart';

class KategoriPanel extends StatelessWidget {
  const KategoriPanel({super.key});

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
            'Seçenekler',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const KategoriBilgi(),
      ),
    );
  }
}

class KategoriBilgi extends StatefulWidget {
  const KategoriBilgi({super.key});

  @override
  State<KategoriBilgi> createState() => _KategoriBilgiState();
}

class _KategoriBilgiState extends State<KategoriBilgi> {
  Widget buildCard(String text, VoidCallback onPressed) {
    return Card(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildCard("Kullanıcı bilgilerini görüntüleyin", () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const KullaniciPanel(),
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
          }),
          buildCard("İletişim bilgilerinizi güncelleyin", () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const IletisimGuncellePanel(),
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
          }),
          buildCard("Adres bilgilerinizi güncelleyin", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdresGuncellePanel(),
              ),
            );
          }),
          buildCard("Şifrenizi değiştirin", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SifreGuncellePanel(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
