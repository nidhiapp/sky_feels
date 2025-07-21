import 'package:flutter/material.dart';
import 'package:sky_feels/core/app_theme.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:EdgeInsets.all(10.0),
             decoration: BoxDecoration(
        color: WeatherAppTheme.gradientBlue1.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      
      ),
          child: Icon(icon, size: 30, color: Colors.white)),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}
