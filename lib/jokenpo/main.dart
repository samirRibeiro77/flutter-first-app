import 'dart:math';
import 'package:flutter/material.dart';

class Jokenpo extends StatelessWidget {
  const Jokenpo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JokenPo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'JokenPo'),
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
  var _appChoice = AssetImage("assets/images/jokenpo/padrao.png");
  final _options = {
    "pedra" : AssetImage("assets/images/jokenpo/pedra.png"),
    "papel" : AssetImage("assets/images/jokenpo/papel.png"),
    "tesoura" : AssetImage("assets/images/jokenpo/tesoura.png"),
  };
  //var _options = ["pedra", "papel", "tesoura"];
  var _result = "";


  optionSelected(String userChoice){
    var random = Random().nextInt(_options.length);
    var appChoice = _options.entries.elementAt(random);
    var message = "Game tied";

    if (
      (userChoice == "pedra" && appChoice.key == "tesoura") ||
      (userChoice == "papel" && appChoice.key == "pedra") ||
      (userChoice == "tesoura" && appChoice.key == "papel")
    ) {
      message = "Congrats, you won!";
    }
    else if (
        (appChoice.key == "pedra" && userChoice == "tesoura") ||
        (appChoice.key == "papel" && userChoice == "pedra") ||
        (appChoice.key == "tesoura" && userChoice == "papel")
    ) {
      message = "You lose, try again :(";
    }

    setState(() {
      _appChoice = appChoice.value;
      _result = message;
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
          padding: EdgeInsets.all(25),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Escolha do app:",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(child: Container(height: 10.0)),
              Image(image: _appChoice),
              SizedBox(child: Container(height: 30.0)),
              Text(
                "Escolha uma opção abaixo:",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(child: Container(height: 10.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => optionSelected("pedra"),
                    child: Image.asset("assets/images/jokenpo/pedra.png", height: 95),
                  ),
                  GestureDetector(
                    onTap: () => optionSelected("papel"),
                    child: Image.asset("assets/images/jokenpo/papel.png", height: 95),
                  ),
                  GestureDetector(
                    onTap: () => optionSelected("tesoura"),
                    child: Image.asset("assets/images/jokenpo/tesoura.png", height: 95),
                  ),
                ],
              ),
              SizedBox(child: Container(height: 15.0)),
              Text(
                _result,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
