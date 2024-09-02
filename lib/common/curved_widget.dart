import 'package:flutter/material.dart';
import 'package:muztune/common/clip_behaviour.dart';

class CurvedWidget extends StatelessWidget {
  final Widget child;
  const CurvedWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipBehavior(),
      child: Container(
        child: child,
      ),
    );
  }
}
