import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  var _isCurrentLocation = false;

  Set<Marker> _markers = {};
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};

  final _initialCameraPosition = CameraPosition(
    target: LatLng(-15.7938468, -47.8827707),
    zoom: 14,
  );

  var _cameraPosition = CameraPosition(
    target: LatLng(-15.7938468, -47.8827707),
    zoom: 12,
  );

  _moveCamera() async {
    var controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  _goTo({bool current = false}) async {
    var camera = _initialCameraPosition;
    if (current) {
      var currentLocation = await _getCurrentLocation();
      camera = CameraPosition(target: currentLocation, zoom: 16);
    }

    setState(() {
      _isCurrentLocation = current;
      _cameraPosition = camera;
    });

    _moveCamera();
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
      onTap: () => print("North Wing clicked"),
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
      onTap: () => print("South Wing clicked"),
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
      onTap: () => print("Middle aeroplane clicked"),
    );
    polygonList.add(polygon3);

    setState(() {
      _polygons = polygonList;
    });
  }

  _loadPolylines() {
    Set<Polyline> polylineList = {};
    var polyline1 = Polyline(
      polylineId: PolylineId("polyline-1"),
      color: Colors.green,
      width: 5,
      startCap: Cap.buttCap,
      endCap: Cap.buttCap,
      jointType: JointType.mitered,
      points: [
        LatLng(-15.733189932116042, -47.893325066931986),
        LatLng(-15.793846882972336, -47.88277072847316),
        LatLng(-15.835881125542555, -47.926966038691795),
      ],
      consumeTapEvents: true,
      zIndex: 0,
      onTap: () => print("Wings clicked"),
    );
    polylineList.add(polyline1);

    setState(() {
      _polylines = polylineList;
    });
  }

  Future<LatLng> _getCurrentLocation() async {
    var position = await _determinePosition();

    return LatLng(position.latitude, position.longitude);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  _createLocationListener() {
    var settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    Geolocator.getPositionStream(locationSettings: settings).listen((position) {
      setState(() {
        _isCurrentLocation = true;
        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16,
        );
      });
      _moveCamera();
    });
  }

  @override
  void initState() {
    _loadMarkers();
    _loadPolygons();
    _loadPolylines();
    // _getCurrentLocation();
    _createLocationListener();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        polygons: _polygons,
        polylines: _polylines,
        myLocationEnabled: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _isCurrentLocation ? _goTo() : _goTo(current: true),
        child: Icon(
          _isCurrentLocation ? Icons.map_outlined : Icons.my_location,
        ),
      ),
    );
  }
}
