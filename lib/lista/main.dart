import 'package:flutter/material.dart';

class AppLista extends StatelessWidget {
  const AppLista({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App com lista',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const MyHomePage(title: 'Lista aleatória'),
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
  var _itens = [];

  _carregarList() {
    _itens = [];
    for (int i=1 ; i<21 ; i++) {
      var item = {
        "title": "Titulo item $i",
        "subtitle": "Um subtitulo legal pro item $i"
      };

      _itens.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    _carregarList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: (){
                  print("Tap $index");
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(_itens[index]["title"]),
                          titlePadding: EdgeInsets.all(20),
                          content: Text(_itens[index]["subtitle"]),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  print("Selecionado sim para $index");
                                  Navigator.pop(context);
                                },
                                child: Text("Sim")
                            ),
                            TextButton(
                                onPressed: (){
                                  print("Selecionado não para $index");
                                  Navigator.pop(context);
                                },
                                child: Text("Não")
                            ),
                          ]
                        );
                      }
                  );
                },
                /*onLongPress: (){
                  print("LongPress $index");
                },*/
                title: Text(_itens[index]["title"]),
                subtitle: Text(_itens[index]["subtitle"]),
                leading: Icon(Icons.abc),
              );
            }
        ),
      )
    );
  }
}
