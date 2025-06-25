import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppMaps extends StatelessWidget {
  const AppMaps({super.key});

  final title = "Maps & Geolocation";

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
  final _controller = Completer<GoogleMapController>();
  bool _mountain = true;

  static const CameraPosition _sugarLoaf = CameraPosition(
    target: LatLng(-22.950684,-43.1610249),
    zoom: 15.5,
  );

  static const CameraPosition _sugarLoafHike = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-22.9529811,-43.1626918),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheClimb() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_sugarLoafHike));

    setState(() {
      _mountain = false;
    });
  }

  Future<void> _goToTheMountain() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_sugarLoaf));

    setState(() {
      _mountain = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _sugarLoaf,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mountain ? _goToTheClimb : _goToTheMountain,
        label: Text(_mountain ? "To the hike!" : "To the mountain!"),
        icon: Icon(_mountain ? Icons.hiking : Icons.map_outlined),
      ),
    );
  }
}
