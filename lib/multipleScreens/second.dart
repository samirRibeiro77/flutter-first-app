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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Bem vindo à segunda tela!"
                "\n\nValor passado: ${widget.value}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                child: Text(
                  "Ir para primeira tela",
                  style: TextStyle(
                      fontSize: 25
                  ),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, "/");
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultipleScreensSecond(value: "Samir Ribeiro",)
                    )
                );*/
                },
              )
            ],
          ),
        )
    );
  }
}
