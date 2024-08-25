import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:muztunes_app/config/colors.dart';

class Heading extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool? more;
  const Heading({super.key, required this.title, this.onTap, this.more});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
          ),
          more == null
              ? GestureDetector(
                  onTap: onTap,
                  child: const Icon(
                    AntDesign.appstore1,
                    color: AppColors.redColor,
                    size: 20,
                  ))
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
