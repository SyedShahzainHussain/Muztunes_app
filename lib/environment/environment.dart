import 'package:muztune/abstract/base_config_class.dart';
import 'package:muztune/config_class/dev_config.dart';
import 'package:muztune/config_class/prod_config.dart';

class Environment {
  static final Environment _singleton = Environment._internal();
  Environment._internal();

  factory Environment() {
    return _singleton;
  }
  static const String Dev = "dev";
  static const String Prod = "prod";
  static String selectedEnvironment = '';

  BaseConfig? baseConfig;
  initConfig(String enviroment) {
    baseConfig = _getConfig(enviroment);
  }

  _getConfig(String environment) {
    switch (environment) {
      case Environment.Dev:
        selectedEnvironment = environment;
        return DevConfig();
      case Environment.Prod:
        selectedEnvironment = environment;
        return ProdConfig();
      default:
        selectedEnvironment = Environment.Dev;
        return DevConfig();
    }
  }
}
