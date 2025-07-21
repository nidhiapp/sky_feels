import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sky_feels/core/app_theme.dart';

class ShimmerHomeScreen extends StatelessWidget {
  const ShimmerHomeScreen({Key? key}) : super(key: key);

  Widget _shimmerBox({
    double width = double.infinity,
    double height = 20,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
    );
  }

  Widget _shimmerCircle({double size = 40}) {
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
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Horizontal Forecast shimmer
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _shimmerBox(width: 40, height: 12),
                      const SizedBox(height: 8),
                      _shimmerCircle(size: 40),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 46),

            // Weather Card shimmer
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    WeatherAppTheme.gradientBlue1,
                    WeatherAppTheme.gradientBlue2,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: WeatherAppTheme.gradientBlue2.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // City & condition
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _shimmerBox(width: 100, height: 20),
                          const SizedBox(height: 8),
                          _shimmerBox(width: 80, height: 14),
                        ],
                      ),
                      // Temperature
                      Column(
                        children: [
                          _shimmerBox(width: 60, height: 40),
                          const SizedBox(height: 8),
                          _shimmerBox(width: 80, height: 14),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Info cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3, (_) {
                      return Column(
                        children: [
                          _shimmerCircle(size: 32),
                          const SizedBox(height: 8),
                          _shimmerBox(width: 60, height: 12),
                          const SizedBox(height: 4),
                          _shimmerBox(width: 50, height: 12),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Bottom Forecast List shimmer (4 items)
            Column(
              children: List.generate(4, (_) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Row(
                    children: [
                      _shimmerCircle(size: 40),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _shimmerBox(width: double.infinity, height: 14),
                            const SizedBox(height: 4),
                            _shimmerBox(width: 100, height: 12),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      _shimmerBox(width: 60, height: 14),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
