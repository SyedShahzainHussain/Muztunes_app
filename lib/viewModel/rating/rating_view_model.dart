import 'package:flutter/material.dart';
import 'package:muztune/extension/flushbar_extension.dart';
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
}
