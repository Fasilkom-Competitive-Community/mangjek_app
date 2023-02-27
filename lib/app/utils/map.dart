import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

Future<LatLng> getCurrentLocation(Location location) async {
  LocationData loc = await location.getLocation();
  return LatLng(loc.latitude!, loc.longitude!);
}
