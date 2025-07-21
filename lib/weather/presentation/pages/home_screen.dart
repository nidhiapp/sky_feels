import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_feels/core/app_text.dart';
import 'package:sky_feels/core/app_theme.dart';
import 'package:sky_feels/core/bloc/app_bloc.dart';
import 'package:sky_feels/core/bloc/app_event.dart';
import 'package:sky_feels/core/bloc/app_state.dart';
import 'package:sky_feels/weather/presentation/bloc/weather_bloc.dart';
import 'package:sky_feels/weather/presentation/bloc/weather_event.dart';
import 'package:sky_feels/weather/presentation/bloc/weather_state.dart';
import 'package:sky_feels/weather/presentation/widgets/search_bar.dart';
import 'package:sky_feels/weather/presentation/widgets/shimmer_home_screen.dart';
import 'package:sky_feels/weather/presentation/widgets/weather_card.dart';

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fetchInitialWeather();
  }

  void _fetchInitialWeather() {
    const defaultCity = AppStrings.defaultCity;
    context.read<WeatherBloc>().add(const WeatherEvent.fetchWeather(defaultCity));
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

  Widget _buildContent() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: ShimmerHomeScreen()),
          loading: () => const Center(child: ShimmerHomeScreen()),
          loaded: (weather, selectedForecastIndex) {
            _animationController.forward(from: 0);
            return WeatherCard(
              weather: weather,
              selectedForecastIndex: selectedForecastIndex,
              onForecastSelected: (index) {
                context.read<WeatherBloc>().add(WeatherEvent.selectForecastDay(index));
              },
            //  fadeAnimation: _fadeAnimation,
            );
          },
          error: (msg) => Center(child: Text(msg)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
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
            ),
            Container(
              height: 500,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  BlocBuilder<AppBloc, AppState>(
                    builder: (context, appState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back, color: WeatherAppTheme.white)),
                          const SizedBox(width: 8),
                          if (appState.isSearchBarVisible)
                            Expanded(
                              child: SearchBarWidget(
                                controller: _controller,
                                onSearch: _search,
                              ),
                            ),
                          IconButton(
                            icon: Icon(
                              appState.isSearchBarVisible ? Icons.cancel_outlined : Icons.search,
                              color: WeatherAppTheme.white,
                            ),
                            onPressed: () {
                              context.read<AppBloc>().add(const AppEvent.toggleSearchBar());
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Expanded(child: _buildContent()),
                ],
              ),
            ),
          ],
        ),
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
