import 'package:flutter/material.dart';

void main(){

  runApp(girisYap());
}

class girisYap extends StatelessWidget {
  const girisYap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Giriş yap',
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
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 80,
              child: TextFormField(


                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "E-mailinizi giriniz",
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 80,
              child: TextFormField(


                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Şifrenizi Giriniz",
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
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {


            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text('Giriş Yap'),
          ),
        ],

        ),

      ),
    );

  }
}


