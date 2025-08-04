
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng _location = const LatLng(-9.7973558, 13.2982954);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local da Emissora')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _location,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('emissora'),
            position: _location,
            infoWindow: const InfoWindow(title: 'Endereço da Emissora'),
          ),
        },
      ),
    );
  }
}
