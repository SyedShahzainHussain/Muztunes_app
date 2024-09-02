import 'package:muztune/abstract/base_config_class.dart';

class DevConfig extends BaseConfig {
  @override
  String get apiHost => "https://backend-ecommerce-3b0p.onrender.com/app/v1";

  @override
  bool get useHttps => false;
}
