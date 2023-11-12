import 'dart:math';

import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/bot/model/bot_controller.dart';
import 'package:animation_aba/modules/bot/screen/bot_screen.dart';
import 'package:animation_aba/modules/game/screens/room_screen.dart';
import 'package:animation_aba/modules/home/controller/home_controller.dart';
import 'package:animation_aba/modules/home/screens/create_profile.dart';
import 'package:animation_aba/modules/home/screens/edit_profile.dart';
import 'package:animation_aba/modules/settings/controller/settings_controller.dart';
import 'package:animation_aba/modules/settings/screens/setting_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/models/language_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());
  final botControler = BotController();
  final settingController = Get.put(SettingController());
  @override
  void initState() {
    Singleton.instance.bot.value = "assets/chat/${Random().nextInt(4) + 1}.svg";
    controller.setLife();
    controller.checkIsFirst();
    controller.setupLanguages().then((value) => {
          FirebaseFirestore.instance
              .collection("languages")
              .doc(value)
              .get()
              .then((value) async {
            Singleton.instance.languages.value =
                LanguagesModel.fromJson(value.data()!);
            controller.getiamge();
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Obx(
          () => Stack(
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
                              color: AppColor.primary,
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/background/king.svg",
                                  height:
                                      (MediaQuery.of(context).size.width / 2) *
                                          0.8,
                                  width:
                                      (MediaQuery.of(context).size.width / 2) *
                                          0.8,
                                ),
                              ),
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
                                color: Colors.black,
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/background/slave.svg",
                                    height: (MediaQuery.of(context).size.width /
                                            2) *
                                        0.8,
                                    width: (MediaQuery.of(context).size.width /
                                            2) *
                                        0.8,
                                  ),
                                ),
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
                  top: MediaQuery.of(context).padding.top,
                  left: 10,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.editPrifile.value =
                                Singleton.instance.avatar.value;
                            debugPrint("");
                            controller.imageEdit.clear();
                            controller.imageEdit
                                .addAll(controller.imagePrifile);
                            controller.imageEdit
                                .remove(controller.editPrifile.value);
                            Get.to(const EditProfileScreen(),
                                transition: Transition.noTransition);
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            width: 45,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SvgPicture.asset(
                                Singleton.instance.avatar.value,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                for (int i = 0;
                                    i < Singleton.instance.life.value;
                                    ++i)
                                  const Icon(
                                    Icons.favorite,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                              ],
                            ),
                            Text(
                              Singleton.instance.nickName.value,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              Positioned(
                top: 5,
                right: 10,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 0,
                          width: 0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.primary,
                                    blurRadius: 190,
                                    spreadRadius: 45)
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30, left: 30),
                          child: IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () {
                              Get.to(() => const SettingScreen(),
                                  transition: Transition.noTransition);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isshowLaw.value)
                GestureDetector(
                  onTap: () {
                    controller.agress();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.95),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 20),
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.black.withOpacity(0.9),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 40, bottom: 10),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "${Singleton.instance.languages.value.law}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      Singleton
                                          .instance.languages.value.lawDetail!
                                          .replaceAll(r'\n', '\n'),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 17.5)),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 40,
                          bottom: 20,
                          child: GestureDetector(
                            onTap: () async {
                              settingController.fetchLanguage();
                            },
                            child: SvgPicture.asset(
                              "assets/setting/appsara.svg",
                              height: 110,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (controller.isFirst.value &&
                  Singleton.instance.languages.value.next != null)
                const ProfielScreen(),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const BotScreen(
                            you: 0,
                          ));
                    },
                    child: SvgPicture.asset(
                      Singleton.instance.bot.value,
                      height: 60,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
