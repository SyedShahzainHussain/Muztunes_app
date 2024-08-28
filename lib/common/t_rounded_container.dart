import 'package:flutter/material.dart';
import 'package:muztunes_apps/config/colors.dart';

class TRoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool showBorder;
  final Color borderColor;
  final Widget? child;

  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = 12,
    this.padding,
    this.margin,
    this.backgroundColor = Colors.white,
    this.showBorder = false,
    this.borderColor = AppColors.redColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(radius!),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
