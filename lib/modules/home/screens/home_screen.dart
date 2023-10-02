import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animation_aba/modules/game/screens/room_screen.dart';
import 'package:animation_aba/modules/game/screens/room_style.dart';
import 'package:animation_aba/modules/home/controller/home_controller.dart';
import 'package:animation_aba/modules/home/screens/favorite.dart';
import 'package:animation_aba/modules/settings/screens/customize_screen.dart';
import 'package:animation_aba/modules/settings/screens/setting_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/models/landuage_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Obx(() => Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(children: [
                    Expanded(
                      child: Stack(children: [
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () async {
                                Get.to(() => const RoomScreen(), arguments: 0);
                              },
                              child: Container(
                                color: Colors.black,
                              ),
                            )),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const RoomScreen(),
                                    arguments: 1,
                                  );
                                },
                                child: Container(
                                  color: Colors.pink,
                                ),
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ]),
                ),
                Positioned(
                    top: MediaQuery.of(context).padding.top + 20,
                    left: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                        children: [
                          for (int i = 0;
                              i < Singleton.instance.life.value;
                              ++i)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: CustomPaint(
                                size: Size(30, (30).toDouble()),
                                painter: RPSCustomPainter(),
                              ),
                            ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Get.to(const SettingScreen(),
                                  transition: Transition.noTransition);
                              // controller.isSetting.value = true;
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    )),
                if (controller.isSetting.value) const SettingScreen(),
              ],
            )),
      ),
    );
  }
}
