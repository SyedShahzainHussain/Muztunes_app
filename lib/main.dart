import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muztune/environment/environment.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/utils/global_context.dart';
import 'package:muztune/view/admin/viewmodel/create_product_view_model.dart';
import 'package:muztune/view/splash/splash_screen.dart';
import 'package:muztune/viewModel/article/article_view_model.dart';
import 'package:muztune/viewModel/auth/auth_view_model.dart';
import 'package:muztune/viewModel/cart/cart_view_model.dart';
import 'package:muztune/viewModel/category/category_view_model.dart';
import 'package:muztune/viewModel/contact/contact_view_model.dart';
import 'package:muztune/viewModel/filter/filter_view_model.dart';
import 'package:muztune/viewModel/order/order_view_model.dart';
import 'package:muztune/viewModel/products/product_view_model.dart';
import 'package:muztune/viewModel/profile/profile_view_model.dart';
import 'package:muztune/viewModel/rating/rating_view_model.dart';
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
        ChangeNotifierProvider(
          create: (context) => ArticleViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilterViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => RatingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateProductViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactViewModel(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: ContextUtility.navigatorKey,
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
