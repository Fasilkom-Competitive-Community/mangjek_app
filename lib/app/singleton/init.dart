import 'package:mangjek_app/app/config/config.dart';
import 'package:mangjek_app/app/singleton/location_plugin.dart';

Future<void> initSingleton() async {
  LocationPluginSingleton.getLocationPlugin();
  Config.initializeConfig();
}
