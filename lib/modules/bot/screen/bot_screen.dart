// ignore_for_file: deprecated_member_use

import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/bot/model/bot_controller.dart';
import 'package:animation_aba/modules/game/models/game_model.dart';
import 'package:animation_aba/modules/game/screens/enemy_profile.dart';
import 'package:animation_aba/modules/game/widgets/custom_chat.dart';
import 'package:animation_aba/modules/game/widgets/custom_own_textfile.dart';
import 'package:animation_aba/modules/game/widgets/custom_result.dart';
import 'package:animation_aba/modules/game/widgets/letstart.dart';
import 'package:animation_aba/modules/home/controller/home_controller.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BotScreen extends StatefulWidget {
  final int you;
  final bool isFirst;
  const BotScreen({
    super.key,
    required this.you,
    required this.isFirst,
  });
  @override
  State<BotScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<BotScreen> {
  final controller = Get.put(BotController());
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    debugPrint("1111111111111${widget.isFirst}");
    Future.delayed(const Duration(milliseconds: 500), () {
      homeController.isshowLaw.value = false;
    });
    controller.showEnemy.value = false;
    controller.isPlaying.value = false;
    controller.status.value = "";
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    controller.type.value = widget.you;
    if (widget.isFirst == false) {
      controller.checkTime();
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    controller.setDefault(w, h, widget.you, widget.isFirst).then((value) {});
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Obx(() => GestureDetector(
                    onTap: () {
                      controller.isShowAdMob.value = true;
                    },
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: SizedBox(
                            height: h,
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
                                                  controller.onTapEnemy.value ==
                                                          false
                                                      ? 500
                                                      : 0),
                                          top: controller
                                              .positionEnemyCard[e.key].y,
                                          left: controller
                                              .positionEnemyCard[e.key].x,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 4, left: 4),
                                            height: 0.2 * w + 0.2 * w / 3,
                                            width: 0.2 * w,
                                            child: SvgPicture.asset(
                                              "${Singleton.instance.back}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      }).toList()),
                                      if (controller.showEnemy.value)
                                        AnimatedPositioned(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          top: controller
                                              .newPostionEnmey.value.y,
                                          left: controller
                                              .newPostionEnmey.value.x,
                                          child: TweenAnimationBuilder(
                                            tween: Tween<double>(
                                                begin: 0,
                                                end: controller.rotate.value),
                                            curve: Curves.fastOutSlowIn,
                                            duration: const Duration(
                                                milliseconds: 1500),
                                            builder: (BuildContext context,
                                                double val, _) {
                                              if (val >= (3.14 / 2)) {
                                                controller.openEnemy.value =
                                                    true;
                                              } else {
                                                controller.openEnemy.value =
                                                    false;
                                              }
                                              return Transform(
                                                  transform: Matrix4.identity()
                                                    ..rotateY(val),
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4, left: 4),
                                                    height:
                                                        0.2 * w + 0.2 * w / 3,
                                                    width: 0.2 * w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.8),
                                                            blurRadius: 50,
                                                            spreadRadius: 1,
                                                            offset:
                                                                const Offset(
                                                                    0, 3))
                                                      ],
                                                    ),
                                                    child: controller
                                                            .openEnemy.value
                                                        ? SvgPicture.asset(
                                                            "${controller.enemyCard.value.image}",
                                                            fit: BoxFit.fill,
                                                          )
                                                        : SvgPicture.asset(
                                                            "${Singleton.instance.back}",
                                                            fit: BoxFit.fill,
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
                                            milliseconds:
                                                controller.istouchCard.value
                                                    ? 0
                                                    : 500,
                                          ),
                                          bottom: controller
                                              .positionYourCard[e.key].y,
                                          left: controller
                                              .positionYourCard[e.key].x,
                                          child: GestureDetector(
                                            onVerticalDragEnd: (value) {
                                              controller.onVerticalDragEnd(
                                                  e.key, widget.isFirst);
                                            },
                                            onVerticalDragStart: (value) {
                                              controller
                                                  .onVerticalDragStart(e.key);
                                            },
                                            onVerticalDragUpdate: (value) {
                                              controller.onVerticalDragUpdate(
                                                  Postion(
                                                      x: controller
                                                          .positionYourCard[
                                                              e.key]
                                                          .x,
                                                      y: controller
                                                          .positionYourCard[
                                                              e.key]
                                                          .y),
                                                  Postion(
                                                    x: value.globalPosition.dx -
                                                        (0.2 * w / 2),
                                                    y: h -
                                                        value
                                                            .globalPosition.dy -
                                                        (0.2 * w / 2) +
                                                        20,
                                                  ),
                                                  e.key);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 4, left: 4),
                                              height: 0.2 * w + 0.2 * w / 3,
                                              width: 0.2 * w,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                  // border: Border.all(color: Colors.red),
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
                                          duration:
                                              const Duration(milliseconds: 0),
                                          bottom: controller.newPostion.value.y,
                                          left: controller.newPostion.value.x,
                                          child: GestureDetector(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 5, left: 5),
                                              height: 0.2 * w + 0.2 * w / 3,
                                              width: 0.2 * w,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                              child: SvgPicture.asset(
                                                  controller
                                                      .yourCard.value.image!,
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
                                                      offset:
                                                          const Offset(0, 3))
                                                ],
                                              ),
                                              child: SvgPicture.asset(
                                                  controller
                                                      .yourCard.value.image!,
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                controller.showLoading.value == true
                                    ? const Customloading()
                                    : const SizedBox(),
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                  left: controller.sword.value ? -40 : -120,
                                  top: h / 2 - 9,
                                  child: SizedBox(
                                    height: 40,
                                    width: 180,
                                    child: Stack(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/sword/1.svg",
                                          height: 60,
                                          width: 140,
                                        ),
                                        Row(children: [
                                          GestureDetector(
                                            onTap: () {
                                              homeController
                                                  .firstIntroduction();
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
                                                "${Singleton.instance.languages.value.surrender}",
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
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
                                if (controller.letStart.value == true &&
                                    controller.isStart.value == false)
                                  const LetStart(),
                                if (controller.isRedLine.value)
                                  Center(
                                    child: Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                controller.status.value != ""
                                    ? CustomResult(
                                        status: controller.status.value,
                                        roomId: controller.roomId.value,
                                        ontap: () async {
                                          debugPrint(
                                              "vsdfsdf${widget.isFirst}");
                                          if (widget.isFirst == true) {
                                            homeController.firstIntroduction();
                                          }
                                          if (homeController.isFirst.value) {
                                            controller.botMessage.value = "";
                                            final SharedPreferences obj =
                                                await SharedPreferences
                                                    .getInstance();
                                            obj.setString('first', "s");
                                            homeController.isFirst.value =
                                                false;
                                            homeController.isshowLaw.value =
                                                false;
                                            Get.back();
                                          } else {
                                            Get.back();
                                          }
                                          homeController.isshowLaw.value =
                                              false;
                                        },
                                      )
                                    : const SizedBox(),
                                if (controller.isEnemyProfile.value)
                                  EnemyPrifile(
                                    name: "I AM BOT",
                                    avatar: Singleton.instance.bot.value,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (controller.isChat.value)
                          GestureDetector(
                            onTap: () {
                              controller.isChat.value = false;
                            },
                            child: CustomOwnTextfile(
                              onSaveMessage: () {
                                controller.sendMessage();
                              },
                              onChange: (value) {
                                controller.chatText.value = value;
                              },
                            ),
                          )
                      ],
                    ),
                  )),
              Obx(() => Stack(
                    children: [
                      Text("${controller.isChat.value}"),
                      CustomChat(
                        isEnemyMessage: widget.isFirst
                            ? true
                            : controller.isEnemyMessage.value,
                        ontapChat: () {
                          controller.ontapChat();
                        },
                        ontap: () {
                          controller.isEnemyProfile.value =
                              !controller.isEnemyProfile.value;
                        },
                        enemyAvatar: Singleton.instance.bot.value,
                        enemyMessage: widget.isFirst
                            ? controller.botMessage.value
                            : controller.enemyMessage.value,
                        h: h,
                        w: w,
                        yourMessage: controller.yourMessage.value,
                      ),
                    ],
                  )),
              Obx(() => controller.isShowhand.value &&
                      controller.understand.value == false
                  ? AnimatedPositioned(
                      bottom: controller.handHigh.value,
                      left: w / 2 - 20,
                      duration: const Duration(milliseconds: 1000),
                      child: SvgPicture.asset(
                        "assets/chat/hand.svg",
                        height: 100,
                        width: 100,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
