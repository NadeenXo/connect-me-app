import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/member_marker.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 5.5,
  );

  static const List<MemberMarker> _members = [
    MemberMarker(
      id: 'cairo_member',
      name: 'Nadeen',
      city: 'Cairo',
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    MemberMarker(
      id: 'alexandria_member',
      name: 'Omar',
      city: 'Alexandria',
      latitude: 31.2001,
      longitude: 29.9187,
    ),
    MemberMarker(
      id: 'giza_member',
      name: 'Sara',
      city: 'Giza',
      latitude: 30.0131,
      longitude: 31.2089,
    ),
  ];

  Set<Marker> _buildMarkers() {
    return _members.map((member) => member.toMarker()).toSet();
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
