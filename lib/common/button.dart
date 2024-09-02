import 'package:flutter/material.dart';
import 'package:muztune/utils/utils.dart';

class Button extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final String title;
  final Color? titleColor;
  final bool? showRadius;
  final void Function()? onTap;
  final bool loading;
  const Button({
    super.key,
    this.color,
    this.borderColor,
    required this.title,
    this.titleColor,
    this.onTap,
    this.showRadius,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 6.0, right: 6.0),
        height: 40,
        decoration: BoxDecoration(
            color: color,
            border:
                borderColor == null ? null : Border.all(color: borderColor!),
            borderRadius:
                showRadius == true ? BorderRadius.circular(8.0) : null),
        child: Center(
            child: loading
                ? Utils.showLoadingSpinner()
                : FittedBox(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w800,
                          color: titleColor ?? Colors.white),
                    ),
                  )),
      ),
    );
  }
}
