import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muztunes/extension/media_query_extension.dart';
import 'package:muztunes/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztunes/utils/utils.dart';
import 'package:muztunes/view/auth/forgot_screen.dart';
import 'package:muztunes/viewModel/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordObsecue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  saveUserlogin() async {
    final validate = _formKey.currentState!.validate();
    if (!validate) return;

    if (validate) {
      final body = {
        "email": emailController.text.toString(),
        "password": passwordController.text.toString(),
      };
      print(body);
      context.read<AuthViewModel>().loginUser(body, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.screenHeight * 0.2,
                    ),
                    Text(
                      "Login",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
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
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        } else if (!value.contains("@") ||
                            !value.endsWith(".com")) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
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
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      cursorColor: Colors.red,
                      obscureText: passwordObsecue,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordObsecue = !passwordObsecue;
                              });
                            },
                            icon: Icon(passwordObsecue
                                ? Icons.visibility_off
                                : Icons.visibility)),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotScreen()));
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: const Color(0xffEF4D48),
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.02,
                    ),
                    Consumer<AuthViewModel>(
                      builder: (BuildContext context, value, Widget? child) {
                        return GestureDetector(
                          onTap: () {
                            saveUserlogin();
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
                              child: value.isLoginLoading
                                  ? Utils.showLoadingSpinner()
                                  : Center(
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
                        );
                      },
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
          ),
        ));
  }
}
