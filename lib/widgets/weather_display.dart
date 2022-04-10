import 'package:flutter/material.dart';

import '../models/weather_model.dart';

const kCityName = TextStyle(
  fontSize: 40,
  color: Colors.blue,
  fontWeight: FontWeight.bold,
);
const kDetailsName = TextStyle(
  fontSize: 30,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

class WeatherDisplay extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const WeatherDisplay({required this.weatherData});
  final WeatherModel weatherData;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'พยากรณ์อากาศ',
              style: kDetailsName,
            ),
          ),
          Expanded(
            child: Text(
              '${weatherData.cityName}',
              style: kCityName,
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.network(
              'https://openweathermap.org/img/w/${weatherData.getIconName()}.png',
              scale: 0.4,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              weatherData.getDescription(),
              style: const TextStyle(fontSize: 40),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              '${weatherData.getTemp().toStringAsFixed(0)} °C',
              style: const TextStyle(fontSize: 60),
            ),
          ),
        ],
      ),
    );
  }
}
