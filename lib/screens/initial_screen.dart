import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather/screens/settings_screen.dart';
import '../services/weather_service.dart';
import '../widgets/loading.dart';
import 'home_screen.dart';

class InitialScreen extends StatefulWidget {
  final WeatherService? weather;
  // ignore: use_key_in_widget_constructors
  const InitialScreen({this.weather});
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  dynamic jsonParsed;
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
      }
    }
    LocationData locationData = await location.getLocation();
    jsonParsed = await WeatherService.getByCoordinate(
      lon: locationData.longitude!,
      lat: locationData.latitude!,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          jsonParsed: jsonParsed,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Loading(),
      ),
    );
  }
}
