import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animation_aba/controllers/home_controller.dart';
import 'package:animation_aba/modules/settings/screens/setting_screen.dart';
import 'package:animation_aba/screens/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio/just_audio.dart';

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
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background/1.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Get.to(() => const GameScreen(),
                                      arguments: 0);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              )),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => const GameScreen(),
                                        arguments: 1);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              )
                            ],
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                            left: controller.sword01.value ? 0 : -70,
                            top: 160,
                            child: SizedBox(
                              height: 50,
                              width: 120,
                              child: Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.introduction.value = true;
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 50,
                                    color: Colors.red,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.sword11();
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.green,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                            left: controller.sword02.value ? 0 : -70,
                            top: 220,
                            child: SizedBox(
                              height: 50,
                              width: 120,
                              child: Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const SettingScreen());
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 50,
                                    color: Colors.red,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller.sword22();
                                    final player = AudioPlayer();
                                    Duration? playyy = await player
                                        .setUrl("assets/audios/1.mp3");
                                    // player
                                    //     .play(); // Play without waiting for completion
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.green,
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(const SettingScreen());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 170,
                        color: Colors.transparent,
                      ),
                    )
                  ]),
                ),
                if (controller.introduction.value)
                  GestureDetector(
                    onTap: () {
                      controller.introduction.value = false;
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.transparent,
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width +
                                  MediaQuery.of(context).size.width / 3,
                              width: 900,
                              margin: const EdgeInsets.only(bottom: 40),
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 80),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/background/massage.png",
                                      ),
                                      fit: BoxFit.fill)),
                              child: Stack(
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: AnimatedTextKit(
                                              pause: const Duration(
                                                  milliseconds: 1),
                                              animatedTexts: [
                                                TyperAnimatedText('''
                  យើងៗម្មាក់អាចជ្រើសរើសចង់ក្លាចជាស្ដេចរឺទារសដោយចិត្តអែង 
                  អង្គទាសករ​​​ មាន ទាហាន ៤​នាក់ ទាសករ ១នាក់
                  អង្គស្ដេច​​​​​​ មាន​​​​​​ ទាហាន ៤នាក់​ ស្ដេច ១នាក់
                  សន្លឹកបៀរទាំងអស់ត្រូវបានតម្រៀបដោយចៃដន្យ
                  --- ការលេង ---
                  ១​​​​​​​ សន្លឹកបៀរស្ដេច​​ឈ្មះសន្លឹកបៀរ​​ទាហាន
                  ២ សន្លឹកបៀរទាហានឈ្នះសន្លឹកបៀរទាសករ
                  ៣ សន្លឹកបៀរទាសករឈ្នះសន្លឹកបៀរស្ដេច
                  ៤ សន្លឹកបៀរដូចគ្នាស្មើរគ្នា
                  ក្នុងការចោរសន្លឹកបៀរក្មុងមួយសន្លឹកមានរយះពេល ២​នាទី​ បើមិនបានចោរស្មើនឹងចាញ់''',
                                                    textStyle: const TextStyle(
                                                        fontSize: 16)),
                                              ],
                                              isRepeatingAnimation: false,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: IconButton(
                                onPressed: () {
                                  controller.introduction.value = false;
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }
}
