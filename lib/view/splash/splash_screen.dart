import 'package:flutter/material.dart';
import 'package:muztunes_app/extension/media_query_extension.dart';
import 'package:muztunes_app/view/entry_point_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pre-load the image
    precacheImage(const AssetImage("assets/images/logo.png"), context);

    // Initialize AnimationController and Animation here
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 2), // Increased duration for slower animation
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 10), // Start from the bottom
      end: Offset.zero, // End at the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward().whenComplete(() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const EntryPointScreen()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: Image.asset(
            "assets/images/logo.png",
            width: context.screenWidth * 0.4,
            height: context.screenWidth * 0.4,
          ),
        ),
      ),
    );
  }
}
