import 'package:weather_app/src/models/location.dart';

class GetLocation {}

class GetLocationSuccessful {
  GetLocationSuccessful(this.location);

  final Location location;

  @override
  String toString() {
    return 'GetLocationSuccessful{location: $location}';
  }
}

class GetLocationError {
  GetLocationError(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'GetLocationError{error: $error}';
  }
}
