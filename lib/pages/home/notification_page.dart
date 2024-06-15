import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        // ignore: unnecessary_this
        title: Text(
          this.label.toString().split("|")[0],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          width: Dimensions.width10 * 30,
          height: Dimensions.height20 * 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            color: Colors.grey[400],
          ),
          child: Center(
            child: Text(
              // this split to get note task form notification pyload
              // ignore: unnecessary_this
              this.label.toString().split("|")[1],
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
