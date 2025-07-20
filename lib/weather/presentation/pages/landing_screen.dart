     //  Icon(Icons.wb_sunny_rounded, size: 50, color: Color(0xFFFFD74C)),
            // Cloud
           // const Icon(Icons.cloud, size: 100, color: Colors.white),
          //Icon(Icons.ac_unit, color: Colors.white70),
import 'package:flutter/material.dart';
import 'package:sky_feels/core/app_images.dart';
import 'package:sky_feels/core/app_theme.dart';
import 'package:sky_feels/weather/presentation/pages/home_screen.dart';
import 'package:sky_feels/weather/presentation/pages/weather_screen.dart';
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
            padding: const EdgeInsets.only(top:80.0,left: 20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome to Sky Feels',
                    style: WeatherAppTheme.headline2White,
                  
                  ),
                ),
                const SizedBox(height: 100,),
                Image.asset(AppImages.weatherApp,height: 180,width: 180)
              ],
            ),
          ),
              
                  ),
 Padding(
  padding: const EdgeInsets.only(top: 80),
  child: Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        height: 400,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: WeatherAppTheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(224, 175, 174, 174),
              blurRadius: 4,
              offset: Offset(0, -0.5),
            ),
          ],
        ),
        child: Column(
          children: [
            const TutorialWidget(),
            GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(
                  
                  builder: (context) => const HomeScreen(),
                
                ));
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      WeatherAppTheme.gradientGrey,
                      WeatherAppTheme.gradientPurple2
                    ],
                    center: Alignment.topRight,
                    radius: 1,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_right,
                  size: 55,
                  color: WeatherAppTheme.background,
                ),
              ),
            ),
          ],
        ),
      ),
      // ❄ Snowflake placed similar to the image you showed
      Positioned(
        top: -40,
        right: 10,
        child: Image.asset(
          AppImages.snowFlakes,
          height: 60,
          width: 60,
        ),
      ),
    ],
  ),
),


    
        ]
      ));
      }
      }