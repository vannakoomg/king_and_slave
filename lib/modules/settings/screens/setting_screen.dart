import 'package:animation_aba/modules/settings/controller/settings_controller.dart';
import 'package:animation_aba/modules/settings/screens/customize_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/models/landuage_model.dart';
import '../../game/screens/room_style.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              if (controller.isShowLaw.value)
                GestureDetector(
                  onTap: () {
                    controller.ontapBackLaw();
                  },
                  child: Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    // margin: const EdgeInsets.only(bottom: 40),
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 60, bottom: 20),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${Singleton.instance.languages.value.law}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                                '''${Singleton.instance.languages.value.lawDetail}''',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 18)),
                            const SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              "assets/setting/appsara.svg",
                              height: 150,
                            ),
                          ]),
                    ),
                  ),
                ),
              if (controller.isShowSetting.value)
                SafeArea(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease,
                    opacity: controller.issetting.value ? 1 : 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: Colors.black,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width / (3 / 2.5),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 30,
                                    color: Colors.pink,
                                  ),
                                ),
                                Text(
                                  "${Singleton.instance.languages.value.setting}",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const CustomizeScreen());
                                  },
                                  child: CustomPaint(
                                    size: Size(
                                        MediaQuery.of(context).size.width, 20),
                                    painter: RoomStyle(),
                                    child: SizedBox(
                                      // padding: const EdgeInsets.only(left: 30, right: 30),
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          Singleton.instance.languages.value
                                              .customize!,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.ontapLaw();
                                  },
                                  child: CustomPaint(
                                    size: Size(
                                        MediaQuery.of(context).size.width, 20),
                                    painter: RoomStyle(),
                                    child: SizedBox(
                                      // padding: const EdgeInsets.only(left: 30, right: 30),
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          Singleton
                                              .instance.languages.value.law!,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomPaint(
                                  size: Size(
                                      MediaQuery.of(context).size.width, 20),
                                  painter: RoomStyle(),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 20),
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Singleton
                                              .instance.languages.value.sound!,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 15,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.music_note,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final SharedPreferences obj =
                                        await SharedPreferences.getInstance();
                                    if (Singleton.instance.lang.value == 'kh') {
                                      Singleton.instance.lang.value = "en";
                                      obj.setString("language", "en");
                                    } else {
                                      Singleton.instance.lang.value = "kh";
                                      obj.setString("language", "kh");
                                    }
                                    debugPrint(Singleton.instance.lang.value);
                                    FirebaseFirestore.instance
                                        .collection("languages")
                                        .doc(Singleton.instance.lang.value)
                                        .get()
                                        .then((value) {
                                      Singleton.instance.languages.value =
                                          LanguagesModel.fromJson(
                                              value.data()!);
                                    });
                                  },
                                  child: CustomPaint(
                                    size: Size(
                                        MediaQuery.of(context).size.width, 20),
                                    painter: RoomStyle(),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Singleton.instance.languages.value
                                                .language!,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            Singleton.instance.lang.value ==
                                                    "kh"
                                                ? "assets/setting/1.png"
                                                : "assets/setting/2.png",
                                            height: 25,
                                            width: 25,
                                          )
                                        ],
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
                  ),
                ),
            ],
          ),
        ));
  }
}
