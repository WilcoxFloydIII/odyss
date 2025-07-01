import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odyss/core/providers/profile_picture_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageChangerButton extends ConsumerWidget {
  const ImageChangerButton({Key? key}) : super(key: key);

  Future<void> _pickAndSaveProfilePic(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final picker = ImagePicker();

    // Request permissions
    PermissionStatus permissionStatus;
    if (Platform.isAndroid) {
      permissionStatus = await Permission.photos.request(); // Android 13+
      if (permissionStatus.isDenied) {
        permissionStatus = await Permission.storage
            .request(); // Android 12 and below
      }
    } else {
      permissionStatus = await Permission.photos.request(); // iOS
    }

    if (!permissionStatus.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Permission denied')));
      return;
    }

    // Pick image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // Get directory
    Directory dir = Platform.isAndroid
        ? (await getExternalStorageDirectory())!
        : await getApplicationDocumentsDirectory();

    final odyssDir = Directory('${dir.path}/odyss');
    if (!await odyssDir.exists()) await odyssDir.create(recursive: true);

    // Rename to profile_pic.<extension>
    final ext = image.name.split('.').last;
    final newFile = File('${odyssDir.path}/profile_pic.$ext');

    if (await newFile.exists()) {
      await newFile.delete();
    }
    await File(image.path).copy(newFile.path);
    imageCache.clear(); // Clears in-memory cache
    imageCache.clearLiveImages(); // Clears active widget images
    ref.read(imageFileProvider.notifier).setImage(newFile);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Profile picture updated successfully',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => _pickAndSaveProfilePic(ref, context),
      child: Image.asset('assets/images/pen.png', height: 25),
    );
  }
}
