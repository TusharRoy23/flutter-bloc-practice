import 'package:json_annotation/json_annotation.dart';
import 'package:meta_weather_api/src/enums/enum_variables.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String title;
  final LocationType locationType;
  final int woeid;
  @JsonKey(name: 'latt_long')
  @LatLngConverter()
  final LatLng latLng;

  const Location({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.latLng,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng({
    required this.latitude,
    required this.longitude,
  });
}

class LatLngConverter implements JsonConverter<LatLng, String> {
  const LatLngConverter();

  @override
  LatLng fromJson(String jsonString) {
    final parts = jsonString.split(',');
    return LatLng(
      latitude: double.tryParse(parts[0]) ?? 0,
      longitude: double.tryParse(parts[1]) ?? 0,
    );
  }

  @override
  String toJson(LatLng latLng) {
    return '${latLng.latitude},${latLng.longitude}';
  }
}
