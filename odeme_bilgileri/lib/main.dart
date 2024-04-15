import 'package:flutter/material.dart';

void main() {
  runApp(const OdemeBilgileri());
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
                      maxLength: 3,
                      readOnly: true,
                      controller: TextEditingController(
                        text: _selectedDate == null
                            ? ''
                            : '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                const SizedBox( width:12.0),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
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
                        textAlign: TextAlign.end
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
        onPressed: () {},
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