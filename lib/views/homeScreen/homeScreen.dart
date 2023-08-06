import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rthetapi_player/views/audioScreen/audioScreen.dart';
import 'package:rthetapi_player/controllers/homeScreenController.dart';
import 'package:rthetapi_player/views/videoScreen/videoListScreen.dart';
import 'package:rthetapi_player/views/videoScreen/videoScreen.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.white10,
            title: Text("RthethaPi Player"),
          ),
          body: Column(
            children: [
              const TabBar(indicatorColor: Colors.white, tabs: [
                Tab(
                  icon: Icon(Icons.video_collection_outlined),
                  text: "Videos",
                ),
                Tab(
                  icon: Icon(Icons.library_music_outlined),
                  text: "Music",
                ),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    videoListScreen(),
                    audioScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
