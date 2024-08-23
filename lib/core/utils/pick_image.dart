import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> selectImage() async {
  try {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) {
      return null;
    } else {
      return File(xFile.path);
    }
  } catch (e) {
    e.toString();
    return null;
  }
}
