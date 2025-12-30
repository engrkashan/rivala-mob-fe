import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../repos/media_repo.dart';

class MediaProvider extends ChangeNotifier {
  final _mediaRepo = locator<MediaRepo>();
  String? uploadedUrl;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> upload({File? url}) async {
    setLoading(true);
    try {
      uploadedUrl = await _mediaRepo.uploadFile(file: selectedImage ?? url!);
      print("Uploaded image url: $uploadedUrl");
    } catch (e) {
      print("error while uploading: $e");
    }
    setLoading(false);
  }

  final ImagePicker _picker = ImagePicker();

  File? selectedImage;
  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file == null) return;
    selectedImage = File(file.path);
    notifyListeners();
  }
}
