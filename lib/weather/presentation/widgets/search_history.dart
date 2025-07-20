import 'package:flutter/material.dart';

class SearchHistory extends StatelessWidget {
  final List<String> searchHistory;
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchHistory({
    Key? key,
    required this.searchHistory,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        children: searchHistory
            .map(
              (city) => ActionChip(
                label: Text(city),
                onPressed: () {
                  controller.text = city;
                  onSearch();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
