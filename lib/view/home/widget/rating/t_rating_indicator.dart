
import 'package:flutter/material.dart';
import 'package:muztunes_app/config/colors.dart';
import 'package:muztunes_app/extension/media_query_extension.dart';

class TRatingIndicator extends StatelessWidget {
  const TRatingIndicator({
    super.key,
    required this.value,
    required this.text,
  });
  final double value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: context.screenWidth * 0.5,
            child: LinearProgressIndicator(
              minHeight: 10,
              value: value,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(AppColors.redColor),
            ),
          ),
        )
      ],
    );
  }
}