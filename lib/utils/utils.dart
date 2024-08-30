import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Utils {
  static showLoadingSpinner([Color? color]) {
    return SpinKitFadingCircle(
      color: color??Colors.white,
      size: 30,
    );
  }
}
