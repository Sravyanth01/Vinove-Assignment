import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vinove_assignemnt/Components/Route_Page.dart';
import '../Global/Person.dart';

class LocationHistoryScreen extends StatefulWidget {
  final Person person;
  const LocationHistoryScreen(this.person, {super.key});
  @override
  State<LocationHistoryScreen> createState() => _LocationHistoryScreenState();
}

class _LocationHistoryScreenState extends State<LocationHistoryScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(28.6139, 77.2090),
    zoom: 14
  );
  
  final List<Marker> _markers = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.6139, 77.2090),
      infoWindow: InfoWindow(title: 'Connaught Place'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildMap(),
          _buildLocationMarker(),
          _buildUserBar(),
          _buildTimelineSheet(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.teal,
      title: const Text('Location History', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      mapType: MapType.normal,
      compassEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) => _controller.complete(controller),
      markers: _markers.toSet(),
      circles: {
        Circle(
          circleId: const CircleId('radius'),
          center: const LatLng(28.6139, 77.2090),
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
    return const Positioned(
      top: 350,
      left: 170,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde"),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text("5 min ago"),
            ),
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
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde'),
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
              child: const Text('Change', style: TextStyle(color: Colors.teal, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: Column(
          children: [
            _buildDragHandle(),
            _buildHeaderSection(),
            const Divider(),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: _buildTimelineItems(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      height: 5,
      width: 50,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Text('Total Sites: ', style: TextStyle(fontSize: 16)),
              Text('10', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.arrow_back_ios_new, color: Colors.teal.shade300, size: 16),
              const Text('Wed, Jan 08 2025', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              const SizedBox(width: 20),
              const Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> _buildTimelineItems(BuildContext context) {
  final locations = [
    {"address": "Saket, New Delhi", "time": "Left at 08:30 am"},
    {"address": "Connaught Place, New Delhi", "time": "09:45 am - 12:45 pm"},
    {"address": "Nehru Place, New Delhi", "time": "02:15 pm - 02:30 pm"},
    {"address": "Lajpat Nagar, New Delhi", "time": "03:00 pm - 03:25 pm"},
    {"address": "Greater Kailash, New Delhi", "time": "04:00 pm - 04:15 pm"},
    {"address": "Hauz Khas, New Delhi", "time": "05:00 pm - 06:00 pm"},
    {"address": "Vasant Kunj, New Delhi", "time": "06:15 pm - 06:45 pm"},
    {"address": "Green Park, New Delhi", "time": "07:25 pm - 07:30 pm"},
    {"address": "Saket, New Delhi", "time": "08:05 pm"},
  ];

  return locations.map((location) => _buildTimelineTile(
    context,
    location["address"]!,
    location["time"]!,
    location == locations.first
  )).toList();
}
Widget _buildTimelineTile(BuildContext context, String title, String subtitle, bool isFirst) {
  return ListTile(
    minLeadingWidth: 15, // Reduce leading width
    contentPadding: const EdgeInsets.symmetric(horizontal: 10), // Adjust padding
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.circle, color: Colors.teal, size: 8), // Reduce circle size
        if (!isFirst) Container(
          height: 35, // Reduce line height
          width: 1.5, // Make line thinner
          color: Colors.teal
        ),
      ],
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14, // Reduce font size
      )
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(fontSize: 12) // Reduce subtitle size
    ),
    trailing: IconButton(
      padding: EdgeInsets.zero, // Remove padding
      constraints: const BoxConstraints(), // Minimize constraints
      icon: const Icon(Icons.chevron_right, size: 20),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RouteScreen(
            Person("Amit Kumar", "AK1234", "Online", "Delhi", "110001")
          ),
        ),
      ),
    ),
  );
}