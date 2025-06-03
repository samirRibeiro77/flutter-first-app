import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrecoBitcoin extends StatelessWidget {
  const PrecoBitcoin({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preço do Bitcoin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(255, 148, 0, 1)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _currency = "R\$ ";

  Future<Map> _atualizarValor() async {
    var url = Uri.parse("https://blockchain.info/ticker");
    var response = await http.get(url);

    Map<String, dynamic> body = jsonDecode(response.body);

    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("images/bitcoin.png"),
            FutureBuilder <Map>(
                future: _atualizarValor(),
                builder: (context, snapshot) {
                  var value = "";
                  switch(snapshot.connectionState) {
                    case ConnectionState.done:
                      var data = snapshot.data ?? null;
                      value = data != null
                          ? _currency + data["BRL"]["buy"].toString()
                          : "Erro ao carregar os dados";
                      break;
                    default:
                      value = "Carregando...";
                      break;
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: 45, bottom: 45),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  );
                }
            ),
            ElevatedButton(
                onPressed: (){ setState(() {});},
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Atualizar",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
