import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/common/cutom_text_field.dart';
import 'package:muztune/common/t_rounded_container.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/data/response/status.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/view/admin/viewmodel/create_product_view_model.dart';
import 'package:muztune/viewModel/category/category_view_model.dart';
import 'package:provider/provider.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final tagController = TextEditingController();
  final informationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<XFile?> images = List.generate(5, (_) => null);

  String? selectedCategory;
  List<DropdownMenuItem<String>> categoryItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      context.read<CategoryViewModel>().getCategory();
    });
  }

  Future<void> saveProductApi() async {
    // Check if the form is valid
    final validate = _formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }

    bool allImagesSelected = images.every((image) => image != null);
    if (validate &&
        allImagesSelected &&
        selectedCategory != null &&
        selectedCategory!.isNotEmpty) {
      // Prepare form fields
      final fields = {
        "title": titleController.text,
        "description": descriptionController.text,
        "price": priceController.text,
        "quantity": 1,
        "tags": tagController.text,
        "information": informationController.text,
        "category": selectedCategory!,
        "slug": titleController.text,
      };

      // Prepare image files
      final imageFiles = images
          .where((image) => image != null)
          .map((image) => File(image!.path))
          .toList();

      context
          .read<CreateProductViewModel>()
          .createProductApi(fields, imageFiles, context, _formKey);
    } else {
      Utils.showToaster(
          message: "Please fill out all required fields", context: context);
      return;
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
          "Add Product",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Consumer<CategoryViewModel>(builder: (context, data, _) {
            switch (data.categoryList.status) {
              case Status.LOADING:
                return const Center(
                  child: TRoundedContainer(
                    padding: EdgeInsets.all(12),
                    width: 50,
                    height: 50,
                    backgroundColor: AppColors.redColor,
                    showBorder: true,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 3.0,
                    ),
                  ),
                );
              case Status.ERROR:
                return Center(
                  child: Text(data.categoryList.message!),
                );
              case Status.COMPLETED:
                final categories = data.categoryList.data!;
                categoryItems = categories.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.title,
                    child: Text(e.title!),
                  );
                }).toList();
                return Form(
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
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: "Description",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: priceController,
                        hintText: "Price",
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Price is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: tagController,
                        hintText: "Tag",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Tag is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: informationController,
                        hintText: "Information",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Information is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Category is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 8),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: const BorderSide(
                              color: Color(0xff83829A),
                              width: 0.4,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: const BorderSide(
                              color: Color(0xff83829A),
                              width: 0.4,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: const BorderSide(
                              color: Color(0xff83829A),
                              width: 0.4,
                            ),
                          ),
                        ),
                        items: categoryItems,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                        hint: const Text('Select Category'),
                        value: selectedCategory,
                      ),
                      const SizedBox(height: 10),
                      // Display image pickers
                      ...List.generate(5, (index) => buildImagePicker(index)),
                      const SizedBox(height: 20),
                      Consumer<CreateProductViewModel>(
                        builder: (context, data, _) {
                          return Button(
                            loading: data.productLoading,
                            title: "Submit",
                            onTap: () {
                              saveProductApi();
                            },
                            color: AppColors.redColor,
                            titleColor: Colors.white,
                            showRadius: true,
                          );
                        },
                      )
                    ],
                  ),
                );
            }
          }),
        ),
      ),
    );
  }

  Widget buildImagePicker(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${index + 1}. (Select image ${index + 1})",
              style: const TextStyle(color: Colors.black),
            ),
            images[index] == null
                ? const SizedBox()
                : const Text(
                    " *",
                    style: TextStyle(color: Colors.red),
                  ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            border: Border.all(color: Colors.grey),
          ),
          child: images[index] == null
              ? Center(
                  child: IconButton(
                    icon: const Icon(Icons.camera),
                    onPressed: () async {
                      final image =
                          await Utils().showBottomSheetDialog(context);
                      if (image != null) {
                        setState(() {
                          images[index] = image;
                        });
                      }
                    },
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    final image = await Utils().showBottomSheetDialog(context);
                    if (image != null) {
                      setState(() {
                        images[index] = image;
                      });
                    }
                  },
                  child: images[index] != null
                      ? Image.file(
                          File(images[index]!.path),
                          width: double.infinity,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox(),
                ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
