import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/extension/media_query_extension.dart';
import 'package:muztune/viewModel/contact/contact_view_model.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  saveContactApi() async {
    final validate = _formKey.currentState!.validate();
    if (!validate) return;
    if (validate) {
      final body = {
        "name": nameController.text.toString(),
        "subject": subjectController.text.toString(),
        "email": emailController.text.toString(),
        "message": messageController.text.toString(),
      };

      context
          .read<ContactViewModel>()
          .contactPostApi(jsonEncode(body))
          .then((data) {
        nameController.clear();
        subjectController.clear();
        messageController.clear();
        emailController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Contact",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0,
              top: 12.0,
              right: 12.0,
              bottom: kBottomNavigationBarHeight + 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Don't be a stranger!",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                Text("You tell us. We listen.",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                Text(
                    "Feel free to contact us. We are available 24/7. We would love to hear your suggestions and feedbacks.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        )),
                SizedBox(height: context.screenHeight * 0.03),
                Material(
                  elevation: 5.0,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name is requried";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                            hintText: "NAME",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.02,
                        ),
                        TextFormField(
                          controller: subjectController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "SUBJECT is requried";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                            hintText: "SUBJECT",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.02,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "EMAIL is requried";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                            hintText: "EMAIL",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.02,
                        ),
                        TextFormField(
                          controller: messageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "MESSAGE is requried";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                            hintText: "MESSAGE",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.02,
                        ),
                        SizedBox(
                            width: context.screenWidth * .5,
                            child: Consumer<ContactViewModel>(
                                builder: (context, data, _) {
                              return Button(
                                loading: data.createContactLoading,
                                onTap: saveContactApi,
                                title: "SEND MESSAGE",
                                color: AppColors.redColor,
                              );
                            })),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.03),
                Text("Have any queries?",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                Text("We're here to help.​",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                SizedBox(height: context.screenHeight * 0.03),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                  },
                  border: TableBorder.all(
                      color:
                          Colors.transparent), // Adjust border color as needed
                  children: [
                    _buildTableRow("Phone:", "123 456 7890", context),
                    _buildTableRow("Email:", "Hello@muztunes.co", context),
                    _buildTableRow("Location:", "New York, USA", context),
                  ],
                ),
                SizedBox(
                  height: context.screenHeight * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value, BuildContext context) {
    return TableRow(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 8.0), // Adjust padding as needed
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SelectableText(
          value,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.redColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        // Empty widget for the third column if needed
        const SizedBox.shrink(),
      ],
    );
  }
}
