import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/feedback/screen/feedback_screen.dart';
import 'package:animation_aba/modules/settings/controller/settings_controller.dart';
import 'package:animation_aba/modules/settings/screens/appbar.dart';
import 'package:animation_aba/modules/settings/screens/customize_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../game/screens/room_style.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CustomPaint(
                        painter: RPSCustomPainter(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: 35,
                                    )),
                                Text(
                                  "${Singleton.instance.languages.value.setting}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.78),
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: AppColor.primary,
                                      size: 35,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width / (3 / 2.5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.ontapLaw();
                                },
                                child: CustomPaint(
                                  size: Size(
                                      MediaQuery.of(context).size.width, 20),
                                  painter: SettingStyle(),
                                  child: SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        Singleton.instance.languages.value.law!,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.isloadinglanguage.value ==
                                      false) {
                                    Get.to(() => const CustomizeScreen());
                                  }
                                },
                                child: CustomPaint(
                                  size: Size(
                                      MediaQuery.of(context).size.width, 20),
                                  painter: SettingStyle(),
                                  child: SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        Singleton.instance.languages.value
                                            .customize!,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  controller.fetchLanguage();
                                },
                                child: CustomPaint(
                                  size: Size(
                                      MediaQuery.of(context).size.width, 20),
                                  painter: SettingStyle(),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    height: 40,
                                    child: controller.isloadinglanguage.value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              LoadingAnimationWidget
                                                  .staggeredDotsWave(
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Singleton.instance.languages
                                                    .value.language!,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: SvgPicture.asset(
                                                  Singleton.instance.lang
                                                              .value ==
                                                          "kh"
                                                      ? "assets/setting/1.svg"
                                                      : "assets/setting/2.svg",
                                                  height: 18,
                                                  width: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Get.to(() => const FeedBackScreen());
                                },
                                child: CustomPaint(
                                  size: Size(
                                      MediaQuery.of(context).size.width, 20),
                                  painter: SettingStyle(),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        Singleton
                                            .instance.languages.value.feedback!,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
              if (controller.isShowLaw.value)
                GestureDetector(
                  onTap: () {
                    controller.ontapBackLaw();
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: controller.isanimatedlaw.value ? 1 : 0,
                    curve: Curves.easeIn,
                    child: Container(
                      color: Colors.black.withOpacity(0.9),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 60, bottom: 20),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${Singleton.instance.languages.value.law}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  Singleton.instance.languages.value.lawDetail!
                                      .replaceAll(r'\n', '\n'),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 18)),
                              const SizedBox(
                                height: 20,
                              ),
                              SvgPicture.asset(
                                "assets/setting/appsara.svg",
                                height: 130,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
