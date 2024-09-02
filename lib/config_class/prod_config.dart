import 'package:muztune/abstract/base_config_class.dart';

class ProdConfig extends BaseConfig {
  @override
  String get apiHost => "";

  @override
  bool get useHttps => false;
}
