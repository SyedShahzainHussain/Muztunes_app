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
  final linkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<XFile?> images = List.generate(5, (_) => null);

  // List of selected categories
  final Set<String> selectedCategories = Set();
  // List of selected color
  List<String> selectedColors = [];

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

    // Check if at least one image is selected
    final selectedImages = images.where((image) => image != null).toList();
    if (selectedImages.isEmpty) {
      Utils.showToaster(
        message: "At least one image is required",
        context: context,
      );
      return;
    } else if (selectedCategories.isEmpty) {
      Utils.showToaster(message: "Please select a category", context: context);
      return;
    }
  

    // Prepare form fields
    final fields = {
      "title": titleController.text,
      "description": descriptionController.text,
      "price": priceController.text,
      "quantity": 1,
      "tags": tagController.text,
      "information": informationController.text,
      "category": selectedCategories.last,
      "slug": titleController.text,
      "link": linkController.text,
      "color": selectedColors.toList()
    };

    // Prepare image files
    final imageFiles =
        selectedImages.map((image) => File(image!.path)).toList();

    context
        .read<CreateProductViewModel>()
        .createProductApi(fields, imageFiles, context, _formKey);
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

                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        hintText: "Tag (Cat,Mobile,Electronic)",
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
                        hintText: "Information (L,S,M,EL)",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Information is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        keyboardType: TextInputType.url,
                        controller: linkController,
                        hintText: "Product Link",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Product Link is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        " (Optional)",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: "Description",
                      ),

                      const SizedBox(height: 10),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Cateogries",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          )),
                      SizedBox(
                        height: 80,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            runSpacing: 8.0,
                            spacing: 8.0,
                            children: categories.map((category) {
                              return SizedBox(
                                height: 80,
                                child: FilterChip(
                                  label: Text(category.title!),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  selected: selectedCategories
                                      .contains(category.title),
                                  selectedColor: AppColors.redColor,
                                  backgroundColor: Colors.black,
                                  checkmarkColor: Colors.white,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        // Add category if less than 3 are selected
                                        if (selectedCategories.length < 3) {
                                          selectedCategories
                                              .add(category.title!);
                                        } else {
                                          Utils.showToaster(
                                              message:
                                                  'You can select a maximum of 3 categories',
                                              context: context);
                                        }
                                      } else {
                                        // Remove category
                                        selectedCategories
                                            .remove(category.title);
                                      }
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                "Colors ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Text(
                                " (Optional)",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 65,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            runSpacing: 8.0,
                            spacing: 8.0,
                            children: Utils().colors.map((color) {
                              return SizedBox(
                                height: 60,
                                child: FilterChip(
                                  label: Text(Utils().colorToName(color)),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  selected: selectedColors
                                      .contains(Utils().colorToName(color)),
                                  selectedColor: AppColors.redColor,
                                  backgroundColor: Colors.black,
                                  checkmarkColor: Colors.white,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        // Add category if less than 3 are selected
                                        if (selectedColors.length < 3) {
                                          selectedColors
                                              .add(Utils().colorToName(color));
                                        } else {
                                          Utils.showToaster(
                                              message:
                                                  'You can select a maximum of 3 categories',
                                              context: context);
                                        }
                                      } else {
                                        // Remove category
                                        selectedColors
                                            .remove(Utils().colorToName(color));
                                      }
                                      print(selectedColors.toList());
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
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
            if (index != 0 && images[index] == null)
              const Text(
                " (Optional)",
                style: TextStyle(color: Colors.grey, fontSize: 10),
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
