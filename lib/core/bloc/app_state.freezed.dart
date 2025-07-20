// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppState {
  bool get isSearchBarVisible => throw _privateConstructorUsedError;
  bool get isDarkMode => throw _privateConstructorUsedError;
  bool get isSidebarExpanded => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call({bool isSearchBarVisible, bool isDarkMode, bool isSidebarExpanded});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSearchBarVisible = null,
    Object? isDarkMode = null,
    Object? isSidebarExpanded = null,
  }) {
    return _then(_value.copyWith(
      isSearchBarVisible: null == isSearchBarVisible
          ? _value.isSearchBarVisible
          : isSearchBarVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isSidebarExpanded: null == isSidebarExpanded
          ? _value.isSidebarExpanded
          : isSidebarExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isSearchBarVisible, bool isDarkMode, bool isSidebarExpanded});
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSearchBarVisible = null,
    Object? isDarkMode = null,
    Object? isSidebarExpanded = null,
  }) {
    return _then(_$AppStateImpl(
      isSearchBarVisible: null == isSearchBarVisible
          ? _value.isSearchBarVisible
          : isSearchBarVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isSidebarExpanded: null == isSidebarExpanded
          ? _value.isSidebarExpanded
          : isSidebarExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AppStateImpl implements _AppState {
  const _$AppStateImpl(
      {this.isSearchBarVisible = false,
      this.isDarkMode = false,
      this.isSidebarExpanded = true});

  @override
  @JsonKey()
  final bool isSearchBarVisible;
  @override
  @JsonKey()
  final bool isDarkMode;
  @override
  @JsonKey()
  final bool isSidebarExpanded;

  @override
  String toString() {
    return 'AppState(isSearchBarVisible: $isSearchBarVisible, isDarkMode: $isDarkMode, isSidebarExpanded: $isSidebarExpanded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.isSearchBarVisible, isSearchBarVisible) ||
                other.isSearchBarVisible == isSearchBarVisible) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.isSidebarExpanded, isSidebarExpanded) ||
                other.isSidebarExpanded == isSidebarExpanded));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isSearchBarVisible, isDarkMode, isSidebarExpanded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final bool isSearchBarVisible,
      final bool isDarkMode,
      final bool isSidebarExpanded}) = _$AppStateImpl;

  @override
  bool get isSearchBarVisible;
  @override
  bool get isDarkMode;
  @override
  bool get isSidebarExpanded;
  @override
  @JsonKey(ignore: true)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
