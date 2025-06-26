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
  Set<Polygon> _polygons = {};

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
    Set<Marker> markerList = {};

    var shopping = Marker(
      markerId: MarkerId("shopping-marker"),
      position: LatLng(-15.7912398, -47.8832043),
      infoWindow: InfoWindow(title: "Norte Shopping"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      rotation: 45,
      onTap: () => print("Shopping clicked"),
    );
    markerList.add(shopping);

    var itamaraty = Marker(
      markerId: MarkerId("itamaraty-palace"),
      position: LatLng(-15.8006794, -47.8674376),
      infoWindow: InfoWindow(title: "Itamaraty Palace"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      onTap: () => print("Itamaraty clicked"),
    );
    markerList.add(itamaraty);

    setState(() {
      _markers = markerList;
    });
  }

  _loadPolygons() {
    Set<Polygon> polygonList = {};
    var polygon1 = Polygon(
      polygonId: PolygonId("polygon-1"),
      fillColor: Colors.transparent,
      strokeColor: Colors.orange,
      strokeWidth: 5,
      points: [
        LatLng(-15.733501, -47.893201),
        LatLng(-15.789904, -47.889015),
        LatLng(-15.794626, -47.875734),
      ],
      consumeTapEvents: true,
      zIndex: 0,
      onTap: () => print("North Wing")
    );
    polygonList.add(polygon1);

    var polygon2 = Polygon(
        polygonId: PolygonId("polygon-2"),
        fillColor: Colors.transparent,
        strokeColor: Colors.orange,
        strokeWidth: 5,
        points: [
          LatLng(-15.835875, -47.926906),
          LatLng(-15.793028, -47.890241),
          LatLng(-15.796952, -47.876492),
        ],
        consumeTapEvents: true,
        zIndex: 0,
        onTap: () => print("South Wing")
    );
    polygonList.add(polygon2);

    var polygon3 = Polygon(
        polygonId: PolygonId("polygon-3"),
        fillColor: Colors.transparent,
        strokeColor: Colors.purple,
        strokeWidth: 5,
        points: [
          LatLng(-15.794626, -47.875734),
          LatLng(-15.775467, -47.937600),
          LatLng(-15.777482, -47.938298),
          LatLng(-15.796952, -47.876492),
          LatLng(-15.800621, -47.861271),
        ],
        consumeTapEvents: true,
        zIndex: 1,
        onTap: () => print("Middle aeroplane")
    );
    polygonList.add(polygon3);

    setState(() {
      _polygons = polygonList;
    });
  }

  @override
  void initState() {
    _loadMarkers();
    _loadPolygons();

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
        polygons: _polygons,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: _moveCamera,
        child: Icon(Icons.done),
      ),
    );
  }
}
