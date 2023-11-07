import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';

class Customloading extends StatelessWidget {
  const Customloading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Center(
        child: AnimatedTextKit(
          pause: const Duration(milliseconds: 100),
          totalRepeatCount: 300,
          animatedTexts: [
            TyperAnimatedText('${Singleton.instance.languages.value.wait}',
                speed: const Duration(milliseconds: 1000),
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
