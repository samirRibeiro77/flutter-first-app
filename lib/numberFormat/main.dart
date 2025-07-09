import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberFormatApp extends StatelessWidget {
  const NumberFormatApp({super.key});

  final appName = "Formatação de números";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(0, 0, 255, 1),
        ),
      ),
      home: MyHomePage(appName: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.appName});

  final String appName;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formatter = NumberFormat("#,##0.0#", "pt_BR");
  var _result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appName),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (txt) {
                if (txt.isNotEmpty) {
                  setState(() {
                    _result = double.parse(txt);
                  });
                }
              },
            ),
            Text("Resultado:", style: TextStyle(fontSize: 32)),
            Text(
              _formatter.format(_result),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
