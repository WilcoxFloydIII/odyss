import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoFileProvider = StateNotifierProvider<VideoFileNotifier, File?>((
  ref,
) {
  return VideoFileNotifier();
});

class VideoFileNotifier extends StateNotifier<File?> {
  VideoFileNotifier() : super(null);

  void setVideo(File file) {
    state = file;
  }

  void clear() => state = null;
}
