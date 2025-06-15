import 'package:flutter/material.dart';

class MedicalChat extends StatelessWidget {
  const MedicalChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini medico',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
