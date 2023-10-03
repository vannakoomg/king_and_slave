import 'dart:math';

import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomResult extends StatefulWidget {
  final String status;
  final String roomId;
  const CustomResult({super.key, required this.status, required this.roomId});

  @override
  State<CustomResult> createState() => _CustomResultState();
}

int i = 0;

class _CustomResultState extends State<CustomResult> {
  @override
  Widget build(BuildContext context) {
    i++;
    debugPrint("khmer sl khmer ${widget.status} $i");
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
                      color: widget.status == "lose" ||
                              widget.status == "you_surrender"
                          ? const Color.fromARGB(255, 229, 50, 26)
                              .withOpacity(0.5)
                          : widget.status == "enemy_surrender" ||
                                  widget.status == "win"
                              ? const Color.fromARGB(255, 216, 43, 101)
                              : const Color.fromARGB(255, 220, 202, 202),
                      spreadRadius: 100,
                      blurRadius: 80,
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
                    widget.status == "enemy_surrender"
                        ? "${Singleton.instance.languages.value.enemySerrender}"
                        : widget.status == "you_surrender"
                            ? "${Singleton.instance.languages.value.youSurrender}"
                            : widget.status == "win"
                                ? "${Singleton.instance.languages.value.youWin}"
                                : widget.status == "lose"
                                    ? "${Singleton.instance.languages.value.youLose}"
                                    : "${Singleton.instance.languages.value.weEqual}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  SvgPicture.asset(
                    widget.status == "lose" || widget.status == "you_surrender"
                        ? "assets/lose/${Random().nextInt(4) + 1}.svg"
                        : widget.status == "enemy_surrender" ||
                                widget.status == "win"
                            ? "assets/win/${Random().nextInt(4) + 1}.svg"
                            : "assets/equal/${Random().nextInt(4) + 1}.svg",
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
                      blurRadius: 40,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            if (widget.status != "equal")
              Positioned(
                bottom: 10,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CustomBotton(
                          title: "${Singleton.instance.languages.value.next}",
                          ontap: () {
                            final play = FirebaseFirestore.instance
                                .collection('room')
                                .doc(widget.roomId);
                            if (widget.status == "enemy_surrender") {
                              Get.back();
                              play.delete();
                            } else {
                              Get.back();
                            }
                          },
                          isdisble: false),
                    )),
              )
          ],
        )));
  }
}
