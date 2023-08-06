import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rthetapi_player/controllers/splashScreenController.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(splashScreenController());

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png",height: 150,width: 150,),
          SizedBox(height: 20,),
          const Text(
            "rThetaPi Player",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}
