import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muztunes_apps/common/curved_widget.dart';
import 'package:muztunes_apps/common/custom_app_bar.dart';
import 'package:muztunes_apps/common/t_rounded_image.dart';
import 'package:muztunes_apps/config/colors.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({
    super.key,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  List<String> images = [
    "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464.png",
    "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464.png",
    "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464.png",
    "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464.png",
    "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464.png",
    "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464.png",
  ];

  @override
  Widget build(BuildContext context) {
    return CurvedWidget(
      child: Container(
        color: const Color(0xFF939393),
        child: Stack(
          children: [
            // ! Main Large Image
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(8 * 2),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464.png",
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                        color: AppColors.redColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ! Image Slider
            Positioned(
                right: 0,
                bottom: 30,
                left: 8,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        final imageSeletected = "" == images[index];

                        return TRoundedImage(
                          onPressed: () {},
                          width: 80,
                          backgroundColor: const Color(0xFF272727),
                          border: Border.all(
                              color: imageSeletected
                                  ? AppColors.redColor
                                  : AppColors.redColor),
                          padding: const EdgeInsets.all(6),
                          imageUrl: images[index],
                          isNetworkImage: true,
                        );
                      }),
                )),
            // ! Appbar Icons
            const CustomAppBar(
              showBackArrow: true,
              actions: [
                // Container(
                //   width: 40,
                //   height: 40,
                //   padding: const EdgeInsets.all(8.0),
                //   decoration: const BoxDecoration(
                //       color: AppColors.redColor, shape: BoxShape.circle),
                //   child: Center(
                //       child: FittedBox(
                //     child: Text("Sale!",
                //         style: Theme.of(context)
                //             .textTheme
                //             .bodyLarge!
                //             .copyWith(color: Colors.white)),
                //   )),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
