part of 'weather_cubit.dart';

enum WeatherStatus {
  initial,
  loading,
  success,
  failure,
}

/*
  Here, WeatherStatus extend it's functionality. It's enum as well as extension added (WeatherStatusX)
*/

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable()
class WeatherState extends Equatable {
  WeatherState({
    this.status = WeatherStatus.initial,
    this.temperatureUnits = TemperatureUnits.celsius,
    WeatherCls? weatherCls,
  }) : weatherCls = weatherCls ?? WeatherCls.empty;

  final WeatherStatus status;
  final WeatherCls weatherCls;
  final TemperatureUnits temperatureUnits;

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    WeatherCls? weatherCls,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weatherCls: weatherCls ?? this.weatherCls,
    );
  }

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [status, weatherCls, temperatureUnits];
}
