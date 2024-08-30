import 'package:flutter/material.dart';
import 'package:muztunes/common/rating.dart';
import 'package:muztunes/common/t_rounded_container.dart';
import 'package:muztunes/config/colors.dart';
import 'package:readmore/readmore.dart';

class UserRating extends StatelessWidget {
  const UserRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ! profile of rating user
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2014/03/25/16/54/user-297566_640.png"),
                ),
                SizedBox(
                  width: 16.0,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        // ! Review
        Row(
          children: [
            const RatingIndicator(
              rating: 4,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Text(
              "03 March, 2024",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        const SizedBox(
          height: 16.0,
        ),
        const ReadMoreText(
          "The user inteface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great Job!",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: " show less",
          trimCollapsedText: " show more",
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.redColor,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.redColor,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        TRoundedContainer(
          backgroundColor: const Color(0xFFEDEDED),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shahzain Store",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "03 March 2024",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const ReadMoreText(
                  "The user inteface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great Job!",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: " show less",
                  trimCollapsedText: " show more",
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.redColor,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.redColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
