import 'package:araba_shb_md_araba_bilgileri/araba_bilgileri.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const arabaSahibi());
}


class arabaSahibi extends StatelessWidget {
  const arabaSahibi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Araba Sahibi Modu',
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
        child: Column(
        children: [
        Padding(
        padding: const EdgeInsets.all(15.0),
    child: SizedBox(
    height: 70,
    child: TextFormField(
    style: const TextStyle(fontSize: 20),
    decoration: InputDecoration(
    labelText: "Kasko Numarası",
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
       const SizedBox(height: 5,
   ),
    Padding(
    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
    height: 70,
    child: TextFormField(
    style: const TextStyle(fontSize: 20),
    decoration: InputDecoration(
    labelText: "Ruhsat Seri Numarası",
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
          const SizedBox(height: 5
            ,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 70,
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: "IBAN",
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
          const SizedBox(height: 40.0),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Padding(
                padding: EdgeInsets.only(top: 2.6),
                child: Icon(
                  Icons.info,
                  size: 19,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Girilmesi zorunlu bilgilerdir. Arabanızı uygulamaya eklemek için alanları doldurunuz',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 40),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const arabaBilgileri()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Devam Et'),
        ),
      ]
    ),

    ),
    );

  }
}



