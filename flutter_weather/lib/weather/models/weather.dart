import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;
import 'package:weather_repository/weather_repository.dart' hide Weather;

part 'weather.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

@JsonSerializable()
class Temperature extends Equatable {
  const Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  final double value;

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  @override
  List<Object?> get props => [value];
}

@JsonSerializable()
class WeatherCls extends Equatable {
  final WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final Temperature temperature;

  WeatherCls({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature,
  });

  factory WeatherCls.fromJson(Map<String, dynamic> json) =>
      _$WeatherClsFromJson(json);

  factory WeatherCls.fromRepository(weather_repository.Weather weather) {
    return WeatherCls(
      condition: weather.condition,
      lastUpdated: DateTime.now(),
      location: weather.location,
      temperature: Temperature(value: weather.temperature),
    );
  }

  Map<String, dynamic> toJson() => _$WeatherClsToJson(this);

  static final empty = WeatherCls(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: const Temperature(value: 0),
    location: '--',
  );

  @override
  List<Object?> get props => [condition, lastUpdated, location, temperature];

  WeatherCls copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    String? location,
    Temperature? temperature,
  }) {
    return WeatherCls(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
    );
  }
}
