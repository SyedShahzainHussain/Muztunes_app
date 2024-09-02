import 'package:flutter/material.dart';
import 'package:muztune/utils/shimmer/shimmer.dart';

class HomeGridShimmer extends StatelessWidget {
  const HomeGridShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return GridTile(
          footer: Container(
            color: Colors.black87,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ShimmerEffect(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[300],
                radius: 0.0,
              ),
              ShimmerEffect(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .3,
                color: const Color(0xff000000),
                radius: 0.0,
              ),
            ],
          ),
        );
      },
      itemCount: 4, // Adjust the number of shimmer items
    );
  }
}
