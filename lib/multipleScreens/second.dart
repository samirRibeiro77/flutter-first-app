import 'package:flutter/material.dart';

class MultipleScreensSecond extends StatefulWidget {
  const MultipleScreensSecond({super.key, this.value});

  final value;

  @override
  State<MultipleScreensSecond> createState() => _MultipleScreensSecondState();
}

class _MultipleScreensSecondState extends State<MultipleScreensSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Segunda tela" /*widget.title*/),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Text(
                "Bem vindo à segunda tela!"
                "\n\nValor passado: ${widget.value}",
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
        )
    );
  }
}
