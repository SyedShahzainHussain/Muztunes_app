import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/common/cutom_text_field.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/view/admin/viewmodel/create_product_view_model.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  saveCategory() {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }
    if (validate) {
      final body = {"title": titleController.text};
      context
          .read<CreateProductViewModel>()
          .createCategoryApi(jsonEncode(body), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Add Category",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
                controller: titleController,
                hintText: "Title",
              ),
              const SizedBox(height: 20),
              Consumer<CreateProductViewModel>(builder: (context, data, _) {
                return Button(
                  loading: data.categoryLoading,
                  title: "Submit",
                  onTap: () {
                    saveCategory();
                  },
                  color: AppColors.redColor,
                  titleColor: Colors.white,
                  showRadius: true,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
