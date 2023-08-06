import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rthetapi_player/controllers/audioScreenController.dart';
import 'package:rthetapi_player/views/audioScreen/audioPlayerWidget.dart';

class audioScreen extends StatelessWidget {
  const audioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(audioScreenController());
    return Obx(
      () => controller.audiosList.isEmpty
          ? Center(
              child: Text(
              "Loading audios...",
              style: TextStyle(color: Colors.white),
            ))
          : ListView.builder(
              itemCount: controller.audiosList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: ()=> Get.to(audioPlayerWidget(file: File(controller.audiosList[i]),)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => {},

                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                  const Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Icon(Icons.play_circle_fill_outlined,
                                        color: Colors.white),
                                  ),
                                  Text(controller.audiosList[i],
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
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
