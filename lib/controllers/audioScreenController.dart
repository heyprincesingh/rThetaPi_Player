import 'dart:io';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class audioScreenController extends GetxController {
  RxList<String> audiosList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAudioList();
  }

  Future<void> loadAudioList() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      Directory dir = Directory('/storage/emulated/0/');
      List<FileSystemEntity> _files = await dir.list().toList();

      for (FileSystemEntity entity in _files) {
        if (entity is File && entity.path.endsWith('.mp3')) {
          audiosList.add(entity.path);
        }
      }
      print(audiosList);
    } else {
      print('Permission denied');
    }
  }
}
