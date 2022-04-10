class WeatherModel {
  dynamic id;
  dynamic cityName;
  Map<String, dynamic>? coord;
  List<dynamic>? weather;
  Map<String, dynamic>? mainData;
  WeatherModel(
      {this.id, this.cityName, this.coord, this.weather, this.mainData});
  WeatherModel.fromJson({required dynamic jsonParsed}) {
    id = jsonParsed['id'];
    cityName = jsonParsed['name'];
    coord = jsonParsed['coord'];
    weather = jsonParsed['weather'];
    mainData = jsonParsed['main'];
  }
  String getIconName() {
    return weather![0]['icon'];
  }

  String getDescription() {
    String description = weather![0]['description'];
    switch (description) {
      case 'clear sky':
        return 'ฟ้าโปร่ง';
      case 'overcast clouds':
        return 'เมฆครึ้ม';
      case 'few clouds':
        return 'เมฆเล็กน้อย';
      case 'scattered clouds':
        return 'เมฆกระจายเป็นหย่อมๆ';
      case 'broken clouds':
        return 'เมฆเป็นส่วนมาก';
      case 'shower rain':
        return 'ฝนซู่';
      case 'rain':
        return 'ฝนตก';
      case 'moderate rain':
        return 'ฝนตกปานกลาง';
      case 'light rain':
        return 'ฝนโปรย';
      case 'thunderstorm':
        return 'ฝนฟ้าคะนอง';
      case 'light snow':
        return 'หิมะเล็กน้อย';
      case 'snow':
        return 'หิมะตก';
      case 'mist':
        return 'หมอกจางๆ';
      case 'fog':
        return 'หมอกลงจัด';
      default:
        return 'ไม่พบข้อมูล';
    }
  }

  int getPressure() {
    return mainData?['pressure'];
  }

  int getHumidity() {
    return mainData?['humidity'];
  }

  double getTemp() {
    return mainData?['temp'].toDouble();
  }
}
