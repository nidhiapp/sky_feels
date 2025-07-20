 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/weather_entity.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<String> _searchHistory = [];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _fetchInitialWeather();
  }

  void _fetchInitialWeather() {
    const defaultCity = "New Delhi";
    context.read<WeatherBloc>().add(WeatherEvent.fetchWeather(defaultCity));
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

  String _getDayOfWeek(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      switch (date.weekday) {
        case DateTime.monday:
          return 'Mon';
        case DateTime.tuesday:
          return 'Tue';
        case DateTime.wednesday:
          return 'Wed';
        case DateTime.thursday:
          return 'Thu';
        case DateTime.friday:
          return 'Fri';
        case DateTime.saturday:
          return 'Sat';
        case DateTime.sunday:
          return 'Sun';
        default:
          return '';
      }
    } catch (e) {
      return '';
    }
  }

  Widget _getWeatherIcon(String? iconCode) {
    if (iconCode == null) {
      return const Icon(Icons.wb_cloudy, size: 20);
    }
    final iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';
    return Image.network(iconUrl, width: 40, height: 40);
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
                  borderRadius: BorderRadius.circular(12),
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
    final forecast = weather.forecast ?? [];
    ForecastEntity selectedDayForecast = forecast.isNotEmpty ? forecast[_selectedForecastIndex] : ForecastEntity(date: '', minTemp: 0, maxTemp: 0, condition: '');

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
           _buildHorizontalForecast(
  currentDay: DateTime.now(),
  selectedIndex: _selectedForecastIndex,
  onDaySelected: (index) {
    setState(() {
      _selectedForecastIndex = index;
    });
  },
  forecasts: weather.forecast ?? [],
),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xFFBFD8FF),
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
                          Text(weather.cityName,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(selectedDayForecast.condition,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white70)),
                        ],
                      ),
                      // Temperature
                      Column(
                        children: [
                          Text("${selectedDayForecast.maxTemp.toStringAsFixed(0)}°",
                              style: const TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const Text("Feels like 32°",
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Info cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoCard(Icons.water_drop, "Humidity",
                          "${selectedDayForecast.humidity?.toStringAsFixed(0) ?? '--'}%"),
                      _buildInfoCard(Icons.air, "Wind",
                          "${selectedDayForecast.windSpeed?.toStringAsFixed(1) ?? '--'} km/h"),
                      _buildInfoCard(Icons.cloud, "Rain",
                          "${selectedDayForecast.rainVolume?.toStringAsFixed(1) ?? '--'} mm"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildBottomForecastList(weather),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.white),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
  Widget _buildHorizontalForecast({
  required DateTime currentDay,
  required int selectedIndex,
  required Function(int) onDaySelected,
  required List<ForecastEntity> forecasts,
}) {
  // Generate the next 7 days
  List<DateTime> next7Days = List.generate(
    7,
    (index) => currentDay.add(Duration(days: index)),
  );

  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) {
        final day = next7Days[index];
        final forecast = forecasts[index]; // Ensure forecasts has 7 items

        return GestureDetector(
          onTap: () => onDaySelected(index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedIndex == index ? Colors.blueAccent : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedIndex == index ? Colors.blue : Colors.grey,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEE').format(day), // e.g. Mon, Tue
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                _getWeatherIcon(forecast.iconCode),
                const SizedBox(height: 8),
                // Text(
                //   '${forecast.temp}°',
                //   style: TextStyle(
                //     color: selectedIndex == index ? Colors.white : Colors.black,
                //  ),
               // ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

  int _selectedForecastIndex = 0;


    


  Widget _buildBottomForecastList(WeatherEntity weather) {
    final forecast = weather.forecast ?? [];
    return Column(
      children: forecast.take(4).map((dayForecast) {
        return ListTile(
          leading: SizedBox(
            width: 40,
            height: 40,
            child: _getWeatherIcon(dayForecast.iconCode),
          ),
          title: Text(dayForecast.date),
          trailing: Text("${dayForecast.minTemp.toStringAsFixed(0)}° / ${dayForecast.maxTemp.toStringAsFixed(0)}°"),
          subtitle: Text(dayForecast.condition),
        );
      }).toList(),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
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
      backgroundColor: const Color(0xFF81B3FF),
      body: Column(
        children: [
          const SizedBox(height: 40),
          _buildSearchBar(),
          // if (_searchHistory.isNotEmpty) _buildSearchHistory(),
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
