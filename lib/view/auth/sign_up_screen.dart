import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/providers/bottomnavigation/bottom_navigation_provider.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/viewModel/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordObsecue = false;
  bool confirmPasswordObsecue = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  saveUserRegister() async {
    final validate = _formKey.currentState!.validate();
    if (!validate) return;

    if (validate) {
      final body = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      };
      context.read<AuthViewModel>().registerUser(body, context);
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
                  height: context.screenHeight * 0.15,
                ),
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: context.screenHeight * 0.05,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Full Name is required";
                    }
                    return null;
                  },
                  controller: nameController,
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    prefixIcon: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.person_outline_sharp,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    } else if (!value.contains("@") ||
                        !value.endsWith(".com")) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  controller: emailController,
                  cursorColor: Colors.red,
                  keyboardType: TextInputType.emailAddress,
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
                  cursorColor: Colors.red,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: confirmPasswordController,
                  cursorColor: Colors.red,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Confirm password is required";
                    } else if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  obscureText: confirmPasswordObsecue,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            confirmPasswordObsecue = !confirmPasswordObsecue;
                          });
                        },
                        icon: Icon(confirmPasswordObsecue
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
                Consumer<AuthViewModel>(
                  builder: (BuildContext context, value, Widget? child) {
                    return GestureDetector(
                      onTap: () {
                        saveUserRegister();
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
                            child: value.isRegisterLoading
                                ? Utils.showLoadingSpinner()
                                : Text(
                                    "SIGN UP",
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
                        text: "Already have a acoount? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.grey),
                      ),
                      TextSpan(
                        text: "Sign in",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => const LoginScreen()),
                            //     (route) => false);
                            data.setIsLogin = true;
                          },
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
      )),
    );
  }
}
