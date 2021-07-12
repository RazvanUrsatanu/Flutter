import 'package:flutter/material.dart';
import 'package:weather_app/src/container/loading_container.dart';
import 'package:weather_app/src/container/location_container.dart';
import 'package:weather_app/src/container/weather_container.dart';
import 'package:weather_app/src/models/location.dart';
import 'package:weather_app/src/models/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.tealAccent,
      ),
      body: LoadingContainer(
        builder: (BuildContext context, bool isLoading) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return LocationContainer(
            builder: (BuildContext context, Location? location) {
              return WeatherContainer(builder: (BuildContext context, Weather? weather) {
                return Column(
                  children: <Widget>[
                    if (location != null) Text('Location: ${location.city}'),
                    if (weather != null) Text('Weather: ${weather.current.temp}')
                  ],
                );
              });
            },
          );
        },
      ),
    );
  }
}
