import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sky_feels/core/app_theme.dart';

class TutorialWidget extends StatelessWidget {
  const TutorialWidget({super.key});
 

  @override
  Widget build(BuildContext context) {
     List tutorialText = [
    
    'Check the weather conditions',
    'You pray for rain, you gotta deal with the mud too. That’s a part of it.',
    'Enjoy your day with Sky Feels!'
  ];
    return CarouselSlider(
      items: tutorialText.map((e)=>Center(
        child: Text(e,style: WeatherAppTheme.headline2,),

      )).toList(),
       options: CarouselOptions(
       // height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        viewportFraction: 0.8,));
  }
}