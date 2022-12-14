import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  const VideoPlayerScreen(
      {super.key, required this.video, required this.onNewVideoPressed});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final int INIT_MOVE_TIME = 3;
  bool isControl = false;

  VideoPlayerController? videoPlayerController;
  Duration currentPosition = const Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    initializeVideoPlayerController();
  }

  @override
  void didUpdateWidget(covariant VideoPlayerScreen oldWidget) {
    if(widget.video.path != oldWidget.video.path) {
      currentPosition = Duration();
      initializeVideoPlayerController();
    }
  }

  void initializeVideoPlayerController() async {
    videoPlayerController = VideoPlayerController.file(File(widget.video.path));
    await videoPlayerController!.initialize();

    videoPlayerController!.addListener(() {
      final currentPosition = videoPlayerController!.value.position;
      setState(() {
        this.currentPosition = currentPosition;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        child: GestureDetector(
          onTap: () {
            setState(() {
              isControl = !isControl;
            });
          },
          child: Stack(
            children: [
              VideoPlayer(videoPlayerController!),
              if (isControl)
                _Controls(
                  onReversePressed: onReversePressed,
                  onPlayPressed: onPlayPressed,
                  onForwardPressed: onForwardPressed,
                  isPlay: videoPlayerController!.value.isPlaying,
                ),
              if (isControl) _NewVideo(onNewVideoPressed: widget.onNewVideoPressed,),
              _Slider(
                currentPosition: currentPosition,
                maxPosition: videoPlayerController!.value.duration,
                onChangeSlider: onChangeSlider,
              ),
            ],
          ),
        ));
  }

  void onReversePressed() {
    final Duration currentPosition = videoPlayerController!.value.position;

    Duration position = const Duration(seconds: 0);

    if (currentPosition.inSeconds > INIT_MOVE_TIME) {
      position = currentPosition - Duration(seconds: INIT_MOVE_TIME);
    }

    videoPlayerController!.seekTo(position);
  }

  void onPlayPressed() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause(); // ?????? ?????? ????????? ??????
    } else {
      videoPlayerController!.play(); // ?????? ?????? ????????? ??????
    }

    setState(() {});
  }

  void onForwardPressed() {
    final Duration maxPosition = videoPlayerController!.value.duration;
    final Duration currentPosition = videoPlayerController!.value.position;

    Duration position = maxPosition;

    if (maxPosition > (currentPosition + Duration(seconds: INIT_MOVE_TIME))) {
      position = (currentPosition + Duration(seconds: INIT_MOVE_TIME));
    }

    videoPlayerController!.seekTo(position);
  }

  void onChangeSlider(double value) {
    setState(() {
      videoPlayerController!.seekTo(Duration(seconds: value.toInt()));
    });
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
          renderIconButton(
              icon: !isPlay ? Icons.play_arrow : Icons.pause,
              onPressed: onPlayPressed),
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

class _NewVideo extends StatelessWidget {
  final VoidCallback onNewVideoPressed;

  const _NewVideo({Key? key, required this.onNewVideoPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        child: IconButton(
            onPressed: onNewVideoPressed,
            icon: const IconButton(
              icon: Icon(
                Icons.photo_camera_back,
                color: Colors.white,
              ),
              onPressed: null,
              iconSize: 30.0,
            )));
  }
}

class _Slider extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onChangeSlider;

  const _Slider(
      {Key? key,
      required this.currentPosition,
      required this.maxPosition,
      required this.onChangeSlider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Row(
        children: [
          Text(
            '${currentPosition.inMinutes.toString().padLeft(2, "0")} : ${currentPosition.inSeconds.toString().padLeft(2, "0")}',
            style: const TextStyle(color: Colors.white),
          ),
          Expanded(
            child: Slider(
                value: currentPosition.inSeconds.toDouble(),
                min: 0,
                max: maxPosition.inSeconds.toDouble(),
                onChanged: onChangeSlider),
          ),
          Text(
            '${maxPosition.inMinutes.toString().padLeft(2, "0")} : ${maxPosition.inSeconds.toString().padLeft(2, "0")}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
