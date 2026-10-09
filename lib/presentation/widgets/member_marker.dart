import 'package:google_maps_flutter/google_maps_flutter.dart';

class MemberMarker {
  final String id;
  final String name;
  final String city;
  final double latitude;
  final double longitude;

  const MemberMarker({
    required this.id,
    required this.name,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  Marker toMarker() {
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: name, snippet: city),
    );
  }
}
