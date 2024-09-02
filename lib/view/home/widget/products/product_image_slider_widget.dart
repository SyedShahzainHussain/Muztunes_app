import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muztune/common/curved_widget.dart';
import 'package:muztune/common/custom_app_bar.dart';
import 'package:muztune/common/t_rounded_image.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/model/product_model.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String>? images;
  final String? image;

  const ProductImageSlider({
    super.key,
    this.images,
    this.image,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  @override
  void initState() {
    super.initState();
    context.read<ProductViewModel>().selectedImage =
        widget.images!.isEmpty ? widget.image! : widget.images![0];
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
              widget.images!.isEmpty
                  ? const SizedBox()
                  : Positioned(
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
                            itemCount: widget.images!.length,
                            itemBuilder: (context, index) {
                              final imageSeletected =
                                  data.selectedImage == widget.images![index];

                              return TRoundedImage(
                                onPressed: () {
                                  context
                                      .read<ProductViewModel>()
                                      .setSelectedImage = widget.images![index];
                                },
                                width: 80,
                                backgroundColor: const Color(0xFF272727),
                                border: Border.all(
                                    color: imageSeletected
                                        ? AppColors.redColor
                                        : Colors.grey),
                                padding: const EdgeInsets.all(6),
                                imageUrl: widget.images![index],
                                isNetworkImage: true,
                              );
                            }),
                      )),
              // ! Appbar Icons
              const CustomAppBar(
                showBackArrow: true,
                actions: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
