import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muztunes_apps/common/curved_widget.dart';
import 'package:muztunes_apps/common/custom_app_bar.dart';
import 'package:muztunes_apps/common/t_rounded_image.dart';
import 'package:muztunes_apps/config/colors.dart';
import 'package:muztunes_apps/model/product_model.dart';
import 'package:muztunes_apps/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductImageSlider extends StatefulWidget {
  final List<Images> images;
  const ProductImageSlider({
    super.key,
    required this.images,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  @override
  void initState() {
    super.initState();
    context.read<ProductViewModel>().selectedImage = widget.images[0].url!;
  }

  @override
  Widget build(BuildContext context) {
    return CurvedWidget(
      child: Consumer<ProductViewModel>(
        builder: (context, data, _) => Container(
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
                      imageUrl: data.selectedImage,
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
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          final imageSeletected =
                              data.selectedImage == widget.images[index].url;

                          return TRoundedImage(
                            onPressed: () {
                              context
                                  .read<ProductViewModel>()
                                  .setSelectedImage = widget.images[index].url!;
                            },
                            width: 80,
                            backgroundColor: const Color(0xFF272727),
                            border: Border.all(
                                color: imageSeletected
                                    ? AppColors.redColor
                                    : Colors.grey),
                            padding: const EdgeInsets.all(6),
                            imageUrl: widget.images[index].url!,
                            isNetworkImage: true,
                          );
                        }),
                  )),
              // ! Appbar Icons
              const CustomAppBar(
                showBackArrow: true,
                actions: [
                 
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
