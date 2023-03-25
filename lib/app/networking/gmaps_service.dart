import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/networking/dio/base_api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';

class GmapService extends BaseApiService {
  GmapService({BuildContext? buildContext}) : super(buildContext);
  final String apiKey = getEnv('GMAPS_API_KEY');
  final String lokasiIndralaya = "-3.218753,104.649665";
  // final String autoComp = '';

  @override
  String get baseUrl => 'https://maps.googleapis.com/maps/api/place';

  @override
  final interceptors = {
    if (getEnv('APP_DEBUG') == true) PrettyDioLogger: PrettyDioLogger()
  };

  Future fetchSuggestionData(String input) async {
    return await network(
      request: (request) => request.get(
          "/autocomplete/json?location=$lokasiIndralaya&strictbounds=true&radius=2000&input=$input&language=id&region=id&key=$apiKey"),
    );
  }

  Future getLatLangFromMapId(String placeId) async {
    return await network(
      request: (request) =>
          request.get("/details/json?place_id=$placeId&key=$apiKey"),
    );
  }
}
