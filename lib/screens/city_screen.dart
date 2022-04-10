import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/show_alert_dialog.dart';

TextStyle kTextFieldStyle = const TextStyle(
  decorationColor: Colors.red,
  color: Colors.blueGrey,
);

// ignore: use_key_in_widget_constructors
class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late bool isLoading;
  late TextEditingController cityController;
  @override
  void initState() {
    super.initState();
    cityController = TextEditingController();
    isLoading = false;
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'เมือง/ประเทศ',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'กรอกชื่อเมือง หรือ ชื่อประเทศ',
                      focusColor: Colors.pink,
                      labelStyle: kTextFieldStyle,
                      icon: const Icon(
                        Icons.location_city,
                        color: Colors.blueGrey,
                      ),
                      fillColor: Colors.blueGrey,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent),
                      ),
                    ),
                    controller: cityController,
                    autofocus: true,
                    autocorrect: false,
                    style: kTextFieldStyle,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Text('ยกเลิก'),
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        child: const Text('ตกลง'),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            var jsonParsed = await WeatherService.getByCity(
                                cityName: cityController.text);
                            WeatherModel weatherData =
                                WeatherModel.fromJson(jsonParsed: jsonParsed);
                            Navigator.of(context).pop(weatherData);
                          } catch (e) {
                            await showAlertDialog(
                              context,
                              title: 'ข้อผิดพลาด',
                              content: 'ไม่พบชื่อเมือง/ประเทศ ที่คุณกรอก',
                              defaultActionText: 'ตกลง',
                            );
                            cityController.clear();
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
