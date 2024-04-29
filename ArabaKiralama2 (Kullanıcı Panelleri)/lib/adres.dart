 import 'package:arabakiralama/kayit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arabakiralama/kayitdepo.dart';

class AdresPanel extends StatelessWidget {
  const AdresPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
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
  final _ilController = TextEditingController();
  final _ilceController = TextEditingController();
  final _mahalleController = TextEditingController();
  final _caddeController = TextEditingController();
  final _sokakController = TextEditingController();
  final _apartController = TextEditingController();
  final _daireController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var adresBilgiProvider = Provider.of<DepoProvider>(context, listen: false);
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
                        controller: _ilController,
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
                        controller: _ilceController,
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
                  controller: _mahalleController,
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
                        controller: _caddeController,
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
                        controller: _sokakController,
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
                        controller: _apartController,
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
                        controller: _daireController,
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
                adresBilgiProvider.il = _ilController.text;
                adresBilgiProvider.ilce = _ilceController.text;
                adresBilgiProvider.mahalle = _mahalleController.text;
                adresBilgiProvider.cadde = _caddeController.text;
                adresBilgiProvider.sokak = _sokakController.text;
                adresBilgiProvider.apartno = _apartController.text;
                adresBilgiProvider.daireno = _daireController.text;
                Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const KayitPanel(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ));
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
