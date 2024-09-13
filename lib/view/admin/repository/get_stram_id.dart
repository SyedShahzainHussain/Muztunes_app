import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';

class GetStreamId {
  final BaseApiServices baseApiServices = NetworkApiServices();

  Future getStreamApi() async {
    try {
     final response  =  await baseApiServices.getGetApiResponse(Urls.craeateStream);
     final data  = response as List;
    return  data.map((e)=>e["videoId"]).toList();
    } catch (e) {
      rethrow;
    }
  }
}
