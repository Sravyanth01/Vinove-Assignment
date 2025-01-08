import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Global/Person.dart';

class LocationDetails extends StatelessWidget {
  final String icon;
  final String text;
  final Color color;

  const LocationDetails({
    required this.icon,
    required this.text,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Icon(Icons.location_on, color: color, size: 20),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RouteScreen extends StatelessWidget {
  final Person person;

  const RouteScreen(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.teal,
        title: const Text('VIEW ROUTE', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${person.name} (${person.id})",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
          const Divider(thickness: 1, height: 1),
          const LocationDetails(
            icon: 'location_on',
            color: Colors.green,
            text: 'Connaught Place, New Delhi Stop: Saket Metro Station',
          ),
          const LocationDetails(
            icon: 'location_on',
            color: Colors.red,
            text: 'DLF Cyber City, Gurugram, Delhi NCR',
          ),
          const Divider(thickness: 1, height: 2),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _InfoColumn(label: 'Total Kms', value: '22.5 Kms'),
              _Divider(),
              _InfoColumn(label: 'Total Duration', value: '45 Min'),
            ],
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(28.6139, 77.2090),
                zoom: 12,
              ),
              polylines: {
                const Polyline(
                  polylineId: PolylineId('route'),
                  points: [
                    LatLng(28.6139, 77.2090), // Connaught Place
                    LatLng(28.5244, 77.1855), // Saket
                    LatLng(28.4959, 77.0926), // Gurugram
                  ],
                  color: Colors.teal,
                  width: 5,
                ),
              },
              markers: {
                const Marker(
                  markerId: MarkerId('start'),
                  position: LatLng(28.6139, 77.2090),
                  infoWindow: InfoWindow(title: 'Start at 09:00 am'),
                ),
                const Marker(
                  markerId: MarkerId('stop'),
                  position: LatLng(28.4959, 77.0926),
                  infoWindow: InfoWindow(title: 'Stop at 09:45 am'),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const _InfoColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 20, width: 1, color: Colors.grey);
  }
}