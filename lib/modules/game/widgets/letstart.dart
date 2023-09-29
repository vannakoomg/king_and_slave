import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LetStart extends StatelessWidget {
  const LetStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Center(
        child: AnimatedTextKit(
          pause: const Duration(milliseconds: 10),
          totalRepeatCount: 1,
          animatedTexts: [
            ScaleAnimatedText('3',
                duration: const Duration(milliseconds: 1200),
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w500)),
            ScaleAnimatedText('2',
                duration: const Duration(milliseconds: 1200),
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w500)),
            ScaleAnimatedText('1',
                duration: const Duration(milliseconds: 1200),
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w500)),
            ColorizeAnimatedText('GO',
                speed: const Duration(milliseconds: 1500),
                textStyle:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                colors: [
                  const Color(0xffff99ac),
                  const Color(0xffff85a1),
                  const Color(0xffff5c8a),
                  const Color(0xffff0a54),
                  const Color(0xff8093f1),
                ]),
          ],
        ),
      ),
    );
  }
}
