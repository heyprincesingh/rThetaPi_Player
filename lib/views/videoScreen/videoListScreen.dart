import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rthetapi_player/controllers/homeScreenController.dart';
import 'package:rthetapi_player/views/videoScreen/videoScreen.dart';

class videoListScreen extends StatelessWidget {
  const videoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(homeScreenController());
    return Obx(
          () => controller.videosList.isEmpty
          ? Center(
          child: Text(
            "Loading videos...",
            style: TextStyle(color: Colors.white),
          ))
          : ListView.builder(
        itemCount: controller.videoDetails.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(videoPlayer(file: File(controller.videosList[i]))),

              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.play_circle_fill_outlined, color: Colors.white),
                          ),
                          Text(controller.videoDetails[i][0], style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Text("${(controller.videoDetails[i][1] / 1000000).toStringAsFixed(2)} MB", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}