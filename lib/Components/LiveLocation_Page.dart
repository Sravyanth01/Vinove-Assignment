import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Global/Person.dart';

class LiveLocationScreen extends StatefulWidget {
  final Person person;
  const LiveLocationScreen(this.person, {super.key});

  @override
  State<LiveLocationScreen> createState() => _LiveLocationScreenState();
}

class _LiveLocationScreenState extends State<LiveLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  
  // Qutub Minar coordinates
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(28.5244, 77.1855),
    zoom: 14
  );
      
  final List<Marker> _markers = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.5244, 77.1855),
      infoWindow: InfoWindow(title: 'Qutub Minar'),
    )
  ];

// Previous imports remain the same...

  Future<Position> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission permanently denied');
      }
      
      return await Geolocator.getCurrentPosition();
    } catch (error) {
      print("Error getting location: $error");
      rethrow;
    }
  }

// Rest of the code remains the same...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: _buildLocationButton(),
      body: Stack(
        children: [
          _buildMap(),
          _buildLocationMarker(),
          _buildUserBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.teal,
      title: const Text('Track Live Location', style: TextStyle(color: Colors.white)),
    );
  }

  FloatingActionButton _buildLocationButton() {
    return FloatingActionButton(
      onPressed: _updateLocation,
      backgroundColor: Colors.teal,
      child: const Icon(Icons.location_on),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      mapType: MapType.normal,
      compassEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: _markers.toSet(),
      circles: {
        Circle(
          circleId: const CircleId('radius'),
          center: const LatLng(28.5244, 77.1855),
          radius: 500,
          fillColor: Colors.teal.withOpacity(0.2),
          strokeColor: Colors.teal,
          strokeWidth: 2,
        ),
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }

  Widget _buildLocationMarker() {
    return Positioned(
      top: 350,
      left: 170,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde"),
              ),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: const Text("5 min ago"),
          )
        ],
      ),
    );
  }

  Widget _buildUserBar() {
    return Positioned(
      top: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde'
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "${widget.person.name} (${widget.person.id})",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Change',
                style: TextStyle(color: Colors.teal, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateLocation() async {
    final position = await _getCurrentLocation();
    final newMarker = Marker(
      markerId: const MarkerId('2'),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: const InfoWindow(title: "Current Location")
    );
    
    setState(() => _markers.add(newMarker));
    
    final cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14
    );

    final controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}