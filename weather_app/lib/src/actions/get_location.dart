import 'package:weather_app/src/models/location.dart';

class GetLocation {}

class GetLocationSuccessful {
  final Location location;

  GetLocationSuccessful(this.location);

  @override
  String toString() {
    return 'GetLocationSuccessful{location: $location}';
  }
}

class GetLocationError {
  final dynamic error;

  GetLocationError(this.error);

  @override
  String toString() {
    return 'GetLocationError{error: $error}';
  }
}
