import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerLoop extends StatefulWidget {
  final String url;
  const VideoPlayerLoop({required this.url});

  @override
  State<VideoPlayerLoop> createState() => _VideoPlayerLoopState();
}

class _VideoPlayerLoopState extends State<VideoPlayerLoop> {
  VideoPlayerController? _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    while (mounted) {
      try {
        _controller?.dispose();
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
        await _controller!.initialize();
        _controller!.setLooping(true);
        _controller!.play();
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
        break; // Success, exit loop
      } catch (e) {
        await Future.delayed(const Duration(seconds: 2));
        // Try again
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _controller == null || !_controller!.value.isInitialized) {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blueGrey.shade100,
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blueGrey.shade100,
        ),
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}
