import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weather_app/src/models/app_state.dart';
import 'package:weather_app/src/models/weather.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<Weather?> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Weather?>(
      converter: (Store<AppState> store) => store.state.weather,
      builder: builder,
    );
  }
}
