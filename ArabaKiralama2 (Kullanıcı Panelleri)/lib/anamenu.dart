import 'package:flutter/material.dart';
import 'package:arabakiralama/kullanicikategori.dart';

class AnaPanel extends StatelessWidget {
  const AnaPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        // ignore: deprecated_member_use
        builder: (context) => WillPopScope(
          onWillPop: () async {
            // Kullanıcı geri tuşuna bastığında yapılacak işlemler burada
            // Diyalog kutusunu doğrudan göstermek yerine showDialog fonksiyonunu kullanmadan işlem yapabiliriz
            final result = await _showExitConfirmationDialog(context);
            // Kullanıcı "Evet" düğmesine basarsa uygulamadan çıkma işlemini gerçekleştiririz
            if (result == true) {
              return true; // Varsayılan geri tuşu işlemini gerçekleştir
            } else {
              return false; // Varsayılan geri tuşu işlemini iptal et
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.account_circle,
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
          onPressed: () {
            Navigator.of(context).pop(true);
          },
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
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
