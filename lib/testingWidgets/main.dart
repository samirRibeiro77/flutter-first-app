import 'package:flutter/material.dart';

class TestingWidgetsApp extends StatelessWidget {
  const TestingWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teste de widgets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(title: 'Teste de widgets'),
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
  var _brazilianFood = false;
  var _mexicanFood = false;
  var _switchValue = false;
  var _sliderValue = 5.0;
  var _radioChoose = "";

  var _result = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
                title: Text("Comida Brasileira"),
                subtitle: Text("A melhor comida do mundo"),
                secondary: Icon(Icons.fastfood),
                activeColor: Colors.red,
                value: _brazilianFood,
                onChanged: (value){
                  setState(() {
                    _brazilianFood = value ?? false;
                  });
                }
            ),
            CheckboxListTile(
                title: Text("Comida Mexicana"),
                subtitle: Text("A melhor comida do mundo"),
                secondary: Icon(Icons.fastfood),
                activeColor: Colors.red,
                value: _mexicanFood,
                onChanged: (value){
                  setState(() {
                    _mexicanFood = value ?? false;
                  });
                }
            ),
            RadioListTile(
                title: Text("Comida Chinesa"),
                subtitle: Text("A melhor comida do mundo"),
                secondary: Icon(Icons.fastfood),
                activeColor: Colors.red,
                value: "Chinesa",
                groupValue: _radioChoose,
                onChanged: (choose) {
                  setState(() {
                    _radioChoose = choose ?? "";
                  });
                }
            ),
            RadioListTile(
                title: Text("Comida Japonesa"),
                subtitle: Text("A melhor comida do mundo"),
                secondary: Icon(Icons.fastfood),
                activeColor: Colors.red,
                value: "Japonesa",
                groupValue: _radioChoose,
                onChanged: (choose) {
                  setState(() {
                    _radioChoose = choose ?? "";
                  });
                }
            ),
            SwitchListTile(
              title: Text("Comida Peruana"),
              subtitle: Text("A melhor comida do mundo"),
              secondary: Icon(Icons.fastfood),
              activeColor: Colors.red,
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            Slider(
                value: _sliderValue,
                min: 0,
                max: 10,
                label: _sliderValue.toStringAsFixed(1),
                activeColor: Colors.red,
                inactiveColor: Colors.amberAccent,
                divisions: 20,
                onChanged: (value){
                  setState(() {
                    _sliderValue = value;
                  });
                }
            ),
            SizedBox(child: Container(height: 15.0)),
            Center(
              child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      _result =
                        "Comida Brasileira: $_brazilianFood\n"
                        "Comida Mexicana: $_mexicanFood\n"
                        "Escolha comida: $_radioChoose\n"
                        "Comida Peruana: $_switchValue\n"
                        "Valor do slider: $_sliderValue";
                    });
                  },
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  )
              ),
            ),
            SizedBox(child: Container(height: 30.0)),
            Text(
              _result,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.left,
            )
          ],
        ),
      )
    );
  }
}
