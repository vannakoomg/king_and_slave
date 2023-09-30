import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Customloading extends StatelessWidget {
  const Customloading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white, size: 25),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${Singleton.instance.languages.value.wait}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              width: 10,
            ),
            AnimatedRotation(
              turns: 0.5,
              duration: const Duration(minutes: 0),
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
