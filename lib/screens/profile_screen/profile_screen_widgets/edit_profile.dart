// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/list_providers/ride_list_provider.dart';
import 'package:odyss/core/providers/other_providers/intro_video_provider.dart';
import 'package:odyss/core/providers/other_providers/profile_picture_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';
import 'package:odyss/screens/profile_screen/profile_screen_widgets/image_changer_button.dart';
import 'package:odyss/screens/profile_screen/profile_screen_widgets/video_changer_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController insatgramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();

  // Future<File> downloadFileFromUrl(String url, String filename) async {
  //   final response = await http.get(Uri.parse(url));
  //   final dir = await getTemporaryDirectory();
  //   final file = File('${dir.path}/$filename');
  //   await file.writeAsBytes(response.bodyBytes);
  //   return file;
  // }

  // VideoPlayerController? _controller;
  // File? _lastFile;

  // void _initializeVideo(File file) async {
  //   _controller?.dispose();
  //   _controller = VideoPlayerController.file(file);
  //   await _controller!.initialize();
  //   _controller!.play();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   final users = ref.read(userListProvider).value ?? [];
    //   final user = users.firstWhere((element) => element.id == UID);
    //   if (user != null) {
    //     if (user.picture.isNotEmpty) {
    //       final file = await downloadFileFromUrl(
    //         user.picture,
    //         'profile_pic.jpg',
    //       );
    //       ref.read(imageFileProvider.notifier).setImage(file);
    //     }
    //     if (user.video.isNotEmpty) {
    //       final file = await downloadFileFromUrl(
    //         user.video,
    //         'profile_video.mp4',
    //       );
    //       ref.read(videoFileProvider.notifier).setVideo(file);
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    nickNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    tiktokController.dispose();
    insatgramController.dispose();
    twitterController.dispose();
    facebookController.dispose();
    // _controller?.dispose();
    super.dispose();
  }

  // Future<String?> uploadFile({
  //   required String uploadUrl,
  //   required String filePath,
  //   required String fieldName,
  //   required String token,
  //   required String contentType,
  // }) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
  //   request.headers['Authorization'] = 'Bearer $token';
  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       fieldName,
  //       filePath,
  //       contentType: MediaType.parse(contentType),
  //     ),
  //   );
  //   final streamedResponse = await request.send();
  //   final response = await http.Response.fromStream(streamedResponse);

  //   if (response.statusCode == 200) {
  //     // Expecting: { "url": "https://..." }
  //     final decoded = jsonDecode(response.body);
  //     return decoded['url'] as String?;
  //   } else {
  //     throw Exception('Failed to upload file: ${response.body}');
  //   }
  // }

  Future<void> updateMyProfile() async {
    final token = await secureStorage.read(key: 'access_token');
    final url = Uri.parse(usersUrl); // Set your baseUrl somewhere accessible

    // Collect data from controllers and providers
    final data = {
      'nickname': nickNameController.text,
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'bio': bioController.text,
      'tiktok': tiktokController.text,
      'insta': insatgramController.text,
      'x': twitterController.text,
      'fb': facebookController.text,
      // Add these if you want to send media URLs or base64:
      // 'intro_video': ...,
      // 'avatar': ...,
    };

    // Optionally add video and image if you want to send them as URLs or base64
    // final videoFile = ref.read(videoFileProvider);
    // final profilePic = ref.read(imageFileProvider);

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingAnimationWidget(),
    );

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      Navigator.pop(context); // Remove loading

      if (response.statusCode == 200) {
        // Success! Optionally show a success dialog or message
        // You can also update the user provider here if needed
      } else {
        showDialog(
          context: context,
          builder: (_) => ErrorDialogWidget(error: response.body),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Remove loading
      showDialog(
        context: context,
        builder: (_) => ErrorDialogWidget(error: e.toString()),
      );
    }
  }

  Future<void> updateMyProfileWithSeparateUploads() async {
    final token = await secureStorage.read(key: 'access_token');
    // final profilePic = ref.read(imageFileProvider);
    // final videoFile = ref.read(videoFileProvider);

    // String? imageUrl;
    // String? videoUrl;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingAnimationWidget(),
    );

    try {
      // 1. Upload image if available
      // if (profilePic != null) {
      //   imageUrl = await uploadFile(
      //     uploadUrl: uploadUrl, // <-- your image upload endpoint
      //     filePath: profilePic.path,
      //     fieldName: 'file',
      //     token: token!,
      //     contentType: 'image/jpeg', // or 'image/png'
      //   );
      // }

      // 2. Upload video if available
      // if (videoFile != null) {
      //   videoUrl = await uploadFile(
      //     uploadUrl: uploadUrl, // <-- your video upload endpoint
      //     filePath: videoFile.path,
      //     fieldName: 'file',
      //     token: token!,
      //     contentType: 'video/mp4',
      //   );
      // }

      // 3. Now PUT the profile data
      final url = Uri.parse(usersUrl);
      final data = {
        'nickname': nickNameController.text,
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'bio': bioController.text,
        'tiktok': tiktokController.text,
        'insta': insatgramController.text,
        'x': twitterController.text,
        'fb': facebookController.text,
        // if (imageUrl != null) 'avatar': imageUrl,
        // if (videoUrl != null) 'intro_video': videoUrl,
      };

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      Navigator.pop(context); // Remove loading

      if (response.statusCode == 200) {
        ref.invalidate(userListProvider);
        ref.invalidate(ridesListProvider);
        context.go('/profile');
      } else {
        showDialog(
          context: context,
          builder: (_) => ErrorDialogWidget(error: response.body),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Remove loading
      showDialog(
        context: context,
        builder: (_) => ErrorDialogWidget(error: e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen<File?>(videoFileProvider, (previous, next) {
    //   if (next != null && next != _lastFile) {
    //     _lastFile = next;
    //     _initializeVideo(next);
    //   }
    // });

    final myColors = Theme.of(context).extension<MyColors>()!;
    final userListAsync = ref.watch(userListProvider);

    if (userListAsync is AsyncLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (userListAsync is AsyncError) {
      return Scaffold(
        body: Center(
          child: Text('Failed to load user data: ${userListAsync.error}'),
        ),
      );
    }

    final users = userListAsync.value ?? [];
    final user = users.firstWhere((element) => element.id == UID);

    // Initialize controllers only if they are empty (to avoid overwriting edits on rebuild)
    nickNameController.text = user.nickName;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    bioController.text = user.bio;

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (user.video.isNotEmpty) {
    //     final file = await downloadFileFromUrl(user.video, 'profile_video.mp4');
    //     ref.read(imageFileProvider.notifier).setImage(file);
    //   }
    // });

    // final profilePic = ref.watch(imageFileProvider);
    // final videoFile = ref.watch(videoFileProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        child: Scaffold(
          backgroundColor: myColors.backgound,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_rounded, size: 25),
                  ),
                  Text(
                    'Edit your profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                0,
                MediaQuery.of(context).size.width * 0.05,
                0,
              ),
              color: myColors.backgound,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Wrap(
                    //         spacing: 40,
                    //         runSpacing: 40,
                    //         alignment: WrapAlignment.center,
                    //         runAlignment: WrapAlignment.center,
                    //         children: [
                    //           ClipRRect(
                    //             borderRadius: BorderRadius.circular(60),
                    //             child: Container(
                    //               width: 120,
                    //               height: 120,
                    //               color: Colors.blueGrey.shade100,
                    //               child: Stack(
                    //                 children: [
                    //                   profilePic != null
                    //                       ? Image.file(
                    //                           profilePic,
                    //                           fit: BoxFit.cover,
                    //                           width: 120,
                    //                           height: 120,
                    //                         )
                    //                       : Center(
                    //                           child:
                    //                               CircularProgressIndicator(),
                    //                         ),
                    //                   Center(child: ImageChangerButton()),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           ClipRRect(
                    //             borderRadius: BorderRadius.circular(20),
                    //             child: Container(
                    //               width: 120,
                    //               height: 120,
                    //               color: Colors.blueGrey.shade100,
                    //               child: Stack(
                    //                 children: [
                    //                   videoFile != null &&
                    //                           _controller != null &&
                    //                           _controller!.value.isInitialized
                    //                       ? VideoPlayer(_controller!)
                    //                       : const Center(
                    //                           child:
                    //                               CircularProgressIndicator(),
                    //                         ),
                    //                   Center(child: VideoChangerButton()),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 40),
                    Text('Personal Info'),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nickname'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nickNameController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              fillColor: myColors.backgound,
                              hintText: 'Change your nickname',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Firstname'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: firstNameController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Change your first name',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Last Name'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: lastNameController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Change your last name',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bio'),

                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: bioController,
                            maxLength: 250,
                            maxLines: 3,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),

                            decoration: InputDecoration(
                              hintText: 'Write a bio',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text('Social Media Info', textAlign: TextAlign.start),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tiktok'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: tiktokController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: '@tiktok',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Instagram'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: insatgramController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: '@instagram',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Twitter'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: twitterController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: '@twitter',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Facebook'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: facebookController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'https://facebook.com/facebook',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await updateMyProfileWithSeparateUploads();
                            },
                            child: Text('Update'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
