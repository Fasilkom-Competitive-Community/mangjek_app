import 'package:nylo_framework/nylo_framework.dart';

class Config {
  static late String GMAPS_API_KEY;
  static late String API_BASE_URL;

  static initializeConfig() {
    Config.GMAPS_API_KEY = getEnv("GMAPS_API_KEY");
    Config.API_BASE_URL = getEnv("API_BASE_URL");
  }
}
