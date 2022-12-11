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

  final int initMoveTime = 3;
  bool isPlay = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVideoPlayerController();
  }

  void initializeVideoPlayerController() async {
    videoPlayerController = VideoPlayerController.file(File(widget.video.path));
    await videoPlayerController!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController!),
            _Controls(
              onReversePressed: onReversePressed,
              onPlayPressed: onPlayPressed,
              onForwardPressed: onForwardPressed,
              isPlay: isPlay,
            ),
            Positioned(
                right: 0,
                child: IconButton(
                    onPressed: () {},
                    icon: const IconButton(
                      icon: Icon(
                        Icons.photo_camera_back,
                        color: Colors.white,
                      ),
                      onPressed: null,
                      iconSize: 30.0,
                    )))
          ],
        ));
  }

  void onReversePressed() {
    final Duration currentPosition = videoPlayerController!.value.position;

    Duration position = const Duration(seconds: 0);

    if (currentPosition.inSeconds > initMoveTime) {
      position = currentPosition - Duration(seconds: initMoveTime);
    }

    videoPlayerController!.seekTo(position);
  }

  void onPlayPressed() {
    // 이미 실행중이면 중지
    // 실행중이 아니면 실행
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }

    setState(() {
      isPlay = videoPlayerController!.value.isPlaying;
    });
  }

  void onForwardPressed() {
    final Duration maxPosition = videoPlayerController!.value.duration;
    final Duration currentPosition = videoPlayerController!.value.position;

    Duration position = maxPosition;

    if(maxPosition > (currentPosition + Duration(seconds: initMoveTime))){
      position = (currentPosition + Duration(seconds: initMoveTime));
    }

    videoPlayerController!.seekTo(position);
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlay;

  const _Controls(
      {Key? key,
      required this.onPlayPressed,
      required this.onReversePressed,
      required this.onForwardPressed,
      required this.isPlay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          renderIconButton(
              icon: Icons.rotate_left, onPressed: onReversePressed),
          renderIconButton(icon: !isPlay ? Icons.play_arrow : Icons.pause, onPressed: onPlayPressed),
          renderIconButton(
              icon: Icons.rotate_right, onPressed: onForwardPressed),
        ],
      ),
    );
  }

  Widget renderIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
        onPressed: onPressed,
        icon: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 30,
          color: Colors.white,
        ));
  }
}
