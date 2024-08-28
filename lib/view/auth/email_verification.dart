import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:muztunes_apps/common/button.dart';
import 'package:muztunes_apps/config/colors.dart';
import 'package:muztunes_apps/extension/flushbar_extension.dart';
import 'package:muztunes_apps/extension/media_query_extension.dart';
import 'package:muztunes_apps/view/auth/reset_password_screen.dart';
import 'package:muztunes_apps/viewModel/auth/auth_view_model.dart';
import 'package:muztunes_apps/viewModel/services/session_controller/session_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      EmailVerificationScreenState();
}

class EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  emailVerifyApi() {
    final validate = _formKey.currentState!.validate();
    if (!validate) return;
    if (validate) {
      if (SessionController().otpCode != null) {
        if (SessionController().otpCode == int.parse(otpController.text)) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ResetPasswordScreen()));
        } else {
          context.flushBarErrorMessage(message: "Otp Is Incorrect ");
        }
      }
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
                    "Email Verification",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.01,
                  ),
                  Text(
                    "Please enter the 4 digit code that\nsend to your email address.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.03,
                  ),
                  PinCodeTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the code";
                      } else if (value.length != 6) {
                        return "All field are required";
                      }
                      return null;
                    },
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    pinTheme: PinTheme(
                      activeColor: AppColors.redColor,
                      inactiveColor: Colors.grey,
                      selectedColor: AppColors.redColor,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    controller: otpController,
                    onCompleted: (v) {
                      print(v);
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.03,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Button(
                        onTap: () {
                          emailVerifyApi();
                        },
                        title: "Verify and Proceed",
                        color: AppColors.redColor,
                      ))
                ],
              ),
            ),
          ),
        )));
  }
}
