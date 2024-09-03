import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:muztune/utils/global_context.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  final ImagePicker _picker = ImagePicker();

  static showLoadingSpinner([Color? color]) {
    return SpinKitFadingCircle(
      color: color ?? Colors.white,
      size: 30,
    );
  }

  static showToaster({required message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFFEDEDED).withOpacity(0.9),
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        )));
  }

  Future<XFile?> pickImage(ImageSource imageSource) async {
    final image = await _picker.pickImage(
        source: imageSource, maxHeight: 1080, maxWidth: 1080, imageQuality: 60);
    if (image != null) {
      // Check image extension
      final extension = image.name.split('.').last.toLowerCase();
      if (extension == 'png' || extension == 'jpeg' || extension == 'jpg') {
        // Read the image file
        final bytes = await image.readAsBytes();
        final img.Image? decodedImage =
            img.decodeImage(Uint8List.fromList(bytes));

        if (decodedImage != null) {
          // Convert image if necessary
          img.Image convertedImage;
          String newExtension;

          if (extension == 'jpg' || extension == 'jpeg') {
            // Convert JPG/JPEG to PNG
            convertedImage = img.copyResize(decodedImage, width: 1080);
            newExtension = 'png';
          } else {
            // No conversion needed
            return image;
          }

          // Save the converted image
          final convertedBytes = img.encodePng(convertedImage);
          final tempDir = Directory.systemTemp;
          final convertedImageFile = File(
              '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.$newExtension');
          await convertedImageFile.writeAsBytes(convertedBytes);
          
          return XFile(convertedImageFile.path);
        }
      } else {
        // Show toaster if image is not PNG or JPEG
        Utils.showToaster(
          message: 'Only PNG and JPEG images are allowed',
          context: ContextUtility.context,
        );
        return null;
      }
    }
    return null;
  }

  String formatDate(String dateString) {
    try {
      // Parse the date string into a DateTime object
      DateTime date = DateTime.parse(dateString);

      // Format the DateTime object into a desired string format
      String formattedDate = DateFormat('dd MMM yyyy').format(date);

      return formattedDate;
    } catch (e) {
      print('Error formatting date: $e');
      return 'Invalid date';
    }
  }

  Future<XFile?> showBottomSheetDialog(BuildContext context) async {
    return await showModalBottomSheet<XFile?>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              final image = await pickImage(ImageSource.camera);
                              Navigator.pop(context, image);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              final image =
                                  await pickImage(ImageSource.gallery);
                              Navigator.pop(context, image);
                            },
                            icon: const Icon(
                                Icons.photo_size_select_actual_outlined),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Future imagePickerFromGallery(ImageSource imageSource) async {
  //   final XFile? image = await pickImage(imageSource);
  //   if (image == null) return;
  //   final bytes = await image.readAsBytes();
  //   final kb = bytes.length / 1024;
  //   final mb = kb / 1024;

  //   if (kDebugMode) {
  //     print("original image size:$mb");
  //   }

  //   final dir = await getTemporaryDirectory();
  //   final path = "${dir.absolute.path}/${image.path.split("/").last}";

  //   final result = await FlutterImageCompress.compressAndGetFile(
  //     path,
  //     path,
  //     minWidth: 1080,
  //     minHeight: 1080,
  //     quality: 90,
  //   );

  //   final data = await result!.readAsBytes();

  //   final newKb = data.length / 1024;
  //   final newMb = newKb / 1024;
  //   if (kDebugMode) {
  //     print("compiled image size:$newMb");
  //   }

  //   return File(result.path);
  // }

  Future<void> launchUrls(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Handle the error when the URL can't be launched
      debugPrint('Could not launch $url');
    }
  }
}
