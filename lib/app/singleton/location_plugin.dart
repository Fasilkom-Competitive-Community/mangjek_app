import 'package:location/location.dart';

class LocationPluginSingleton {
  static Location? _location;

  static Location getLocationPlugin() {
    if (_location == null) {
      _location = Location();
    }

    return _location!;
  }
}
