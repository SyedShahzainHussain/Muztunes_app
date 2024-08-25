import 'package:flutter/material.dart';
import 'package:muztunes_app/config/colors.dart';
import 'package:muztunes_app/extension/media_query_extension.dart';

class SearchMerchandiseWidget extends StatelessWidget {
  final int? index;
  final Color? color;
  const SearchMerchandiseWidget({super.key, this.color, this.index});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: index ?? 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: index == null ? 1.70 : 0.80,
        ),
        itemCount: data.length,
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final product = data[index];
          return SearchMerchandise(
            imageUrl: product["imageUrl"],
            subTitle: product["subTitle"],
            title: product["title"],
            color: color,
          );
        });
  }
}

class SearchMerchandise extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final Color? color;

  const SearchMerchandise({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            height: context.screenHeight * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.redColor,
            ),
          ),
          Container(
              height: context.screenHeight * 0.25,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: color ?? const Color(0xffF7F3F5),
                ),
                borderRadius: BorderRadius.circular(12.0),
                color: color ?? const Color(0xffF7F3F5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: context.screenHeight * 0.02,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: 50,
                        height: 50,
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> data = [
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2018/12/globe-free-img.png",
    "title": "Express Delivery",
    "subTitle": "Free shipping around the world for all orders over \$150",
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2018/12/quality-free-img.png",
    "title": "Friendly Services",
    "subTitle": "With our payment gateway, don’t worry about your information.",
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2018/12/tag-free-img.png",
    "title": "Premium Packaging",
    "subTitle": "All pieces come carefully packed complete with packaging.",
  },
  {
    "imageUrl":
        "https://shop.muztunes.co/wp-content/uploads/2018/12/lock-free-img.png",
    "title": "Secure Payments",
    "subTitle":
        "With our payment gateway, don’t worry about your information.​",
  },
];
