import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomChat extends StatelessWidget {
  final double h;
  final double w;
  final bool isEnemyMessage;
  final bool isYourMessage;
  final String enemyMessage;
  final String yourMessage;
  final String enemyAvatar;

  const CustomChat({
    super.key,
    required this.h,
    required this.w,
    this.isEnemyMessage = false,
    this.isYourMessage = false,
    required this.enemyMessage,
    required this.yourMessage,
    this.enemyAvatar = '',
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: h / 2 - 80,
            left: 5,
            child: SizedBox(
              height: 60,
              width: w,
              child: Row(children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SvgPicture.asset(enemyAvatar)),
                ),
                if (isEnemyMessage == true && enemyMessage != '')
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      enemyMessage,
                      overflow: TextOverflow.clip,
                    )),
                  )
              ]),
            )),
        Positioned(
            bottom: h / 2 - 80,
            right: 5,
            child: SizedBox(
              height: 60,
              width: w,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                if (isYourMessage == true && yourMessage != '')
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    margin: const EdgeInsets.only(bottom: 20, right: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      yourMessage,
                      overflow: TextOverflow.clip,
                    )),
                  ),
                Container(
                    clipBehavior: Clip.antiAlias,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle,
                        color: Colors.white),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                            SvgPicture.asset(Singleton.instance.avatar.value))),
              ]),
            ))
      ],
    );
  }
}
