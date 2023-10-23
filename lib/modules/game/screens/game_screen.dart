import 'package:animation_aba/modules/game/controller/game_controller.dart';
import 'package:animation_aba/modules/game/controller/room_controller.dart';
import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/modules/game/widgets/count_time.dart';
import 'package:animation_aba/modules/game/widgets/custom_result.dart';
import 'package:animation_aba/modules/game/widgets/letstart.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
  final roomController = Get.put(RoomController());
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    controller.type.value = widget.you;
    controller.roomId.value = widget.id.toString();
    controller.checkTime();
    controller.loadInterstitialAd();
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
                controller.listionGamePaly(snapshots.data!);
                return Obx(() => GestureDetector(
                      onTap: () {
                        controller.isShowAdMob.value = true;
                      },
                      child: Stack(
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
                                      child: SvgPicture.asset(
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
                                          begin: 0,
                                          end: controller.rotate.value),
                                      curve: Curves.fastOutSlowIn,
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (BuildContext context,
                                          double val, _) {
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
                                              ),
                                              child: controller.openEnemy.value
                                                  ? SvgPicture.asset(
                                                      "${controller.enemyCard.value.image}",
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                  : SvgPicture.asset(
                                                      "${Singleton.instance.back}",
                                                      fit: BoxFit.fitHeight,
                                                    ),
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
                                          : 500,
                                    ),
                                    bottom:
                                        controller.positionYourCard[e.key].y,
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
                                            right: 4, left: 4),
                                        height: 0.2 * w + 0.2 * w / 3,
                                        width: 0.2 * w,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.white.withOpacity(0),
                                                blurRadius: 50,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 3))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: SvgPicture.asset(
                                            "${controller.listYourCard[e.key].image}",
                                            fit: BoxFit.fill),
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
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                            controller.yourCard.value.image!,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                if (controller.isPlaying.value)
                                  Positioned(
                                    bottom: controller.newPostion.value.y,
                                    left: controller.newPostion.value.x,
                                    child: GestureDetector(
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        padding: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        height: 0.2 * w + 0.2 * w / 3,
                                        width: 0.2 * w,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                blurRadius: 50,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 3))
                                          ],
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                            controller.yourCard.value.image!,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // controller.showLoading.value == true
                          //     ? const Customloading()
                          //     : const SizedBox(),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                            left: controller.sword.value ? -40 : -125,
                            top: h / 2 - 30,
                            child: SizedBox(
                              height: 40,
                              width: 180,
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    "assets/sword/1.svg",
                                    height: 50,
                                    width: 140,
                                  ),
                                  Row(children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.ontapSword02();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 40, top: 0),
                                        width: 120,
                                        height: 60,
                                        color: Colors.transparent,
                                        child: Center(
                                            child: Text(
                                          controller.gamePlay.value
                                              ? "${Singleton.instance.languages.value.surrender}"
                                              : "${Singleton.instance.languages.value.next}",
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        )),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.ontapSword01();
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 50,
                                        color: Colors.transparent,
                                      ),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          if (controller.letStart.value == true)
                            const LetStart(),
                          if (controller.isShowTime.value)
                            CountTimte(time: controller.time.value),
                          if (controller.status.value != "")
                            CustomResult(
                              status: controller.status.value,
                              roomId: controller.roomId.value,
                              ontap: () {
                                final play = FirebaseFirestore.instance
                                    .collection('room')
                                    .doc(controller.roomId.value);
                                controller.interstitialAd!
                                    .show()
                                    .then((value) => {
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            Get.back();
                                          })
                                        });
                                if (controller.status.value ==
                                    "enemy_surrender") {
                                  play.delete();
                                }
                              },
                            ),
                        ],
                      ),
                    ));
              } else {
                return controller.status.value == ''
                    ? const SizedBox()
                    : const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
