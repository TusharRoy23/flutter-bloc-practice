import 'package:meta_api/src/environments/base_config.dart';
import 'package:meta_api/src/environments/dev_config.dart';
import 'package:meta_api/src/environments/production_config.dart';
import 'package:meta_api/src/environments/staging.config.dart';

class Environment {
  Environment._internal();
  static final Environment _singleton = Environment._internal();
  factory Environment() {
    return _singleton;
  }

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  BaseConfig? config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProductionConfig();
      case Environment.STAGING:
        return StagingConfig();
      default:
        return DevConfig();
    }
  }
}
