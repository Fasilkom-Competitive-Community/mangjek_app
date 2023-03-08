class objLoc {
  String _latitude = "-3.218753";
  String _longitude = "104.649665";
  String _nama = "";
  String _placeID = "";

  String get latitude => _latitude;
  String get longitude => _longitude;
  String get nama => _nama;
  String get placeID => _placeID;

  set latitude(String latitude) {
    _latitude = latitude;
  }

  set longitude(String longitude) {
    _longitude = longitude;
  }

  set nama(String nama) {
    _nama = nama;
  }

  set placeID(String placeID) {
    _placeID = placeID;
  }
}
