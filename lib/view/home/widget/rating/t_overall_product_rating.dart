import 'package:flutter/material.dart';
import 'package:muztune/view/home/widget/rating/t_rating_indicator.dart';

class OverAllProductRating extends StatelessWidget {
  const OverAllProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "4.8",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              TRatingIndicator(
                value: 1.0,
                text: "5",
              ),
              TRatingIndicator(
                value: 0.8,
                text: "4",
              ),
              TRatingIndicator(
                value: 0.6,
                text: "3",
              ),
              TRatingIndicator(
                value: 0.4,
                text: "2",
              ),
              TRatingIndicator(
                value: 0.2,
                text: "1",
              ),
            ],
          ),
        )
      ],
    );
  }
}
