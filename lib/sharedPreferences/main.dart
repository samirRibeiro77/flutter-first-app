import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends StatelessWidget {
  const SharedPrefs({super.key});

  final appName = "Shared Preferences";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: MyHomePage(title: appName),
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
  final _key = "sharedPrefsApp";
  final _nothing = "Nothing saved yet...";
  var _data = "";
  final TextEditingController _controller = TextEditingController();

  _save() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_key, _controller.text);
  }

  _read() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _data = preferences.getString(_key) ?? _nothing;
    });
  }

  _delete() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(_key);
  }

  @override
  void initState() {
    super.initState();
    _read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shared Preferences",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(_data, style: Theme.of(context).textTheme.titleLarge),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                decoration: InputDecoration(labelText: "Type something"),
                controller: _controller,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _save,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text("Save", style: TextStyle(fontSize: 15)),
                  ),
                ),
                ElevatedButton(
                  onPressed: _read,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text("Read", style: TextStyle(fontSize: 15)),
                  ),
                ),
                ElevatedButton(
                  onPressed: _delete,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text("Delete", style: TextStyle(fontSize: 15)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
