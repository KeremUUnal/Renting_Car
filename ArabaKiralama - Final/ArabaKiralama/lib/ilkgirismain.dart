import 'package:flutter/material.dart';

void main () {
  runApp(ilkGiris());
}

class ilkGiris extends StatelessWidget {
  const ilkGiris({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text(
            'Hoş Geldiniz',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(children: [
           Image(
            image: AssetImage('images/CeKarRenting.png'),
          ),
          const SizedBox(height: 40,),
          ElevatedButton(
            onPressed: () {


            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(800, 50),
              backgroundColor: Colors.black,
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text('Giriş Yap'),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {


            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(800, 50),
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text('Kayıt Ol'),
          ),
        ],
        ),

      ),

    );
  }
}
