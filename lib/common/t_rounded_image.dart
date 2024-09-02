import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muztune/utils/shimmer/shimmer.dart';

class TRoundedImage extends StatelessWidget {
  final String imageUrl;
  final bool isNetworkImage;
  final double? width, height;
  final double borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final BoxFit? fit;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final bool applyImageRadius;

  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.isNetworkImage = false,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.backgroundColor,
    this.applyImageRadius = true,
    this.border,
    this.fit = BoxFit.contain,
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const ShimmerEffect(width: double.infinity, height: 190),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                )
              : Image(
                  height: height,
                  width: width,
                  fit: fit,
                  image: AssetImage(imageUrl),
                ),
        ),
      ),
    );
  }
}
