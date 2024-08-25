import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final String title;
  final Color? titleColor;
  final bool? showRadius;
  const Button({
    super.key,
    this.color,
    this.borderColor,
    required this.title,
    this.titleColor,
    this.showRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      height: 40,
      decoration: BoxDecoration(
          color: color,
          border: borderColor == null ? null : Border.all(color: borderColor!),
          borderRadius: showRadius == true ? BorderRadius.circular(8.0) : null),
      child: Center(
          child: FittedBox(
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w800, color: titleColor ?? Colors.white),
        ),
      )),
    );
  }
}
