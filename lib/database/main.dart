import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase extends StatelessWidget {
  const AppDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const MyHomePage(title: 'Database'),
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
  _retrieveDatabase() async {
    final dbPath = await getDatabasesPath();
    final localDb = join(dbPath, "database.db");

    return await openDatabase(
      localDb,
      version: 1,
      onCreate: (db, currentVersion) {
        var sql =
            "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";
        db.execute(sql);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _retrieveDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(padding: EdgeInsets.all(16), child: Column()),
    );
  }
}
