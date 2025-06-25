import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageFileProvider = StateNotifierProvider<ImageFileNotifier, File?>((
  ref,
) {
  return ImageFileNotifier();
});

class ImageFileNotifier extends StateNotifier<File?> {
  ImageFileNotifier() : super(null);

  void setImage(File file) {
    state = file;
  }

  void clear() => state = null;
}
