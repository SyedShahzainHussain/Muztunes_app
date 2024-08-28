import 'package:muztunes_apps/abstract/base_config_class.dart';

class DevConfig extends BaseConfig {
  @override
  String get apiHost => "192.168.3.112:3000/app/v1";

  @override
  bool get useHttps => false;
}
