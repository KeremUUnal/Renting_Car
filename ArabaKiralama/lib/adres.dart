import 'package:arabakiralama/kayit.dart';
import 'package:flutter/material.dart';

class AdresPanel extends StatelessWidget {
  const AdresPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Adres Bilgileri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const AdresBilgi(),
      ),
    );
  }
}

class AdresBilgi extends StatefulWidget {
  const AdresBilgi({super.key});

  @override
  State<AdresBilgi> createState() => _AdresBilgiState();
}

class _AdresBilgiState extends State<AdresBilgi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("İl"),
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
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("İlçe"),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    label: const Text("Mahalle"),
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Cadde"),
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
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Sokak"),
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Apartman No"),
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
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text("Daire No"),
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
            const SizedBox(height: 20),
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
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'Kullanıcı adresini girdiğinizde, kiralama işlemleriniz için doğru bilgilere ulaşmamızı sağlamış olursunuz. Güvenliğiniz ve hızlı hizmetimiz için lütfen doğru ve eksiksiz bilgileri giriniz.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KayitPanel()),
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
