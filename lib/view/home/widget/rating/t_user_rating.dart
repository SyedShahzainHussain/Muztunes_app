import 'package:flutter/material.dart';
import 'package:muztune/common/rating.dart';
import 'package:muztune/config/colors.dart';
import 'package:readmore/readmore.dart';

class UserRating extends StatelessWidget {
  final String imageurl;
  final double rating;
  final String name;
  final String comment;
  const UserRating({
    super.key,
    required this.imageurl,
    required this.rating,
    required this.comment,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! profile of rating user
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageurl),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
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
            RatingIndicator(
              rating: rating,
            ),
          ],
        ),

        const SizedBox(
          height: 16.0,
        ),
        ReadMoreText(
          comment,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: " show less",
          trimCollapsedText: " show more",
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.redColor,
          ),
          lessStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.redColor,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        // TRoundedContainer(
        //   backgroundColor: const Color(0xFFEDEDED),
        //   child: Padding(
        //     padding: const EdgeInsets.all(16),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               "Shahzain Store",
        //               style: Theme.of(context).textTheme.titleMedium,
        //             ),
        //             Text(
        //               "03 March 2024",
        //               style: Theme.of(context).textTheme.bodyMedium,
        //             )
        //           ],
        //         ),
        //         const SizedBox(
        //           height: 16.0,
        //         ),
        //         const ReadMoreText(
        //           "The user inteface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great Job!",
        //           trimLines: 2,
        //           trimMode: TrimMode.Line,
        //           trimExpandedText: " show less",
        //           trimCollapsedText: " show more",
        //           moreStyle: TextStyle(
        //             fontSize: 14,
        //             fontWeight: FontWeight.bold,
        //             color: AppColors.redColor,
        //           ),
        //           lessStyle: TextStyle(
        //             fontSize: 14,
        //             fontWeight: FontWeight.bold,
        //             color: AppColors.redColor,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 16.0,
        // ),
      ],
    );
  }
}
