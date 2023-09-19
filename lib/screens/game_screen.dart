import 'dart:ffi';

import 'package:animation_aba/controllers/game_controller.dart';
import 'package:animation_aba/utils/controller/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/game_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var yourType = Get.arguments;
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    controller.setDefault(w, h, yourType);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Obx(() => SafeArea(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/map/1.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    child: Column(children: [
                      Expanded(
                          child: Container(
                        width: w,
                        color: Colors.blue,
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
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
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
                                  duration: const Duration(milliseconds: 1500),
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
                                          color: Colors.transparent,
                                          child: Image.asset(
                                            controller.openEnemy.value
                                                ? ""
                                                : "${Singleton.instance.back}",
                                            fit: BoxFit.fill,
                                          ),
                                        ));
                                  },
                                ),
                              ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Container(
                        width: w,
                        color: Colors.red,
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
                                        controller.istouchCard.value ? 0 : 500),
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
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      "${controller.listYourCard[e.key].image}",
                                      fit: BoxFit.fill,
                                    ),
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
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      controller.yourCard.value.image!,
                                      fit: BoxFit.fill,
                                    ),
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
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      controller.yourCard.value.image!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )),
                    ]),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                    left: controller.sword.value ? 0 : -100,
                    top: h / 2 - 22.5,
                    child: SizedBox(
                      height: 45,
                      width: 150,
                      child: Row(children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 100,
                            height: 45,
                            color: Colors.red,
                            child: const Center(child: Text("Sarender")),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.sword.value = !controller.sword.value;
                          },
                          child: Container(
                            width: 50,
                            height: 45,
                            color: const Color.fromRGBO(76, 175, 80, 1),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: const Text("Enemy "),
                          onPressed: () {
                            controller.enmey(2);
                          },
                        ),
                        ElevatedButton(
                          child: const Text("start "),
                          onPressed: () {
                            controller.fifhting();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
