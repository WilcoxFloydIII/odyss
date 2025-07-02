import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageFileProvider = StateNotifierProvider<ImageFileNotifier, File?>(
  (ref) => ImageFileNotifier(),
);

class ImageFileNotifier extends StateNotifier<File?> {
  ImageFileNotifier() : super(null);

  void setImage(File file) => state = file;

  void setInitialImage(String? path) {
    if (path != null && path.isNotEmpty) {
      state = File(path);
    }
  }

  void clear() {
    state = null;
  }
}
