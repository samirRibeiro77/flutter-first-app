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
  Set<Marker> _markers = {};

  _moveCamera() async {
    var controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(-15.802304, -47.8638722),
          zoom: 17,
          tilt: 45,
          bearing: 30,
        ),
      ),
    );
  }

  _loadMarkers() {
    Set<Marker> markers = {};

    var shopping = Marker(
      markerId: MarkerId("shopping-marker"),
      position: LatLng(-15.7912398, -47.8832043),
      infoWindow: InfoWindow(title: "Norte Shopping"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      rotation: 45,
      onTap: () => print("Shopping clicked"),
    );
    markers.add(shopping);

    var itamaraty = Marker(
      markerId: MarkerId("itamaraty-palace"),
      position: LatLng(-15.8006794, -47.8674376),
      infoWindow: InfoWindow(title: "Itamaraty Palace"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      onTap: () => print("Itamaraty clicked"),
    );
    markers.add(itamaraty);

    setState(() {
      _markers = markers;
    });
  }

  @override
  void initState() {
    _loadMarkers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-15.7995427, -47.8645249),
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: _moveCamera,
        child: Icon(Icons.done),
      ),
    );
  }
}
