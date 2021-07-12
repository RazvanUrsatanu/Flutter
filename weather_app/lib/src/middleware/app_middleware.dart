import 'package:redux/redux.dart';
import 'package:weather_app/src/actions/get_location.dart';
import 'package:weather_app/src/actions/get_weather.dart';
import 'package:weather_app/src/data/location_api.dart';
import 'package:weather_app/src/data/weather_api.dart';
import 'package:weather_app/src/models/app_state.dart';
import 'package:weather_app/src/models/location.dart';
import 'package:weather_app/src/models/weather.dart';

class AppMiddleware {
  const AppMiddleware({required LocationApi locationApi, required WeatherApi weatherApi})
      : _locationApi = locationApi,
        _weatherApi = weatherApi;
  final LocationApi _locationApi;
  final WeatherApi _weatherApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, GetLocation>(_getLocation),
      TypedMiddleware<AppState, GetLocationSuccessful>(_getLocationSuccessful),
    ];
  }

  Future<void> _getLocation(Store<AppState> store, GetLocation action, NextDispatcher next) async {
    next(action);
    try {
      final Location location = await _locationApi.getLocation();
      store.dispatch(GetLocationSuccessful(location));
    } catch (err) {
      store.dispatch(GetLocationError(err));
    }
  }

  Future<void> _getLocationSuccessful(Store<AppState> store, GetLocationSuccessful action, NextDispatcher next) async {
    next(action);
    try {
      final Weather weather = await _weatherApi.getWeather(action.location.lat, action.location.lon);
      store.dispatch(GetWeatherSuccessful(weather));
    } catch (err) {
      store.dispatch(GetWeatherError(err));
    }
  }
}
