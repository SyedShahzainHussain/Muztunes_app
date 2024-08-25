import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showBackArrow;
  final VoidCallback? leadingOnPress;
  final List<Widget>? actions;
  final IconData? leadingIcon;
  final bool? isTitleCenter;
  final double elevation;
  final Color? backGroundColor;
  const CustomAppBar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadingOnPress,
      this.actions,
      this.leadingIcon,
      this.isTitleCenter = false,
      this.elevation = 0.0,
      this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: elevation == 0.0
          ? const EdgeInsets.symmetric(horizontal: 8)
          : EdgeInsets.zero,
      child: AppBar(
        elevation: elevation,
        centerTitle: isTitleCenter,
        scrolledUnderElevation: 0.0,
        backgroundColor: backGroundColor ?? Colors.transparent,
        automaticallyImplyLeading: false,
        title: title,
        actions: actions,
        leading: showBackArrow
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Iconsax.arrow_left,
                  color: dark ? Colors.white : Colors.black,
                ))
            : leadingIcon != null
                ? IconButton(onPressed: leadingOnPress, icon: Icon(leadingIcon))
                : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
