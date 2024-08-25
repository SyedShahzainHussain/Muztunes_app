import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muztunes_app/extension/media_query_extension.dart';
import 'package:muztunes_app/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.screenHeight * 0.2,
                  ),
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.01,
                  ),
                  Text(
                    "Please sign in continue.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.05,
                  ),
                  TextFormField(
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      prefixIcon: const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          )),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.02,
                  ),
                  TextFormField(
                    cursorColor: Colors.red,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      prefixIcon: const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          )),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color(0xffEF4D48),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (_) => EntryPointScreen()),
                      //     (route) => false);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xffEF4D48),
                        ),
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.02,
                  ),
                  Consumer<BottomNavigationProvider>(
                    builder: (context, data, _) => Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "Dont't have an acoount? ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey),
                        ),
                        TextSpan(
                          text: "Sign up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => const SignUpScreen()),
                              //     (route) => false);
                              data.setIsLogin = false;
                            },
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: const Color(0xffEF4D48),
                                  fontWeight: FontWeight.bold),
                        ),
                      ])),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
