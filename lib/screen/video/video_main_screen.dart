import 'package:flutter/material.dart';
import 'package:hello_world/screen/video/video_player_screen.dart';
import 'package:image_picker/image_picker.dart';

class VideoHomeScreen extends StatefulWidget {
  const VideoHomeScreen({Key? key}) : super(key: key);

  @override
  State<VideoHomeScreen> createState() => _VideoHomeScreenState();
}

class _VideoHomeScreenState extends State<VideoHomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video != null ? renderVideo() : renderEmpty(),
    );
  }

  Widget renderEmpty() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A3A7C),
            Color(0xFF000118),
          ],
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(onTap: onLogoTap),
            SizedBox(height: 30),
            _AppName()
          ],
        ),
      ),
    );
  }

  Widget renderVideo() {
    return Center(
      child: VideoPlayerScreen(video: video!, onNewVideoPressed: onLogoTap,)
    );
  }

  void onLogoTap() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
          'asset/image/logo.png',
      ),
    );
  }
}


class _AppName extends StatelessWidget {
  final TextStyle textStyle = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );

  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text('PLAYER', style: textStyle.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
