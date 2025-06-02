import 'dart:math';
import 'package:flutter/material.dart';

class FrasesDoDia extends StatelessWidget {
  const FrasesDoDia({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frases  do dia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: const MyHomePage(title: 'Frases do dia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _frases = [
    "Frase 1",
    "Frase 2",
    "Frase 3",
    "Frase 4",
  ];

  var _fraseGerada = "Clique abaixo para gerar uma frase!";

  void _gerarFrase() {
    var random = Random().nextInt(_frases.length);
    setState(() {
      _fraseGerada = _frases[random];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset("images/logoFrases.png"),
              Text(
                _fraseGerada,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                  onPressed: _gerarFrase,
                  child: Text(
                      "Nova frase",
                    style: TextStyle(fontSize: 20),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
