// ignore_for_file: file_names
import 'package:arabakiralama/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';
import 'package:arabakiralama/giris.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DepoProvider(),
      child: const IlkGiris(),
    ),
  );
}

class IlkGiris extends StatelessWidget {
  const IlkGiris({super.key});

  @override
  Widget build(BuildContext context) {
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
              automaticallyImplyLeading: false,
              backgroundColor: Colors.deepPurple,
              centerTitle: true,
              title: const Text(
                'Hoş Geldiniz',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: const BaslangicBilgi(),
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
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Evet'),
        ),
      ],
    ),
  );
}

class BaslangicBilgi extends StatefulWidget {
  const BaslangicBilgi({super.key});

  @override
  State<BaslangicBilgi> createState() => _BaslangicBilgiState();
}

class _BaslangicBilgiState extends State<BaslangicBilgi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/CeKarRenting.png'),
              height: 200,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GirisYap(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 50),
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Giriş Yap'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KisiselPanel(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 50),
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.tealAccent  ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}