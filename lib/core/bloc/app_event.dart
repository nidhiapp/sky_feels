// app_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.freezed.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.toggleSearchBar() = ToggleSearchBar;
  const factory AppEvent.showSearchBar() = ShowSearchBar;
  const factory AppEvent.hideSearchBar() = HideSearchBar;
  const factory AppEvent.toggleThemeMode() = ToggleThemeMode;
  const factory AppEvent.toggleSidebar() = ToggleSidebar;
}
