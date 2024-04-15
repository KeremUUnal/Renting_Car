import 'package:arabakiralama/adres.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:flutter/material.dart';

class IletisimPanel extends StatelessWidget {
  const IletisimPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'İletişim Bilgileri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const IletisimBilgi(),
      ),
    );
  }
}

class IletisimBilgi extends StatefulWidget {
  const IletisimBilgi({super.key});

  @override
  State<IletisimBilgi> createState() => _IletisimBilgiState();
}

class _IletisimBilgiState extends State<IletisimBilgi> {
  TextEditingController telefonController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  late IletisimDepo iletisim;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  controller: telefonController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    label: const Text("Telefon Numarası"),
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: mailController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  label: const Text("E-mail Adres"),
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                String telefon = telefonController.text;
                String mail = mailController.text;
                iletisim.telefonNumarasi = telefon;
                iletisim.emailAdresi = mail;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdresPanel()),
                );
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
