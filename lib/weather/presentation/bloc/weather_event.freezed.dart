// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeatherEvent {
  String get cityName => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) fetchWeather,
    required TResult Function(String cityName) refreshWeather,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName)? fetchWeather,
    TResult? Function(String cityName)? refreshWeather,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? fetchWeather,
    TResult Function(String cityName)? refreshWeather,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchWeather value) fetchWeather,
    required TResult Function(RefreshWeather value) refreshWeather,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchWeather value)? fetchWeather,
    TResult? Function(RefreshWeather value)? refreshWeather,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchWeather value)? fetchWeather,
    TResult Function(RefreshWeather value)? refreshWeather,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherEventCopyWith<WeatherEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherEventCopyWith<$Res> {
  factory $WeatherEventCopyWith(
          WeatherEvent value, $Res Function(WeatherEvent) then) =
      _$WeatherEventCopyWithImpl<$Res, WeatherEvent>;
  @useResult
  $Res call({String cityName});
}

/// @nodoc
class _$WeatherEventCopyWithImpl<$Res, $Val extends WeatherEvent>
    implements $WeatherEventCopyWith<$Res> {
  _$WeatherEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
  }) {
    return _then(_value.copyWith(
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchWeatherImplCopyWith<$Res>
    implements $WeatherEventCopyWith<$Res> {
  factory _$$FetchWeatherImplCopyWith(
          _$FetchWeatherImpl value, $Res Function(_$FetchWeatherImpl) then) =
      __$$FetchWeatherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cityName});
}

/// @nodoc
class __$$FetchWeatherImplCopyWithImpl<$Res>
    extends _$WeatherEventCopyWithImpl<$Res, _$FetchWeatherImpl>
    implements _$$FetchWeatherImplCopyWith<$Res> {
  __$$FetchWeatherImplCopyWithImpl(
      _$FetchWeatherImpl _value, $Res Function(_$FetchWeatherImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
  }) {
    return _then(_$FetchWeatherImpl(
      null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchWeatherImpl implements FetchWeather {
  const _$FetchWeatherImpl(this.cityName);

  @override
  final String cityName;

  @override
  String toString() {
    return 'WeatherEvent.fetchWeather(cityName: $cityName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchWeatherImpl &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchWeatherImplCopyWith<_$FetchWeatherImpl> get copyWith =>
      __$$FetchWeatherImplCopyWithImpl<_$FetchWeatherImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) fetchWeather,
    required TResult Function(String cityName) refreshWeather,
  }) {
    return fetchWeather(cityName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName)? fetchWeather,
    TResult? Function(String cityName)? refreshWeather,
  }) {
    return fetchWeather?.call(cityName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? fetchWeather,
    TResult Function(String cityName)? refreshWeather,
    required TResult orElse(),
  }) {
    if (fetchWeather != null) {
      return fetchWeather(cityName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchWeather value) fetchWeather,
    required TResult Function(RefreshWeather value) refreshWeather,
  }) {
    return fetchWeather(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchWeather value)? fetchWeather,
    TResult? Function(RefreshWeather value)? refreshWeather,
  }) {
    return fetchWeather?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchWeather value)? fetchWeather,
    TResult Function(RefreshWeather value)? refreshWeather,
    required TResult orElse(),
  }) {
    if (fetchWeather != null) {
      return fetchWeather(this);
    }
    return orElse();
  }
}

abstract class FetchWeather implements WeatherEvent {
  const factory FetchWeather(final String cityName) = _$FetchWeatherImpl;

  @override
  String get cityName;
  @override
  @JsonKey(ignore: true)
  _$$FetchWeatherImplCopyWith<_$FetchWeatherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshWeatherImplCopyWith<$Res>
    implements $WeatherEventCopyWith<$Res> {
  factory _$$RefreshWeatherImplCopyWith(_$RefreshWeatherImpl value,
          $Res Function(_$RefreshWeatherImpl) then) =
      __$$RefreshWeatherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cityName});
}

/// @nodoc
class __$$RefreshWeatherImplCopyWithImpl<$Res>
    extends _$WeatherEventCopyWithImpl<$Res, _$RefreshWeatherImpl>
    implements _$$RefreshWeatherImplCopyWith<$Res> {
  __$$RefreshWeatherImplCopyWithImpl(
      _$RefreshWeatherImpl _value, $Res Function(_$RefreshWeatherImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
  }) {
    return _then(_$RefreshWeatherImpl(
      null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshWeatherImpl implements RefreshWeather {
  const _$RefreshWeatherImpl(this.cityName);

  @override
  final String cityName;

  @override
  String toString() {
    return 'WeatherEvent.refreshWeather(cityName: $cityName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshWeatherImpl &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshWeatherImplCopyWith<_$RefreshWeatherImpl> get copyWith =>
      __$$RefreshWeatherImplCopyWithImpl<_$RefreshWeatherImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) fetchWeather,
    required TResult Function(String cityName) refreshWeather,
  }) {
    return refreshWeather(cityName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName)? fetchWeather,
    TResult? Function(String cityName)? refreshWeather,
  }) {
    return refreshWeather?.call(cityName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? fetchWeather,
    TResult Function(String cityName)? refreshWeather,
    required TResult orElse(),
  }) {
    if (refreshWeather != null) {
      return refreshWeather(cityName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchWeather value) fetchWeather,
    required TResult Function(RefreshWeather value) refreshWeather,
  }) {
    return refreshWeather(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchWeather value)? fetchWeather,
    TResult? Function(RefreshWeather value)? refreshWeather,
  }) {
    return refreshWeather?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchWeather value)? fetchWeather,
    TResult Function(RefreshWeather value)? refreshWeather,
    required TResult orElse(),
  }) {
    if (refreshWeather != null) {
      return refreshWeather(this);
    }
    return orElse();
  }
}

abstract class RefreshWeather implements WeatherEvent {
  const factory RefreshWeather(final String cityName) = _$RefreshWeatherImpl;

  @override
  String get cityName;
  @override
  @JsonKey(ignore: true)
  _$$RefreshWeatherImplCopyWith<_$RefreshWeatherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
