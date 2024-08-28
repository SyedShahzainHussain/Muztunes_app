import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:muztunes_apps/common/button.dart';
import 'package:muztunes_apps/config/colors.dart';
import 'package:muztunes_apps/extension/media_query_extension.dart';
import 'package:muztunes_apps/viewModel/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  forgotPasswrodApi() {
    final validate = _formKey.currentState!.validate();
    if (!validate) return;
    if (validate) {
      final body = {"email": emailController.text};
      context.read<AuthViewModel>().forgotPassword(body, context);
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
                    "Forgot Password",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.01,
                  ),
                  Text(
                    "Enter the email address associated\nwith your account.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.03,
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
                    height: context.screenHeight * 0.03,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Consumer<AuthViewModel>(
                        builder: (context, data, _) => Button(
                          loading: data.isForgotPasswordLoading,
                          onTap: () {
                            forgotPasswrodApi();
                          },
                          title: "Recover Password",
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
