import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:muztune/common/rating.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/view/home/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final String subTitle;
  final String? information;
  final String type;
  final double price;
  final bool isSale;
  final List<String>? images;
  final List<String> tags;
  final  String category;
  final  List<String> color;
  final String? image;
  final String totalrating;
  final String link;
  final bool? isProduct;

  const ProductTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.type,
    required this.tags,
    required this.price,
    required this.color,
    this.isSale = false,
    required this.category,
    this.images,
    this.information,
    required this.productId,
    required this.totalrating,
    required this.link,
    this.image,
    this.isProduct = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetailScreen(
                      type: type,
                      productId: productId,
                      image: image ?? "",
                      images: images ?? [],
                      category: category,
                      description: subTitle,
                      tags: tags,
                      title: title,
                      price: price.toString(),
                      isProduct: isProduct,
                      link: link,
                      information:information ,
                      colors:  color,
                    )));
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
                        child: FancyShimmerImage(
                          imageUrl: imageUrl,
                          boxFit: BoxFit.contain,
                          width: double.infinity,
                          height: context.screenHeight * 0.13,
                          shimmerBaseColor: Colors.grey[300]!,
                          shimmerHighlightColor: Colors.grey[100]!,
                          errorWidget: const Center(child: Icon(Icons.error)),
                        ),
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.02,
                      ),
                      Text(
                        title,
                        maxLines: 1,
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
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.01,
                      ),
                      Text.rich(TextSpan(children: [
                        // TextSpan(
                        //   text: "\$22.99",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodySmall!
                        //       .copyWith(
                        //           color: Colors.grey,
                        //           fontWeight: FontWeight.w500,
                        //           decoration: TextDecoration.lineThrough),
                        // ),
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
                      RatingIndicator(
                          rating: double.tryParse(totalrating.toString()) ?? 0)
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
