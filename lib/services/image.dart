import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture {

  static Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    return null;
  }
}