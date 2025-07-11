import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/providers/other_providers/intro_video_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoPickerButton extends ConsumerWidget {
  const VideoPickerButton({super.key});

  Future<void> _pickAndSaveVideo(BuildContext context, WidgetRef ref) async {
    final picker = ImagePicker();

    // Permissions
    PermissionStatus permissionStatus;
    if (Platform.isAndroid) {
      permissionStatus = await Permission.videos.request();
      if (permissionStatus.isDenied) {
        permissionStatus = await Permission.storage.request();
      }
    } else {
      permissionStatus = await Permission.photos.request();
    }

    if (!permissionStatus.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Permission denied')));
      return;
    }

    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    Directory dir = Platform.isAndroid
        ? (await getExternalStorageDirectory())!
        : await getApplicationDocumentsDirectory();
    final odyssDir = Directory('${dir.path}/odyss');
    if (!await odyssDir.exists()) await odyssDir.create(recursive: true);

    final ext = video.name.split('.').last;
    final newFile = File('${odyssDir.path}/profile_video.$ext');

    if (await newFile.exists()) await newFile.delete();
    await File(video.path).copy(newFile.path);

    ref.read(videoFileProvider.notifier).setVideo(newFile);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(videoFileProvider);
    final myColors = Theme.of(context).extension<MyColors>()!;

    return ElevatedButton(
      onPressed: () => _pickAndSaveVideo(context, ref),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black54,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      ),
      child: Text(
        file != null ? 'Edit intro video' : '+ Add intro video',
        style: TextStyle(
          color: myColors.backgound,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
