import 'package:muztune/config/urls.dart';
import 'package:muztune/data/network/base_api_services.dart';
import 'package:muztune/data/network/network_api_services.dart';
import 'package:muztune/repository/rating/rating_repository.dart';

class RatingHttpRepository extends RatingRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();
  @override
  Future postRating(body) async {
    try {
      await baseApiServices.putPostApiResponse(Urls.postRatingUrl, body);
    } catch (e) {
      rethrow;
    }
  }
}
