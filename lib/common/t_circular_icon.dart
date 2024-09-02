import 'package:flutter/material.dart';

class TCircularIcons extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final IconData icon;
  final double? iconSize;
  final Color? color;
  final VoidCallback? onPressed;

  const TCircularIcons({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.iconSize,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor!,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: iconSize,
          )),
    );
  }
}
