import 'package:flutter/material.dart';
import 'package:muztune/extension/flushbar_extension.dart';
import 'package:muztune/repository/contact/contact_http_repository.dart';
import 'package:muztune/repository/contact/contact_repository.dart';
import 'package:muztune/utils/global_context.dart';

class ContactViewModel with ChangeNotifier {
  ContactRepository contactRepository = ContactHttpRepository();

  bool createContactLoading = false;
  setCreateContactLoading(bool loading) {
    createContactLoading = loading;
    notifyListeners();
  }

  Future contactPostApi(dynamic body) async {
    setCreateContactLoading(true);
    await contactRepository.contactPostApi(body).then((data) {
      if (ContextUtility.context.mounted) {
        ContextUtility.context.flushBarSuccessMessage(
            message: "Your message has been send to admin");
      }
      setCreateContactLoading(false);
    }).onError((error, _) {
      if (ContextUtility.context.mounted) {
        ContextUtility.context.flushBarErrorMessage(message: error.toString());
      }
      setCreateContactLoading(false);
    });
  }
}
