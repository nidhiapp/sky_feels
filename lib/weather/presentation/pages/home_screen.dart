import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/weather_entity.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<String> _searchHistory = [];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _search() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      if (!_searchHistory.contains(city)) {
        _searchHistory.insert(0, city);
        if (_searchHistory.length > 4) {
          _searchHistory.removeLast();
        }
      }
      context.read<WeatherBloc>().add(WeatherEvent.fetchWeather(city));
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: _search,
            icon: const Icon(Icons.search, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildSearchHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        children: _searchHistory
            .map(
              (city) => ActionChip(
                label: Text(city),
                onPressed: () {
                  _controller.text = city;
                  _search();
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildWeatherCard(WeatherEntity weather) {
    _animationController.forward(from: 0);
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200,
                offset: const Offset(0, 4),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(weather.cityName,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Text('${weather.temperature.toStringAsFixed(1)} ℃',
                  style: const TextStyle(fontSize: 42, color: Colors.white)),
              const SizedBox(height: 10),
              Text(weather.condition,
                  style: const TextStyle(fontSize: 20, color: Colors.white70)),
              if (weather.windSpeed != null)
                Text('Wind: ${weather.windSpeed} m/s',
                    style: const TextStyle(color: Colors.white60)),
              if (weather.humidity != null)
                Text('Humidity: ${weather.humidity}%',
                    style: const TextStyle(color: Colors.white60))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: Text("Search for a city")),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (weather) => _buildWeatherCard(weather),
          error: (msg) => Center(child: Text(msg)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2633C5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("🌦 Weather App"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          if (_searchHistory.isNotEmpty) _buildSearchHistory(),
          const SizedBox(height:8),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
