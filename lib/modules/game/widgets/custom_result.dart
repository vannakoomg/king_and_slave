import 'dart:math';

import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomResult extends StatelessWidget {
  final String status;
  final String roomId;
  final Function ontap;
  const CustomResult(
      {super.key,
      required this.status,
      required this.roomId,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.2),
        child: Center(
            child: Stack(
          children: [
            Center(
              child: Container(
                height: 1,
                width: 1,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: status == "lose" || status == "you_surrender"
                          ? const Color.fromARGB(255, 245, 68, 45)
                              .withOpacity(0.5)
                          : status == "enemy_surrender" || status == "win"
                              ? const Color.fromARGB(255, 235, 99, 145)
                              : const Color.fromARGB(255, 220, 202, 202)
                                  .withOpacity(0.5),
                      spreadRadius: 100,
                      blurRadius: 100,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    status == "enemy_surrender"
                        ? "${Singleton.instance.languages.value.enemySerrender}"
                        : status == "you_surrender"
                            ? "${Singleton.instance.languages.value.youSurrender}"
                            : status == "win"
                                ? "${Singleton.instance.languages.value.youWin}"
                                : status == "lose"
                                    ? "${Singleton.instance.languages.value.youLose}"
                                    : "${Singleton.instance.languages.value.weEqual}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  SvgPicture.asset(
                    status == "lose" || status == "you_surrender"
                        ? "assets/lose/${Random().nextInt(4) + 1}.svg"
                        : status == "enemy_surrender" || status == "win"
                            ? "assets/win/${Random().nextInt(4) + 1}.svg"
                            : "assets/equal/${Random().nextInt(3) + 1}.svg",
                    height: 130,
                    width: 130,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 17, 17, 16)
                          .withOpacity(0.9),
                      spreadRadius: 100,
                      blurRadius: 30,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 17, 17, 16)
                          .withOpacity(0.9),
                      spreadRadius: 90,
                      blurRadius: 30,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            if (status != "equal")
              Positioned(
                bottom: 10,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CustomBotton(
                        h: 35,
                        title: "${Singleton.instance.languages.value.next}",
                        ontap: () {
                          ontap();
                        },
                        isdisble: false,
                      ),
                    )),
              )
          ],
        )));
  }
}
