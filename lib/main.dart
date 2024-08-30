import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muztunes/environment/environment.dart';
import 'package:muztunes/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztunes/view/splash/splash_screen.dart';
import 'package:muztunes/viewModel/auth/auth_view_model.dart';
import 'package:muztunes/viewModel/cart/cart_view_model.dart';
import 'package:muztunes/viewModel/category/category_view_model.dart';
import 'package:muztunes/viewModel/products/product_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  const String enviroment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.Dev,
  );

  Environment().initConfig(enviroment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'MUZTUNES',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme()),
        home: const SplashScreen(),
      ),
    );
  }
}
