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

class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final tagController = TextEditingController();
  final informationController = TextEditingController();
  final linkController = TextEditingController();
  final skuController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // List of selected categories
  final Set<String> selectedCategories = Set();

  XFile? images;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      context.read<CategoryViewModel>().getCategory();
    });
  }

  saveArticleApi() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (images == null) {
        Utils.showToaster(message: "Please select an image", context: context);
        return;
      }

      if (selectedCategories.isEmpty) {
        Utils.showToaster(
            message: "At least one category is required ", context: context);
        return;
      }

      final fields = {
        "title": titleController.text,
        "description": descriptionController.text,
        "price": priceController.text,
        "tags": tagController.text,
        "information": informationController.text,
       "category": selectedCategories.last,
        "slug": titleController.text,
        "quantity": 1,
        "link": linkController.text,
        "sku": skuController.text
      };
      context
          .read<CreateProductViewModel>()
          .createArticleApi(fields, File(images!.path), context);
    } else {
      Utils.showToaster(
          message: "Please fill out all required fields", context: context);
    } // Check if the form is valid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Add Article",
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

                    const SizedBox(
                      height: 10,
                    ),
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
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // CustomTextField(
                    //   controller: quantityController,
                    //   hintText: "Quantity",
                    //   keyboardType: TextInputType.number,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Quantity is required";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.url,
                      controller: linkController,
                      hintText: "Article Link",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Article Link is required";
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
                    const Text(
                      " (Optional)",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: skuController,
                      hintText: "SKU",
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 10),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Cateogries",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )),
                    SizedBox(
                      height: 65,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          runSpacing: 8.0,
                          spacing: 8.0,
                          children: categories.map((category) {
                            return SizedBox(
                              height: 60,
                              child: FilterChip(
                                label: Text(category.title!),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                selected:
                                    selectedCategories.contains(category.title),
                                selectedColor: AppColors.redColor,
                                backgroundColor: Colors.black,
                                checkmarkColor: Colors.white,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      // Clear previously selected categories and add the new one
                                      selectedCategories.clear();
                                      selectedCategories.add(category.title!);
                                    } else {
                                      // If the category is deselected, remove it from the selected categories
                                      selectedCategories.remove(category.title);
                                    }
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // Display image pickers
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "${1}. (Select image ${1})",
                              style: TextStyle(color: Colors.black),
                            ),
                            images == null
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
                          child: images == null
                              ? Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.camera),
                                    onPressed: () async {
                                      final image = await Utils()
                                          .showBottomSheetDialog(context);
                                      if (image != null) {
                                        setState(() {
                                          images = image;
                                        });
                                      }
                                    },
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    final image = await Utils()
                                        .showBottomSheetDialog(context);
                                    if (image != null) {
                                      setState(() {
                                        images = image;
                                      });
                                    }
                                  },
                                  child: Image.file(
                                    File(images!.path),
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<CreateProductViewModel>(
                        builder: (context, data, _) {
                      return Button(
                        loading: data.articleLoading,
                        title: "Submit",
                        onTap: () {
                          saveArticleApi();
                        },
                        color: AppColors.redColor,
                        titleColor: Colors.white,
                        showRadius: true,
                      );
                    })
                  ],
                ),
              );
          }
        })),
      ),
    );
  }
}
