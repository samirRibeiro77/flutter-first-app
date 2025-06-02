import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sjr77_first_project/webService/address.dart';

class WebServices extends StatelessWidget {
  const WebServices({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Services',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(title: 'Web Services'),
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
  final _cepController = TextEditingController();
  var _localizacao = "";

  _pesquisarCep() async {
    var url = Uri.parse("https://viacep.com.br/ws/${_cepController.text}/json");
    var response = await http.get(url);

    var address = Address(jsonDecode(response.body));

    setState(() {
      _localizacao = address.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Digite um cep"
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: ElevatedButton(
                    onPressed: _pesquisarCep,
                    child: Text("Pesquisar")
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  _localizacao,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
