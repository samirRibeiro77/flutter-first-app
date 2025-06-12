import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppFirebase extends StatelessWidget {
  const AppFirebase({super.key});

  final title = "Firebase";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: title),
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
  final _db = FirebaseFirestore.instance;

  _usingFirebase() async {
    // _db.collection("users").doc("002").set({
    //   "name": "Vanessa",
    //   "age": "30"
    // });

    // var ref = await _db.collection("news").add({
    //   "title": "Heat waves in São Paulo",
    //   "description": "Some descriptions goes here..."
    // });
    // print("Saved item: ${ref.id}");

    // _db.collection("users").doc("001").get().then((doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     print("Document: $data");
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

    // _db.collection("users").get().then((querySnapshot) {
    //     for (var docSnapshot in querySnapshot.docs) {
    //       print('${docSnapshot.id} => ${docSnapshot.data()}');
    //     }
    //   },
    //   onError: (e) => print("Error completing: $e"),
    // );

    // _db.collection("users").snapshots().listen((snapshot) {
    //   for (var docSnapshot in snapshot.docs) {
    //     print('${docSnapshot.id} => ${docSnapshot.data()}');
    //   }
    // },
    // onError: (error) => print("Listen failed: $error"),
    // );

    // _db.collection("users")
    //     // .where("name", isEqualTo: "Vanessa")
    //     .where("age", isGreaterThan: "29")
    //     .where("age", isLessThan: "40")
    //     .orderBy("age", descending: true)
    //     .orderBy("name", descending: false)
    //     .limit(2)
    //     .get()
    //     .then((querySnapshot) {
    //       for (var docSnapshot in querySnapshot.docs) {
    //         print('${docSnapshot.id} => ${docSnapshot.data()}');
    //       }
    //     }, onError: (e) => print("Error completing: $e"));

    var search = "Marc";
    _db.collection("users")
        .where("name", isGreaterThanOrEqualTo: search)
        .where("name", isLessThanOrEqualTo: "$search\uf8ff")
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    }, onError: (e) => print("Error completing: $e"));
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    _usingFirebase();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: Container(),
    );
  }
}
