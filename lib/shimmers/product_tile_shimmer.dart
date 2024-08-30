import 'package:flutter/material.dart';
import 'package:muztunes/extension/media_query_extension.dart';
import 'package:muztunes/utils/shimmer/shimmer.dart';

class ProductTileShimmer extends StatelessWidget {
  const ProductTileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        elevation: 5,
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerEffect(
                    width: double.infinity,
                    height: context.screenHeight * 0.2,
                    color: Colors.grey[300],
                    radius: 12.0,
                  ),
                  const SizedBox(height: 8),
                  ShimmerEffect(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 20,
                  ),
                  const SizedBox(height: 8),
                  ShimmerEffect(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 20,
                  ),
                  const SizedBox(height: 8),
                  ShimmerEffect(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 20,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
