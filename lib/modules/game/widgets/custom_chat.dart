import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/main.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomChat extends StatelessWidget {
  final double h;
  final double w;
  final String enemyMessage;
  final String yourMessage;
  final String enemyAvatar;
  final bool isEnemyMessage;
  final Function ontap;
  final Function ontapChat;

  const CustomChat({
    super.key,
    required this.h,
    required this.w,
    required this.enemyMessage,
    required this.yourMessage,
    required this.enemyAvatar,
    required this.ontap,
    required this.ontapChat,
    required this.isEnemyMessage,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: Stack(
        children: [
          Positioned(
              top: h / 2 - 100,
              left: 5,
              child: SizedBox(
                height: 60,
                width: w,
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      if (enemyAvatar != "") {
                        ontap();
                      }
                    },
                    child: Container(
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
                  ),
                  if (enemyMessage != '' && isEnemyMessage == true)
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 5, right: 10, bottom: 5, top: 5),
                          margin: const EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            enemyMessage,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )
                ]),
              )),
          Positioned(
              bottom: h / 2 - 100,
              right: 5,
              child: SizedBox(
                height: 90,
                width: w,
                child: Row(children: [
                  Expanded(
                    child: yourMessage != ''
                        ? Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              margin: const EdgeInsets.only(
                                  bottom: 40, right: 5, left: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                " $yourMessage",
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  Column(
                    children: [
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
                            child: SvgPicture.asset(
                                Singleton.instance.avatar.value),
                          )),
                      GestureDetector(
                        onTap: () {
                          ontapChat();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.transparent,
                          child: SvgPicture.asset(
                            "assets/chat/chat.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              ))
        ],
      ),
    );
  }
}
