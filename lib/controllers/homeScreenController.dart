import 'package:get/get.dart';
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

class homeScreenController extends GetxController {
  RxList videosList = [].obs;
  var videoDetails = [].obs;
  var thumbnailList = [].obs;
  final videoInfo = FlutterVideoInfo();

  @override
  void onInit() {
    super.onInit();
    if (videosList.isEmpty) loadVideoList();
  }

  loadVideoList() async {
    FetchAllVideos ob = FetchAllVideos();
    List videos = await ob.getAllVideos();
    videosList.value = videos;

    videosList.forEach(
      (video) async{
        var temp = await videoInfo.getVideoInfo(video);
        var tempDetail = [
          temp!.title,
          // temp.duration,
          temp.filesize
        ];
        videoDetails.add(tempDetail);
      },
    );
  }
}
