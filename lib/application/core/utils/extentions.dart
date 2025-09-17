
import 'package:flutter/material.dart';
import 'package:frijo/application/core/utils/device_size.dart';

extension StringCapitalization on String {
  String get capitalize {
    if (isEmpty) {
      return this;
    }

    List<String> words = split(" ");
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(" ");
  }
}


extension ThemeUtils on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color dynamicColor({required Color light, required Color dark}) {
    return isDarkMode ? dark : light;
  }
  /// Return gradient based on theme
  Gradient dynamicGradient({
    required Gradient light,
    required Gradient dark,
  }) {
    return isDarkMode ? dark : light;
  }
}

extension SizeScaler on num {
  double get sdp => DeviceSize.scale(toDouble());
}

// extension ImagePickerExt on ImagePicker {
//   Future<XFile?> pickImageFromGallery() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     return image;
//   }

//   Future<XFile?> pickImageFromCamers() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);
//     return image;
//   }
// }