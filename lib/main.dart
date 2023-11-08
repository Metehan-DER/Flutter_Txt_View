import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String metin = "";

  @override
  void initState() {
    super.initState();
    // Metin dosyasını okuma işlemi
    loadText();
  }

  Future<void> loadText() async {
    // assets klasöründen metin dosyasını yükler
    String content = await rootBundle.loadString('assets/metin_dosyasi.txt');
    setState(() {
      metin = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metin Dosyası Okuma First Commit'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: _parseText(metin),
          ),
        ),
      ),
    );
  }

  Widget _parseText(String text) {
    final List<Widget> widgets = [];
    final lines = text.split('\n');

    for (var line in lines) {
      if (line.startsWith('<h1>')) { // büyük başlık
        widgets.add(
          Text(
            line.substring(4, line.length - 5),
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        );
      } else if (line.startsWith('<h2>')) { // orta
        widgets.add(
          Text(
            line.substring(4, line.length - 5),
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        );
      } else if (line.startsWith('<h3>')) {
        widgets.add(
          Text(
            line.substring(4, line.length - 5),
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        );
      } else {
        widgets.add(
          Text(
            line,
            style: TextStyle(color: Colors.black),
          ),
        );
      }
    }

    return Column(
      children: widgets,
    );
  }
}
