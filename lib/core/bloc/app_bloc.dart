// app_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<ToggleSearchBar>(
      (event, emit) =>
          emit(state.copyWith(isSearchBarVisible: !state.isSearchBarVisible)),
    );
    on<ShowSearchBar>(
      (event, emit) => emit(state.copyWith(isSearchBarVisible: true)),
    );
    on<HideSearchBar>(
      (event, emit) => emit(state.copyWith(isSearchBarVisible: false)),
    );
    on<ToggleThemeMode>(
      (event, emit) => emit(state.copyWith(isDarkMode: !state.isDarkMode)),
    );
    on<ToggleSidebar>(
      (event, emit) =>
          emit(state.copyWith(isSidebarExpanded: !state.isSidebarExpanded)),
    );
  }
}
