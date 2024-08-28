import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Utils {
  static showLoadingSpinner() {
    return const SpinKitFadingCircle(
      color: Colors.white,
      size: 30,
    );
  }
}
