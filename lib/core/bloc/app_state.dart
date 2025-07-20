// app_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isSearchBarVisible,
    @Default(false) bool isDarkMode,
    @Default(true) bool isSidebarExpanded,
  }) = _AppState;

  factory AppState.initial() => const AppState();
}
