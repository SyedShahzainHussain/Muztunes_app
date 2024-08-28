import 'package:flutter/material.dart';
import 'package:muztunes_apps/config/colors.dart';
import 'package:muztunes_apps/extension/media_query_extension.dart';
import 'package:muztunes_apps/view/home/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final double price;
  final bool isSale;

  const ProductTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.price,
    this.isSale = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ProductDetailScreen()));
      },
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
                color: AppColors.redColor,
              ),
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffF7F3F5),
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xffF7F3F5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: context.screenHeight * 0.02,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.02,
                      ),
                      Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.01,
                      ),
                      Text(
                        subTitle,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.01,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "\$22.99",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough),
                        ),
                        TextSpan(
                          text: " \$$price",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ])),
                      SizedBox(
                        height: context.screenHeight * 0.01,
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star_border, size: 15),
                          Icon(Icons.star_border, size: 15),
                          Icon(Icons.star_border, size: 15),
                          Icon(Icons.star_border, size: 15),
                          Icon(Icons.star_border, size: 15),
                        ],
                      )
                    ],
                  ),
                )),
            isSale
                ? Positioned(
                    top: -2,
                    right: -5,
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: AppColors.redColor, shape: BoxShape.circle),
                      child: Center(
                          child: FittedBox(
                        child: Text("Sale!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white)),
                      )),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
