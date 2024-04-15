import 'package:flutter/material.dart';
import 'ehliyetbilgi.dart';

void main() {
  runApp(const KisiselPanel());
}

class KisiselPanel extends StatelessWidget {
  const KisiselPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Kullanıcı Bilgileri',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const KullaniciKaydi(),
      ),
    );
  }
}

class KullaniciKaydi extends StatefulWidget {
  const KullaniciKaydi({super.key});

  @override
  State<KullaniciKaydi> createState() => _KullaniciKaydiState();
}

class _KullaniciKaydiState extends State<KullaniciKaydi> {
  String selectedGender = 'Erkek';

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
                          label: const Text("Ad"),
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        label: const Text("Soyad"),
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
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  label: const Text("T.C. Kimlik Numarası"),
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
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Cinsiyet'),
                      items: <String>['Erkek', 'Kadın'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          // Do something with the picked date.
                        }
                      },
                      child: const Text('Doğum Tarihi'),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EhliyetPanel()),
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
