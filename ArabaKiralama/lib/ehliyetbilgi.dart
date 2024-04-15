import 'package:arabakiralama/iletisim.dart';
import 'package:flutter/material.dart';

class EhliyetPanel extends StatelessWidget {
  const EhliyetPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Ehliyet Bilgileri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const EhliyetBilgi(),
      ),
    );
  }
}

class EhliyetBilgi extends StatefulWidget {
  const EhliyetBilgi({super.key});

  @override
  State<EhliyetBilgi> createState() => _EhliyetBilgiState();
}

class _EhliyetBilgiState extends State<EhliyetBilgi> {
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
                    label: const Text("Ehliyet Seri Numarası"),
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IletisimPanel()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Devam Et'),
            ),
            const SizedBox(
              height: 320,
            ),
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
                    'Sürücü belgenizin ön yüzünün 5. maddesinde\nbulunan 6 haneli "Sürücü Sicil Numarası" kodunu\ngirmeniz gerekmektedir.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
