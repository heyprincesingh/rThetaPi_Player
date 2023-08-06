import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class audioPlayerWidget extends StatefulWidget {
  final File file;
  const audioPlayerWidget({super.key, required this.file});

  @override
  State<audioPlayerWidget> createState() => _audioPlayerWidgetState();
}

class _audioPlayerWidgetState extends State<audioPlayerWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setSourceDeviceFile(widget.file.path);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          onChanged: (value) async {
            final position = Duration(seconds: value.toInt());
            await audioPlayer.seek(position);

            await audioPlayer.resume();
          },
        ),
        Row(
          children: [
            Text("${position}"),
            Text("${duration - position}"),
          ],
        ),
        CircleAvatar(
          radius: 35,
          child: IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            iconSize: 50,
            onPressed: () async {
              if (isPlaying)
                await audioPlayer.pause();
              else
                await audioPlayer.resume();
            },
          ),
        )
      ],
    );
  }
}
