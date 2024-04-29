import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:odeme_bilgileri/odemeDeop.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => odemeDeop(),
      child: const OdemeBilgileri(),
    ),
  );
}

class OdemeBilgileri extends StatelessWidget {
  const OdemeBilgileri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Ödeme Bilgileri',
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
  const BilgiYaz({Key? key}) : super(key: key);

  @override
  State<BilgiYaz> createState() => _BilgiYazState();
}

class _BilgiYazState extends State<BilgiYaz> {
  Future<void> odemeData(
      String kartIsim,
      String kart_no,
      DateTime son_kullanma_tarihi,
      String cvv,
      ) async {
    try {
      var url = Uri.parse(
          'http://*****/odemebilgileri'); // API endpoint'i
      var response = await http.post(
        url,
        body: {
          'kartIsim': kartIsim,
          'kart_no': kart_no,
          'son_kullanma_tarihi': DateFormat('yyyy-MM-dd').format(son_kullanma_tarihi),
          'cvv': cvv,
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Başarılı yanıt
        debugPrint('Veri başarıyla eklendi: ${response.body}');
      } else {
        // Hatalı yanıt
        debugPrint('Hata: ${response.reasonPhrase}');
      }
    } catch (error) {
      debugPrint('İstek sırasında bir hata oluştu: $error');
    }
  }

  final _isimController = TextEditingController();
  final _kartNoController = TextEditingController();
  DateTime? sonKullanmaTarihi;
  final _cvvController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var odemeBlgProvider = Provider.of<odemeDeop>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 70,
                child: TextFormField(
                  controller: _isimController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Kartın Üstündeki İsim",
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
                height: 70,
                child: TextFormField(
                  controller: _kartNoController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Kart Numarası",
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        labelText: "Son Kullanma Tarihi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      controller: TextEditingController(
                        text: _selectedDate == null
                            ? ''
                            : '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}',
                      ),
                      textDirection: null,

                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      controller: _cvvController,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35.0),
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
                    'Kartınızın arka yüzündeki 3 haneli kodu "CVV" kısmına,\nön yüzündeki tarih kısmını da "Son Kullanma Tarihi" kısmına giriniz.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_isimController.text.isNotEmpty &&
                    _kartNoController.text.isNotEmpty &&
                    sonKullanmaTarihi != null &&
                    _cvvController.text.isNotEmpty) {
                  odemeBlgProvider.kartIsim = _isimController.text;
                  odemeBlgProvider.kartNo = _kartNoController.text;
                  odemeBlgProvider.sonKullanmaTarihi = _selectedDate!;
                  odemeBlgProvider.cvv = _cvvController.text;

                  odemeData(
                    odemeBlgProvider.kartIsim,
                    odemeBlgProvider.kartNo,
                    odemeBlgProvider.sonKullanmaTarihi!,
                    odemeBlgProvider.cvv,
                  );
                }

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
