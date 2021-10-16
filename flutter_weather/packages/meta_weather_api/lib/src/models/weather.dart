import 'package:json_annotation/json_annotation.dart';
import 'package:meta_weather_api/src/enums/enum_variables.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  const Weather({
    required this.id,
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.windDirectionCompass,
    required this.created,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  final int id;
  final String weatherStateName;
  @JsonKey(unknownEnumValue: WeatherState.unknown)
  final WeatherState weatherStateAbbr;
  @JsonKey(unknownEnumValue: WindDirectionCompass.unknown)
  final WindDirectionCompass windDirectionCompass;
  final DateTime created;
  final DateTime applicableDate;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final double visibility;
  final int predictability;
}

extension WeatherStateX on WeatherState {
  String? get abbr => _$WeatherStateEnumMap[this];
}
