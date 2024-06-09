import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_schedule_reminder/utils/dimensions.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.green],
                ),
              ),
              child: Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: Colors.white, 
                  size: Dimensions.width20 * 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
