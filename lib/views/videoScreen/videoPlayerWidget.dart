import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';

class videoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const videoPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: controller != null && controller.value.isInitialized
          ? Container(
              child: buildVideo(),
            )
          : Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildVideo() => Stack(
        children: [
          buildVideoPlayer(),
          Positioned.fill(child: basicOverlayWidget(controller: controller))
        ],
      );

  Widget buildVideoPlayer() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.value.isPlaying ? controller.pause() : controller.play();
        },
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
}

bool deviceOrientation = true;

class basicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  basicOverlayWidget({super.key, required this.controller});

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Icon(
                      size: 60,
                      controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: controller.value.isPlaying
                          ? Color.fromARGB(0, 0, 0, 0)
                          : Colors.white,
                    ),
                  ),
                  Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 60,
                    color: controller.value.isPlaying
                        ? Color.fromARGB(0, 0, 0, 0)
                        : Color.fromARGB(255, 40, 40, 40),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 60,
            child: GestureDetector(
              onTap: () {
                controller.setVolume(controller.value.volume > 0 ? 0 : 1);
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Icon(
                      controller.value.volume > 0
                          ? Icons.volume_up
                          : Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    controller.value.volume > 0
                        ? Icons.volume_up
                        : Icons.volume_off,
                    color: Color.fromARGB(255, 40, 40, 40),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              formatDuration(controller.value.duration),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 3,
                    color: Color.fromARGB(125, 255, 255, 255),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                deviceOrientation
                    ? AutoOrientation.landscapeAutoMode(forceSensor: true)
                    : AutoOrientation.portraitAutoMode(forceSensor: true);
                deviceOrientation = !deviceOrientation;
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.fullscreen,
                    color: Color.fromARGB(255, 40, 40, 40),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: buildIndicator(),
          )
        ],
      );

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );
}
