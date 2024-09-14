import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';
import 'package:muztune/model/get_stream_model.dart';

class GetStreamId {
  final BaseApiServices baseApiServices = NetworkApiServices();

  Future<List<StreamModel>> getStreamApi() async {
    try {
      final response =
          await baseApiServices.getGetApiResponse(Urls.craeateStream);
      final data = response as List;
      return data.map((e) => StreamModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
