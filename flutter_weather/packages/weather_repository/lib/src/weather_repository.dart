import 'dart:async';
import 'package:meta_weather_api/meta_weather_api.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart';

import 'enums/enum_variables.dart';

class WeatherFailure implements Exception {}

class WeatherRepository {
  final MetaWeatherApiClient _weatherApiClient;
  WeatherRepository({MetaWeatherApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? MetaWeatherApiClient();

  Future<Weather> getWeather(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final woeid = location.woeid;
    final weather = await _weatherApiClient.getWeather(woeid);
    return Weather(
      location: location.title,
      temperature: weather.theTemp,
      condition: weather.weatherStateAbbr.toCondition,
    );
  }
}

/*
  It's local/private extension because it doesn't have any name and convention will be - 
  extension any_name on <any-type> {}
  Local/Private extension
  extension on <any-type> {} or extension _anyname on <any-type> {}
*/
extension on WeatherState {
  WeatherCondition get toCondition {
    switch (this) {
      case WeatherState.clear:
        return WeatherCondition.clear;
      case WeatherState.snow:
      case WeatherState.sleet:
      case WeatherState.hail:
        return WeatherCondition.snowy;
      case WeatherState.thunderstorm:
      case WeatherState.heavyRain:
      case WeatherState.lightRain:
      case WeatherState.showers:
        return WeatherCondition.rainy;
      case WeatherState.heavyCloud:
      case WeatherState.lightCloud:
        return WeatherCondition.cloudy;
      default:
        return WeatherCondition.unknown;
    }
  }
}
