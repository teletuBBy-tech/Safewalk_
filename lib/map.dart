import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  LatLng _currentPosition = const LatLng(28.6139, 77.2090); // Default position until the actual location is obtained
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final List<LatLng> _userPath = [];
  bool _isLoading = true; 

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _checkLocationService();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission denied. Please enable it in settings.')),
      );
    }
  }

  Future<void> _checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled. Please enable them in settings.')),
      );
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("Live Location: ${position.latitude}, ${position.longitude}"); // Debugging output

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: const MarkerId("current_location"),
            position: _currentPosition,
            infoWindow: const InfoWindow(title: "You are here"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
        _isLoading = false; 
      });

      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 15.0),
      );
      _trackUserMovement();
    } catch (e) {
      print("Error getting current location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get current location')),
      );
      setState(() { 
        
        _isLoading = false; 
      });
    }
  }

  void _trackUserMovement() {
    Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)).listen((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _userPath.add(_currentPosition);

        _polylines.add(
          Polyline(
            polylineId: const PolylineId("user_path"),
            color: Colors.blue,
            width: 5,
            points: _userPath,
          ),
        );

        _markers.add(
          Marker(
            markerId: const MarkerId("current_location"),
            position: _currentPosition,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );

        mapController.animateCamera(
          CameraUpdate.newLatLng(_currentPosition),
        );
      });
    });
  }

  void _addHighCrimeAreaMarkers() {
    final List<LatLng> highCrimeAreas = [
      const LatLng(45.525563, -122.677433), 
    ];

    for (LatLng area in highCrimeAreas) {
      _markers.add(
        Marker(
          markerId: MarkerId(area.toString()),
          position: area,
          infoWindow: const InfoWindow(title: "High Crime Area"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Services'),
        backgroundColor: Colors.green[700],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15.0,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addHighCrimeAreaMarkers();
    
  }
}
