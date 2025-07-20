     //  Icon(Icons.wb_sunny_rounded, size: 50, color: Color(0xFFFFD74C)),
            // Cloud
           // const Icon(Icons.cloud, size: 100, color: Colors.white),
          //Icon(Icons.ac_unit, color: Colors.white70),
import 'package:flutter/material.dart';
import 'package:sky_feels/core/app_theme.dart';
import 'package:sky_feels/weather/presentation/widgets/tutorial_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Stack(alignment: Alignment.bottomCenter,
        children: [
          Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(colors: [WeatherAppTheme.gradientBlue1, WeatherAppTheme.gradientBlue2],
              center: Alignment.center,
              radius: 1.0,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
                   ),
          child: Padding(
            padding: const EdgeInsets.only(top:70.0,left: 20.0),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Welcome to Sky Feels',
                style: WeatherAppTheme.headline2,
              ),
            ),
          ),
              
                  ),
        Container(
          height: 400,width: double.infinity,
          decoration: const BoxDecoration(
           color: WeatherAppTheme.background,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
             boxShadow: [
      BoxShadow(
        color: Color.fromARGB(224, 175, 174, 174), // Soft shadow
        blurRadius: 4,         // Spread of the shadow
        offset: Offset(0, -0.5),  // Shadow position (x, y)
      ),
      
    ],
          ),
          child: Column(
            children: [
              const TutorialWidget(),
            ],
          ),
        ),
    
        ]
      ));
      }
      }