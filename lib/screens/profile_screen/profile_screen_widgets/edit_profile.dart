import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/intro_video_provider.dart';
import 'package:odyss/core/providers/profile_picture_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
import 'package:odyss/screens/profile_screen/profile_screen_widgets/image_changer_button.dart';
import 'package:odyss/screens/profile_screen/profile_screen_widgets/video_changer_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

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

  Future<File> downloadFileFromUrl(String url, String filename) async {
    final response = await http.get(Uri.parse(url));
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  VideoPlayerController? _controller;
  File? _lastFile;

  void _initializeVideo(File file) async {
    _controller?.dispose();
    _controller = VideoPlayerController.file(file);
    await _controller!.initialize();
    _controller!.play();
    setState(() {});
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
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<File?>(videoFileProvider, (previous, next) {
      if (next != null && next != _lastFile) {
        _lastFile = next;
        _initializeVideo(next);
      }
    });

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (user.video.isNotEmpty) {
        final file = await downloadFileFromUrl(user.video, 'profile_video.mp4');
        ref.read(imageFileProvider.notifier).setImage(file);
      }
    });

    final video = ref.watch(videoFileProvider);
    final profilePic = ref.watch(imageFileProvider);

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
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 40,
                            runSpacing: 40,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.blueGrey.shade100,
                                  image: DecorationImage(
                                    image: profilePic != null
                                        ? FileImage(profilePic)
                                        : const AssetImage(
                                                'assets/images/default_profile.png',
                                              )
                                              as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(child: ImageChangerButton()),
                              ),
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      color: Colors.blueGrey.shade100,
                                      child:
                                          video != null &&
                                              _controller != null &&
                                              _controller!.value.isInitialized
                                          ? VideoPlayer(_controller!)
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 420,
                                    child: const VideoChangerButton(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                            onPressed: () {
                            
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
