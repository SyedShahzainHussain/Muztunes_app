import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muztune/config/urls.dart';
import 'package:muztune/data/response/api_response.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/model/user_model.dart';
import 'package:muztune/repository/profile/profile_http_repository.dart';
import 'package:muztune/repository/profile/profile_repository.dart';
import 'package:muztune/viewModel/services/session_controller/session_controller.dart';
import 'package:provider/provider.dart';

class ProfileViewModel with ChangeNotifier {
  final ProfileRepository profileRepository = ProfileHttpRepository();
  File? selectedImage;

  bool profileLoading = false;

  setProfileLoading(bool profileLoading) {
    this.profileLoading = profileLoading;
    notifyListeners();
  }

  ApiResponse<User> userProfile = ApiResponse.loading();

  setProfileDetailsLoading(ApiResponse<User> userProfile) {
    this.userProfile = userProfile;
    notifyListeners();
  }

  setSelectedImage(File? image) {
    selectedImage = image;
    notifyListeners();
  }

  clearSelectedImage() {
    selectedImage = null;
    notifyListeners();
  }

  Future<void> getProfileDetails(String userId) async {
    setProfileDetailsLoading(ApiResponse.loading());
    await profileRepository.getProfileDetails(userId).then((data) {
      print(data);
      setProfileDetailsLoading(ApiResponse.complete(data));
    }).onError((error, _) {
      setProfileDetailsLoading(ApiResponse.error(error.toString()));
    });
  }

  Future<void> updateProfileImageApi(
    String name,
    BuildContext context,
  ) async {
    setProfileLoading(true);
    profileRepository
        .postFormData(
      url: Urls.updatedProfileUrl,
      fields: {"name": name},
      file: selectedImage!,
    )
        .then((data) {
      if (context.mounted) {
        clearSelectedImage();
        context
            .read<ProfileViewModel>()
            .getProfileDetails(SessionController().userModel.user!.id!);
        Navigator.pop(context);
        context.flushBarSuccessMessage(message: "User Updated Successfully");
      }
      setProfileLoading(false);
    }).onError((e, _) {
      if (context.mounted) {
        context.flushBarSuccessMessage(message: e.toString());
      }
      setProfileLoading(false);
    });
  }
}
