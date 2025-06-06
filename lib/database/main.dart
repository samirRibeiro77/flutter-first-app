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
  Future<Database> _retrieveDatabase() async {
    final dbPath = await getDatabasesPath();
    final localDb = join(dbPath, "database.db");

    return await openDatabase(
      localDb,
      version: 1,
      onCreate: (db, currentVersion) {
        var sql =
            "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, age INTEGER)";
        db.execute(sql);
      },
    );
  }

  _saveUser() async {
    var db = await _retrieveDatabase();
    var user = {
      "name": "testUser",
      "age": 15
    };

    var id = await db.insert("users", user);
  }

  _listUsers() async {
    var db = await _retrieveDatabase();

    var sql = "SELECT * FROM users";
    List users = await db.rawQuery(sql);

    for(var user in users) {
      print("Users: ${user.toString()}");
    }
  }

  _getUserById(int id) async {
    var db = await _retrieveDatabase();

    List users = await db.query(
        "users",
        columns: ["id", "name", "age"],
        where: "id = ?",
        whereArgs: [id]
    );

    for(var user in users) {
      print("Users: ${user.toString()}");
    }
  }

  _deleteUser(String name) async {
    var db = await _retrieveDatabase();

    int quantity = await db.delete(
      "users",
        where: "name = ?",
        whereArgs: [name]
    );

    print("Quantidade de usuários deletados: $quantity");
  }

  @override
  void initState() {
    super.initState();
    // _saveUser();
    // _getUserById(1);
    // _deleteUser("testUser");

    _listUsers();
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
