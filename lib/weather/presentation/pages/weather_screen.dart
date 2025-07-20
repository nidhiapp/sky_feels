
// import 'package:flutter/material.dart';
// import 'package:sky_feels/core/app_theme.dart';
// import 'package:sky_feels/weather/domain/entities/weather_entity.dart';

// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({super.key});

//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Stack(alignment: Alignment.bottomCenter,
//         children: [
//         Container(
//           decoration: const BoxDecoration(
//             gradient: RadialGradient(colors: [WeatherAppTheme.gradientBlue1, WeatherAppTheme.gradientBlue2],
//               center: Alignment.center,
//               radius: 1.0,
//               stops: [0.0, 1.0],
//               tileMode: TileMode.clamp),
//                    ),
                  
//         ),
//         Container(height: 500,
//         width: double.infinity,
//            decoration: const BoxDecoration(
//           color: WeatherAppTheme.background,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromARGB(224, 175, 174, 174),
//               blurRadius: 4,
//               offset: Offset(0, -0.5),
//             ),
//           ],
//         ),),
//      _buildWeatherCard()

//       ],),
//     );
//   }
//    Widget _buildInfoCard(IconData icon, String label, String value) {
//     return Column(
//       children: [
//         Icon(icon, size: 30, color: Colors.white),
//         const SizedBox(height: 8),
//         Text(value,
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.white)),
//         Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
//       ],
//     );
//   }

//   int _selectedForecastIndex = 0;
//     Widget _buildWeatherCard(WeatherEntity weather) {
//     _animationController.forward(from: 0);
//     final forecast = weather.forecast ?? [];
//     ForecastEntity selectedDayForecast = forecast.isNotEmpty ? forecast[_selectedForecastIndex] : ForecastEntity(date: '', minTemp: 0, maxTemp: 0, condition: '');

//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             _buildHorizontalForecast(weather),
//             const SizedBox(height: 16),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(24),
//                 color: const Color(0xFFBFD8FF),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Top info
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // City & condition
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(weather.cityName,
//                               style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white)),
//                           Text(selectedDayForecast.condition,
//                               style: const TextStyle(
//                                   fontSize: 14, color: Colors.white70)),
//                         ],
//                       ),
//                       // Temperature
//                       Column(
//                         children: [
//                           Text("${selectedDayForecast.maxTemp.toStringAsFixed(0)}°",
//                               style: const TextStyle(
//                                   fontSize: 44,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white)),
//                           const Text("Feels like 32°",
//                               style: TextStyle(color: Colors.white70)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   // Info cards
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildInfoCard(Icons.water_drop, "Humidity",
//                           "${selectedDayForecast.humidity?.toStringAsFixed(0) ?? '--'}%"),
//                       _buildInfoCard(Icons.air, "Wind",
//                           "${selectedDayForecast.windSpeed?.toStringAsFixed(1) ?? '--'} km/h"),
//                       _buildInfoCard(Icons.cloud, "Rain",
//                           "${selectedDayForecast.rainVolume?.toStringAsFixed(1) ?? '--'} mm"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             _buildBottomForecastList(weather),
//           ],
//         ),
//       ),
//     );
//   }
//    Widget _buildBottomForecastList(WeatherEntity weather) {
//     final forecast = weather.forecast ?? [];
//     return Column(
//       children: forecast.take(4).map((dayForecast) {
//         return ListTile(
//           leading: _getWeatherIcon(dayForecast.condition),
//           title: Text(dayForecast.date),
//           trailing: Text("${dayForecast.minTemp.toStringAsFixed(0)}° / ${dayForecast.maxTemp.toStringAsFixed(0)}°"),
//           subtitle: Text(dayForecast.condition),
//         );
//       }).toList(),
//     );
//   }
//    Widget _getWeatherIcon(String condition) {
//     switch (condition.toLowerCase()) {
//       case 'clear':
//         return const Icon(Icons.wb_sunny, size: 20);
//       case 'clouds':
//         return const Icon(Icons.cloud, size: 20);
//       case 'rain':
//         return const Icon(Icons.beach_access, size: 20);
//       case 'snow':
//         return const Icon(Icons.ac_unit, size: 20);
//       case 'thunderstorm':
//         return const Icon(Icons.flash_on, size: 20);
//       default:
//         return const Icon(Icons.wb_cloudy, size: 20);
//     }
//   }

//   String _getDayOfWeek(String dateStr) {
//     try {
//       final date = DateTime.parse(dateStr);
//       switch (date.weekday) {
//         case DateTime.monday:
//           return 'Mon';
//         case DateTime.tuesday:
//           return 'Tue';
//         case DateTime.wednesday:
//           return 'Wed';
//         case DateTime.thursday:
//           return 'Thu';
//         case DateTime.friday:
//           return 'Fri';
//         case DateTime.saturday:
//           return 'Sat';
//         case DateTime.sunday:
//           return 'Sun';
//         default:
//           return '';
//       }
//     } catch (e) {
//       return '';
//     }
//   }

//   Widget _buildHorizontalForecast(WeatherEntity weather) {
//     final forecast = weather.forecast ?? [];

//     return SizedBox(
//       height: 90,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: forecast.length > 4 ? 4 : forecast.length,
//         itemBuilder: (context, index) {
//           final dayForecast = forecast[index];
//           final date = dayForecast.date.split(' ')[0];
//           final day = _getDayOfWeek(dayForecast.date);
//           final isSelected = index == _selectedForecastIndex;

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedForecastIndex = index;
//               });
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               width: 60,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: isSelected ? Colors.white : Colors.white24,
//               ),
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
//                   Text(day, style: const TextStyle(fontSize: 12)),
//                   const SizedBox(height: 6),
//                   _getWeatherIcon(dayForecast.condition),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }