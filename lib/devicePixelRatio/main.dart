import 'package:flutter/material.dart';

class DevicePixelRatioApp extends StatelessWidget {
  const DevicePixelRatioApp({super.key});

  final title = "Seleção automática de imagens";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        scaffoldBackgroundColor: Colors.white,
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
  @override
  Widget build(BuildContext context) {
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    // Show pixelRatio for each device
    print("Device pixel ratio: ${pixelRatio.toString()}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        // Based on pixelRatio it will show a different image
        child: Image.asset("assets/images/pixelRatio/icone.png"),
      ),
    );
  }
}
