import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/loading.dart';
import '../widgets/weather_display.dart';
import 'city_screen.dart';


class HomeScreen extends StatefulWidget {
  final dynamic jsonParsed;
  // ignore: use_key_in_widget_constructors
  const HomeScreen({this.jsonParsed});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherModel weatherData;
  late bool _isLoading;
  @override
  void initState() {
    super.initState();
    _isLoading = false;
    weatherData = WeatherModel.fromJson(jsonParsed: widget.jsonParsed);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('${weatherData.cityName}'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                Location location = Location();
                LocationData locationData = await location.getLocation();
                try {
                  dynamic jsonParsed = await WeatherService.getByCoordinate(
                    lon: locationData.longitude!,
                    lat: locationData.latitude!,
                  );
                  setState(() {
                    weatherData = WeatherModel.fromJson(jsonParsed: jsonParsed);
                    _isLoading = false;
                  });
                } catch (e) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
            IconButton(
                icon: const Icon(Icons.location_city),
                onPressed: () async {
                  WeatherModel weatherFormData =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CityScreen(),
                    ),
                  );
                  // ignore: unnecessary_null_comparison
                  if (weatherFormData != null) {
                    setState(() {
                      weatherData = weatherFormData;
                    });
                  }
                }),
          ],
        ),
        body: _isLoading ? Loading() : WeatherDisplay(weatherData: weatherData),
      ),
    );
  }
}
