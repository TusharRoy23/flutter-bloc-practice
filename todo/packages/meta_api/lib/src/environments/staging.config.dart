import 'base_config.dart';

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => "http://10.0.2.2:3000/api/";

  @override
  int get connectionTimeout => 5000;

  @override
  int get receiveTimeout => 10000;
}
