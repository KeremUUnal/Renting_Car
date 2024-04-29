import 'package:arabakiralama/mailguncelle.dart';
import 'package:arabakiralama/telguncelle.dart';
import 'package:flutter/material.dart';

class IletisimGuncellePanel extends StatelessWidget {
  const IletisimGuncellePanel({super.key});

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
            'İletişim Güncelleme Seçenekleri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const IletisimGuncelle(),
      ),
    );
  }
}

class IletisimGuncelle extends StatefulWidget {
  const IletisimGuncelle({super.key});

  @override
  State<IletisimGuncelle> createState() => _IletisimGuncelleState();
}

class _IletisimGuncelleState extends State<IletisimGuncelle> {
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
          buildCard("E-mail adresinizi değiştirin", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MailGuncellePanel(),
              ),
            );
          }),
          buildCard("Telefon numaranızı değiştirin", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TelGuncellePanel(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
