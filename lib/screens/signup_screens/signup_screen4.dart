import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/intro_video_provider.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';
import 'package:odyss/screens/signup_screens/signup_screens_widgets/video_picker_button.dart';
import 'package:video_player/video_player.dart';

class SignupScreen4 extends ConsumerStatefulWidget {
  const SignupScreen4({super.key});

  @override
  ConsumerState<SignupScreen4> createState() => _SignupScreen4State();
}

class _SignupScreen4State extends ConsumerState<SignupScreen4> {
  VideoPlayerController? _controller;
  File? _lastFile;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _initializeVideo(File file) async {
    _controller?.dispose();
    _controller = VideoPlayerController.file(file);
    await _controller!.initialize();
    _controller!.play();
    setState(() {});
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
    final video = ref.watch(videoFileProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (video != null && await video.exists()) {
                            await video.delete();
                            ref.read(videoFileProvider.notifier).clear();
                          }
                          context.pop();
                        },
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Say Hi!',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Let others know who's joining the trip. A short intro video works just fine",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 200,
                                height: 200,
                                color: Colors.grey.shade400,
                                child:
                                    video != null &&
                                        _controller != null &&
                                        _controller!.value.isInitialized
                                    ? VideoPlayer(_controller!)
                                    : const Center(
                                        child: Icon(Icons.videocam, size: 50),
                                      ),
                              ),
                            ),
                            const VideoPickerButton(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (video != null && video.existsSync()) {
                                    newUser['intro_video'] = video.path;
                                    ref.read(videoFileProvider.notifier).clear();
                                    context.push('/signup5');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: myColors.backgound,
                                        content: const Text(
                                          'Please add an intro video',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Next',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.arrow_forward_rounded, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () => context.push('/login'),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
