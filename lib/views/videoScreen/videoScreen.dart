import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:rthetapi_player/views/videoScreen/videoPlayerWidget.dart';

class videoPlayer extends StatefulWidget {
  final File file;
  videoPlayer({super.key, required this.file});

  @override
  State<videoPlayer> createState() => _videoPlayerState();
}

class _videoPlayerState extends State<videoPlayer> {

  final File filee = File('storage/emulated/0/Movies/Instagram/VID_257790108_183858_901.mp4');

  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.file)
    ..addListener(()=> setState(() {}))
    ..setLooping(true)
    ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    AutoOrientation.portraitAutoMode(forceSensor: true);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 0, 0, 0),
      body: videoPlayerWidget(
        controller: controller,
      ),
    );
  }
}