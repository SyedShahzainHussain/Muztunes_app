import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muztune/common/button.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/utils/utils.dart';
import 'package:muztune/viewModel/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String image;
  final String title;
  const EditProfileScreen(
      {super.key, required this.title, required this.image});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.title;
  }

  void updateProfile() {
    final validate = _form.currentState!.validate();
    if (!validate) return;
    if (validate && context.read<ProfileViewModel>().selectedImage != null) {
      context
          .read<ProfileViewModel>()
          .updateProfileImageApi(nameController.text, context);
    } else {
      Utils.showToaster(message: "Selected Image", context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Edit Profile",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                )),
      ),
      body: PopScope(
        canPop: false,
        // ignore: deprecated_member_use
        onPopInvoked: (didPop) {
          if (!didPop) {
            context.read<ProfileViewModel>().clearSelectedImage();
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                // Todo Profile Picture
                Consumer<ProfileViewModel>(
                  builder: (context, data, _) => Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.redColor,
                                width: 2.0,
                              )),
                          child: CircleAvatar(
                            backgroundImage: data.selectedImage == null
                                ? NetworkImage(widget.image)
                                : FileImage(data.selectedImage!),
                            radius: 60,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: -5,
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.redColor,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                final image = await Utils()
                                    .showBottomSheetDialog(context);
                                if (context.mounted && image != null) {
                                  context
                                      .read<ProfileViewModel>()
                                      .setSelectedImage(File(image.path));
                                }
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    prefixIcon: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        )),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Consumer<ProfileViewModel>(
        builder: (context, data, _) => Container(
          margin: const EdgeInsets.all(12.0),
          child: Button(
            loading: data.profileLoading,
            onTap: () {
              updateProfile();
            },
            title: "Update Profile",
            color: AppColors.redColor,
          ),
        ),
      ),
    );
  }
}
