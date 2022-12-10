import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final XFile video;
  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVideoPlayerController();
  }

  void initializeVideoPlayerController() async {
    videoPlayerController = VideoPlayerController.file(File(widget.video.path));
    await videoPlayerController!.initialize();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    if(videoPlayerController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return VideoPlayer(videoPlayerController!);
  }
}
