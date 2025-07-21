import 'package:flutter/material.dart';
import 'package:sky_feels/core/app_text.dart';
import 'package:sky_feels/core/app_theme.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: onSearch,
                    icon: const Icon(Icons.search, color: WeatherAppTheme.background),
                  ),
                  hintText: AppStrings.enterCityNAme,
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: WeatherAppTheme.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: WeatherAppTheme.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: WeatherAppTheme.white),
                  ),
                ),
                onSubmitted: (_) => onSearch(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
