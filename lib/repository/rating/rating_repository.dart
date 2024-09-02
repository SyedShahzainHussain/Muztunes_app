import 'package:muztune/model/rating_model.dart';

abstract class RatingRepository {
  Future postRating(dynamic body);
  Future<RatingModel> getRating(dynamic body);
}
