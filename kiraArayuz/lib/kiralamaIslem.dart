import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kiraarayuz/kirabilgiDepo.dart';
import 'package:kiraarayuz/kiralamaIslem.dart';
import 'package:kiraarayuz/main.dart';
import 'package:provider/provider.dart';



class kiralamaIslem extends StatelessWidget {
  const kiralamaIslem({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'Kira İşlemleri',
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
  const BilgiYaz({Key? key});

  @override
  State<BilgiYaz> createState() => _BilgiYazState();
}

class _BilgiYazState extends State<BilgiYaz> {
  DateTime? _selectedDate;
  DateTime? _selectedDate2;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate2 = picked;
      });
    }
  }

  Future<void> kiraIslem(
      DateTime baslangic_tarihi,
      DateTime bitis_tarihi,
      ) async {



    if (_selectedDate != null && _selectedDate2 != null) {
      try {
        var url = Uri.parse(
            'http://*******/kiralamabilgileri'); // API endpoint'i
        var body = jsonEncode({

          'baslangic_tarihi': DateFormat('yyyy-MM-dd').format(baslangic_tarihi!),
          'bitis_tarihi': DateFormat('yyyy-MM-dd').format(bitis_tarihi!),

        });
        var response = await http.post(url, body: body, headers: {
          'Content-Type':
          'application/json', // JSON veri gönderildiği belirtiliyor
        });

        if (response.statusCode == 200) {
          debugPrint('Veri başarıyla eklendi: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('İşlem başarıyla gerçekleştirildi.'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          debugPrint('Hata: ${response.reasonPhrase}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('İşlem sırasında bir hata oluştu.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (error) {
        debugPrint('İstek sırasında bir hata oluştu: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('İstek sırasında bir hata oluştu: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      debugPrint('Başlangıç ve bitiş tarihleri seçilmemiş.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Başlangıç ve bitiş tarihleri seçilmemiş.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var kiraProvider = Provider.of<kirabilgiDepo>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(height: 200,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        labelText: "Başlangıç Tarihi",
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
                const SizedBox(width: 10.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        labelText: "Bitiş Tarihi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate2(context),
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      controller: TextEditingController(
                        text: _selectedDate2 == null
                            ? ''
                            : '${_selectedDate2!.year}/${_selectedDate2!.month}/${_selectedDate2!.day}',
                      ),
                      textDirection: null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                   kiraProvider.baslangic_tarihi = _selectedDate!;
                    kiraProvider.bitis_tarihi = _selectedDate2!;
                    kiraIslem(
                      kiraProvider.baslangic_tarihi!,
                      kiraProvider.bitis_tarihi!,
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Kiralamayı Bitir'),
                ),
                SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const kiraArayuz(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('İptal'),
                ),
              ],

            ),
            const SizedBox(height: 120.0),
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
                    'Kiralamaya başlamak ve bitirmek istediğiniz tarihleri ilgili alanlara giriniz. Kiralamayı bitir butonuna tıklayarak kiralama işleminiz tamamlanacaktır.',
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
