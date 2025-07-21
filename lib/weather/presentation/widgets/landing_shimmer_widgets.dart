import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sky_feels/core/app_theme.dart';

class ShimmerLandingScreen extends StatelessWidget {
  const ShimmerLandingScreen({Key? key}) : super(key: key);

  Widget _shimmerBox({double width = double.infinity, double height = 20, BorderRadius? borderRadius}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }

  Widget _shimmerCircle({double size = 60}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                WeatherAppTheme.gradientBlue1,
                WeatherAppTheme.gradientBlue2,
              ],
              center: Alignment.center,
              radius: 1.0,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _shimmerBox(width: 200, height: 40, borderRadius: BorderRadius.circular(12)),
                const SizedBox(height: 100),
                _shimmerCircle(size: 180),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _shimmerBox(width: double.infinity, height: 100, borderRadius: BorderRadius.circular(12)),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              WeatherAppTheme.gradientGrey,
                              WeatherAppTheme.gradientPurple2,
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
              Positioned(
                top: -40,
                right: 10,
                child: _shimmerCircle(size: 60),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
