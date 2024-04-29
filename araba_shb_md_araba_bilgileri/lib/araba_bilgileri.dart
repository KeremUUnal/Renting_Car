import 'package:araba_shb_md_araba_bilgileri/araba_bilgileriDevam.dart';
import 'package:araba_shb_md_araba_bilgileri/main.dart';
import 'package:flutter/material.dart';


class arabaBilgileri extends StatelessWidget {
  const arabaBilgileri({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Araba Bilgileri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
body:  const BilgiYaz(),
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
    child: Row(
    children: [
    Expanded(
    child: Padding(
    padding: const EdgeInsets.only(right: 5.0),
    child: SizedBox(
    height: 70,
    child: TextFormField(
    style: const TextStyle(fontSize: 20),
    decoration: InputDecoration(
    labelText: "Marka",
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
    ),
    Expanded(
    child: Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: SizedBox(
    height: 70,
    child: TextFormField(
    style: const TextStyle(fontSize: 20),
    decoration: InputDecoration(
    labelText: "Model",
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
    ),
    ],
    ),
    ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "Yıl",
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
                ),
                const SizedBox(height: 70,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "Vites",
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
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "Km",
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
                ),
                const SizedBox(height: 70,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "Motor Gücü",
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(

            children: [
              const SizedBox(width: 115,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const arabaSahibi()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text('Geri Git'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const arabaBilgileriDevam()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text('Devam Et'),
              ),
            ],
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
                  'Bilgilerinizi doldurmaya devam etmek için tıklayınız',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

      ]
    ),
    ),
    );
  }
}






