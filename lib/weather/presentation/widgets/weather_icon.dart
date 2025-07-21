import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String? condition;
  final double size;

  const WeatherIcon({
    Key? key,
    required this.condition,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition == null) {
      return Icon(Icons.wb_cloudy, size: size, color: Colors.grey);
    }
    switch (condition!.toLowerCase()) {
      case 'clear':
        return Icon(Icons.wb_sunny, color: Colors.orange, size: size);
      case 'clouds':
        return Icon(Icons.cloud, color: Color.fromARGB(255, 79, 128, 152), size: size);
      case 'rain':
      case 'drizzle':
        return Icon(Icons.beach_access, color: Colors.blue, size: size);
      case 'snow':
        return Icon(Icons.ac_unit, color: Color.fromARGB(255, 99, 106, 109), size: size);
      case 'thunderstorm':
        return Icon(Icons.flash_on, color: Colors.yellow, size: size);
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return Icon(Icons.filter_drama, color: Colors.grey, size: size);
      default:
        return Icon(Icons.wb_cloudy, size: size, color: Colors.grey);
    }
  }
}
