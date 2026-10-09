import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 5.5,
  );

  Set<Marker> _buildMarkers() {
    return {
      const Marker(
        markerId: MarkerId('cairo_member'),
        position: LatLng(30.0444, 31.2357),
        infoWindow: InfoWindow(title: 'Nadeen', snippet: 'Cairo'),
      ),
      const Marker(
        markerId: MarkerId('alexandria_member'),
        position: LatLng(31.2001, 29.9187),
        infoWindow: InfoWindow(title: 'Omar', snippet: 'Alexandria'),
      ),
      const Marker(
        markerId: MarkerId('giza_member'),
        position: LatLng(30.0131, 31.2089),
        infoWindow: InfoWindow(title: 'Sara', snippet: 'Giza'),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Map')),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        markers: _buildMarkers(),
        zoomControlsEnabled: true,
        myLocationButtonEnabled: false,
      ),
    );
  }
}
