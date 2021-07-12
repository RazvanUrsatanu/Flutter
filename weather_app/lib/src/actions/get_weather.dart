import 'package:weather_app/src/models/location.dart';
import 'package:weather_app/src/models/weather.dart';

class GetWeather {
  final double lon;
  final double lat;
  GetWeather(this.lat, this.lon);
}

class GetWeatherSuccessful {
  final Weather weather;

  GetWeatherSuccessful(this.weather);

  @override
  String toString() {
    return 'GetWeatherSuccessful{weather: $weather}';
  }
}

class GetWeatherError {
  final dynamic error;

  GetWeatherError(this.error);

  @override
  String toString() {
    return 'GetWeatherError{error: $error}';
  }
}
