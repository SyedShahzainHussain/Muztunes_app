import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/viewModel/auth/auth_view_model.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool passwordObsecue = false;
  bool confirmPasswordObsecue = false;

  resetPasswordApi() {
    final validate = _formKey.currentState!.validate();
    if (!validate) return;
    if (validate) {
      final body = {
        "code": SessionController().otpCode.toString(),
        "password": passwordController.text
      };
      context.read<AuthViewModel>().resetPassword(body, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Ionicons.arrow_back_circle)),
        ),
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
                    "Reset Password",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.01,
                  ),
                  Text(
                    "Your new password must be different\nfrom previously used password.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.03,
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
                    height: context.screenHeight * 0.03,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Consumer<AuthViewModel>(
                        builder: (context, data, _) => Button(
                          loading: data.isResetPasswordLoading,
                          onTap: () {
                            resetPasswordApi();
                          },
                          title: "Confirm",
                          color: AppColors.redColor,
                        ),
                      ))
                ],
              ),
            ),
          ),
        )));
  }
}
