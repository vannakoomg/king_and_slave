import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animation_aba/modules/game/controller/game_controller.dart';
import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/game_model.dart';

class GameScreen extends StatefulWidget {
  final String id;
  final int you;
  const GameScreen({super.key, required this.id, required this.you});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final controller = Get.put(Controller());

  @override
  void initState() {
    controller.type.value = widget.you;
    controller.roomId.value = widget.id.toString();
    controller.onPlaying();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    controller.setDefault(w, h, widget.you);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: StreamBuilder<RoomModel>(
            stream: FirebaseFirestore.instance
                .collection('room')
                .doc(widget.id)
                .snapshots()
                .map((json) => RoomModel.fromJson(json.data()!)),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                if (snapshots.data!.slave!.index == -2) {
                  controller.showLoading.value = true;
                } else {
                  controller.showLoading.value = false;
                }
                if (snapshots.data!.slave!.index == -1 &&
                    snapshots.data!.king!.index == -1) {
                  controller.letStart.value = true;
                  Future.delayed(const Duration(milliseconds: 5500), () {
                    controller.letStart.value = false;
                    controller.isStart.value = true;
                    controller.isShowTime.value = true;
                  });
                }
                if (snapshots.data!.slave!.index! >= 0 ||
                    snapshots.data!.king!.index! >= 0) {
                  if (snapshots.data!.slave!.length ==
                      snapshots.data!.king!.length) {
                    Future.delayed(const Duration(milliseconds: 2000), () {
                      controller.endGame(snapshots.data!.id!);
                    });
                  }
                  if (controller.type.value == 0) {
                    if (snapshots.data!.slave!.turn == true) {
                      controller.enmey(
                        snapshots.data!.slave!.index!,
                        snapshots.data!.slave!.card!,
                      );
                    }
                  } else {
                    if (snapshots.data!.king!.turn == true) {
                      controller.enmey(snapshots.data!.king!.index!,
                          snapshots.data!.king!.card!);
                    }
                  }
                }

                return Obx(() => Stack(
                      children: [
                        SizedBox(
                          width: w,
                          child: Stack(
                            children: [
                              Stack(
                                  children: controller.listEnemyCard
                                      .asMap()
                                      .entries
                                      .map((e) {
                                return AnimatedPositioned(
                                  curve: Curves.easeInQuad,
                                  duration: Duration(
                                      milliseconds:
                                          controller.onTapEnemy.value == false
                                              ? 500
                                              : 0),
                                  top: controller.positionEnemyCard[e.key].y,
                                  left: controller.positionEnemyCard[e.key].x,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    height: 0.2 * w + 0.2 * w / 3,
                                    width: 0.2 * w,
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      "${Singleton.instance.back}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }).toList()),
                              if (controller.showEnemy.value)
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 500),
                                  top: controller.newPostionEnmey.value.y,
                                  left: controller.newPostionEnmey.value.x,
                                  child: TweenAnimationBuilder(
                                    tween: Tween<double>(
                                        begin: 0, end: controller.rotate.value),
                                    curve: Curves.fastOutSlowIn,
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    builder:
                                        (BuildContext context, double val, _) {
                                      if (val >= (3.14 / 2)) {
                                        controller.openEnemy.value = true;
                                      } else {
                                        controller.openEnemy.value = false;
                                      }
                                      return Transform(
                                          transform: Matrix4.identity()
                                            ..rotateY(val),
                                          alignment: Alignment.center,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 5, left: 5),
                                            height: 0.2 * w + 0.2 * w / 3,
                                            width: 0.2 * w,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      blurRadius: 50,
                                                      spreadRadius: 1,
                                                      offset:
                                                          const Offset(0, 3))
                                                ],
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                  controller.openEnemy.value
                                                      ? "${controller.enemyCard.value.image}"
                                                      : "${Singleton.instance.back}",
                                                )),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ));
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: w,
                          child: Stack(
                            children: [
                              Stack(
                                  children: controller.listYourCard
                                      .asMap()
                                      .entries
                                      .map((e) {
                                return AnimatedPositioned(
                                  duration: Duration(
                                      milliseconds: controller.istouchCard.value
                                          ? 0
                                          : 500),
                                  bottom: controller.positionYourCard[e.key].y,
                                  left: controller.positionYourCard[e.key].x,
                                  child: GestureDetector(
                                    onVerticalDragEnd: (value) {
                                      controller.onVerticalDragEnd(e.key);
                                    },
                                    onVerticalDragStart: (value) {
                                      controller.onVerticalDragStart(e.key);
                                    },
                                    onVerticalDragUpdate: (value) {
                                      controller.onVerticalDragUpdate(
                                          Postion(
                                              x: controller
                                                  .positionYourCard[e.key].x,
                                              y: controller
                                                  .positionYourCard[e.key].y),
                                          Postion(
                                            x: value.globalPosition.dx -
                                                (0.2 * w / 2),
                                            y: h - value.globalPosition.dy,
                                          ),
                                          e.key);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      height: 0.2 * w + 0.2 * w / 3,
                                      width: 0.2 * w,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                blurRadius: 50,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 3))
                                          ],
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "${controller.listYourCard[e.key].image}"),
                                              fit: BoxFit.fitHeight),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                );
                              }).toList()),
                              if (controller.istouchCard.value == true)
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 0),
                                  bottom: controller.newPostion.value.y,
                                  left: controller.newPostion.value.x,
                                  child: GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      height: 0.2 * w + 0.2 * w / 3,
                                      width: 0.2 * w,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                blurRadius: 50,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 3))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: AssetImage(controller
                                                  .yourCard.value.image!),
                                              fit: BoxFit.fitHeight)),
                                    ),
                                  ),
                                ),
                              if (controller.isPlaying.value)
                                Positioned(
                                  bottom: controller.newPostion.value.y,
                                  left: controller.newPostion.value.x,
                                  child: GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      height: 0.2 * w + 0.2 * w / 3,
                                      width: 0.2 * w,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              blurRadius: 50,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 3))
                                        ],
                                        image: DecorationImage(
                                            image: AssetImage(controller
                                                .yourCard.value.image!)),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        controller.showLoading.value == true
                            ? Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LoadingAnimationWidget.staggeredDotsWave(
                                          color: Colors.white, size: 32),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "waiting",
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
                                        child: LoadingAnimationWidget
                                            .staggeredDotsWave(
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                          left: controller.sword.value ? -40 : -155,
                          top: h / 2 - 30,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/sword/2.png"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            height: 60,
                            width: 240,
                            child: Row(children: [
                              GestureDetector(
                                onTap: () {
                                  controller.ontapSword();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 40),
                                  width: 140,
                                  height: 60,
                                  color: Colors.transparent,
                                  child: Center(
                                      child: Text(
                                    controller.letStart.value
                                        ? "Sarender"
                                        : "Next",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.sword.value =
                                      !controller.sword.value;
                                },
                                child: Container(
                                  width: 80,
                                  height: 50,
                                  color: Colors.transparent,
                                ),
                              )
                            ]),
                          ),
                        ),
                        if (controller.letStart.value == true)
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Center(
                              child: AnimatedTextKit(
                                pause: const Duration(milliseconds: 100),
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  ScaleAnimatedText('3',
                                      duration:
                                          const Duration(milliseconds: 1200),
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w500)),
                                  ScaleAnimatedText('2',
                                      duration:
                                          const Duration(milliseconds: 1200),
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w500)),
                                  ScaleAnimatedText('1',
                                      duration:
                                          const Duration(milliseconds: 1200),
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w500)),
                                  ColorizeAnimatedText('GO!',
                                      speed: const Duration(milliseconds: 1500),
                                      textStyle: const TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.w500),
                                      colors: [
                                        Colors.white,
                                        Colors.blue,
                                        Colors.yellow,
                                        Colors.red,
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        if (controller.isShowTime.value)
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 4,
                                width: MediaQuery.of(context).size.width *
                                            controller.time.value /
                                            120 <
                                        0
                                    ? 0
                                    : MediaQuery.of(context).size.width *
                                        controller.time.value /
                                        120,
                                color: Colors.pink,
                              ))
                      ],
                    ));
              } else {
                return Center(
                  child: Container(
                      color: Colors.red, child: const Text("No Room")),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
