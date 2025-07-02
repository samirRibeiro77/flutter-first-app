import 'package:flutter/material.dart';

class AlcoolGasolina extends StatelessWidget {
  const AlcoolGasolina({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Entrada de dados',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MyHomePage(title: 'Entrada de dados'),
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
  final _alcoolController = TextEditingController();
  final _gasolineController = TextEditingController();
  var _choosePhrase = "";

  void _calculate() {
    var choose = "";
    var alcoolPrice = double.tryParse(_alcoolController.text.replaceAll(',', '.'));
    var gasolinePrice = double.tryParse(_gasolineController.text.replaceAll(',', '.'));

    if (alcoolPrice == null || gasolinePrice == null) {
      setState(() {
        _choosePhrase = "Valor inválido digitado";
      });
      return;
    }

    if ((alcoolPrice/gasolinePrice) >= 0.7) {
      choose = "gasolina";
    }
    else {
      choose = "alcool";
    }

    setState(() {
      _choosePhrase = "Melhor abastecer com $choose";
    });

    clearFields();
  }

  void clearFields() {
    _alcoolController.text = "";
    _gasolineController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/alcoolGasolina/logo.png"),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Saiba qual a melhor opção para abastecimento do seu carro",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              TextField(
                controller: _alcoolController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                    labelText: "Preço do alcool"
                ),
              ),
              TextField(
                controller: _gasolineController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                    labelText: "Preço da gasolina"
                ),
              ),
              SizedBox(child: Container(height: 10.0)),
              ElevatedButton(
                  onPressed: _calculate,
                  child: Text(
                    "Calcular",
                    style: TextStyle(fontSize: 20),
                  )
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  _choosePhrase,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
