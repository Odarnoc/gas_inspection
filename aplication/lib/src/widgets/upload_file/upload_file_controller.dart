import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class UploadFileController extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();

  UploadFileController();

  File? _image;

  File? getImage() => _image;

  set image(File image) {
    _image = image;
    notifyListeners();
  }

  Uint8List? _imageBytes;

  Uint8List? getImageBytes() => _imageBytes;

  set imageBytes(Uint8List? imageBytes) {
    _imageBytes = imageBytes;
    notifyListeners();
  }

  pickImage(ImageSource source) async {
    XFile? xlife = await picker.pickImage(source: source);
    if (xlife == null) return;
    File tempFile = File(xlife.path);
    image = tempFile;
  }
}
