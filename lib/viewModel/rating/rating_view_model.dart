import 'package:flutter/material.dart';
import 'package:muztune/data/response/api_response.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/model/rating_model.dart';
import 'package:muztune/repository/rating/rating_http_repository.dart';
import 'package:muztune/repository/rating/rating_repository.dart';

class RatingViewModel with ChangeNotifier {
  final RatingRepository ratingRepository = RatingHttpRepository();
  bool ratingLoading = false;
  setRatingLoading(bool loading) {
    ratingLoading = loading;
    notifyListeners();
  }

  Future<void> putRatingApi(dynamic body, BuildContext context) async {
    setRatingLoading(true);
    await ratingRepository.postRating(body).then((data) {
      if (context.mounted) {
        context.flushBarSuccessMessage(message: "Your Review Has Been Send");
      }
      setRatingLoading(false);
    }).onError((error, _) {
      setRatingLoading(false);
      if (context.mounted) {
        context.flushBarSuccessMessage(
            message: "You Already Review The Product ");
      }
    });
  }

  ApiResponse<RatingModel> ratingListModel = ApiResponse.loading();
  setRatingListModel(ApiResponse<RatingModel> ratingListModel) {
    this.ratingListModel = ratingListModel;
    notifyListeners();
  }

  Future<void> getAllRating(dynamic body) async {
    setRatingListModel(ApiResponse.loading());
    await ratingRepository.getRating(body).then((data) {
      setRatingListModel(ApiResponse.complete(data));
      print(data);
    }).onError((error, _) {
      setRatingListModel(ApiResponse.error(error.toString()));
      print(error);
    });
  }
}
