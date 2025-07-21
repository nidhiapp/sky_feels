import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sky_feels/core/app_theme.dart';

class TutorialWidget extends StatefulWidget {
  const TutorialWidget({super.key});

  @override
  State<TutorialWidget> createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> tutorialContent = [
    {
      'text': 'Check the weather conditions',
      'subText': 'Stay updated with real-time forecasts',
    },
    {
      'text':'Prepare for all weather possibilities' ,
      'subText': 
      'You pray for rain, you gotta deal with the mud too. That’s a part of it.',
    },
    {
      'text': 'Enjoy your day with Sky Feels!',
      'subText': 'Plan your day with confidence',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tutorialContent.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? WeatherAppTheme.gradientPurple1
                        : WeatherAppTheme.gradientGrey,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          CarouselSlider(
            items: tutorialContent.map((content) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    content['text'],
                    style: WeatherAppTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    content['subText'],
                    style: WeatherAppTheme.subtitle,
                  
                      
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )).toList(),
            carouselController: _carouselController,
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}