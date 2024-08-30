import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Utils {
  static showLoadingSpinner([Color? color]) {
    return SpinKitFadingCircle(
      color: color ?? Colors.white,
      size: 30,
    );
  }

  static showToaster({required message,required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:  Color(0xFFEDEDED).withOpacity(0.9),
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        )));
  }
}
