import 'dart:convert';
import 'package:weather_app/src/models/location.dart';
import 'package:http/http.dart';

class LocationApi {
  const LocationApi({required Client client, required String apiUrl})
      : _client = client,
        _apiUrl = apiUrl;
  final Client _client;
  final String _apiUrl;

  Future<Location> getLocation() async {
    final Response response = await _client.get(Uri.parse(_apiUrl));
    if (response.statusCode >= 300) {
      throw StateError(response.body);
    }
    return Location.fromJson(jsonDecode(response.body));
  }
}
