import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animation_aba/modules/game/screens/room_screen.dart';
import 'package:animation_aba/modules/home/controller/home_controller.dart';
import 'package:animation_aba/modules/settings/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      // image: DecorationImage(
                      //   image: AssetImage("assets/background/1.png"),
                      //   fit: BoxFit.fitHeight,
                      // ),
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
                                  controller.sword01.value = false;
                                  controller.sword02.value = false;
                                  Get.to(
                                    () => const RoomScreen(),
                                    arguments: 0,
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              )),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.sword01.value = false;
                                    controller.sword02.value = false;
                                    Get.to(
                                      () => const RoomScreen(),
                                      arguments: 1,
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              )
                            ],
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 2000),
                            curve: Curves.easeOutCirc,
                            left: controller.sword01.value ? -30 : -135,
                            top: 160,
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/sword/1.png'),
                                    fit: BoxFit.fitWidth),
                              ),
                              child: Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.sword01.value = false;
                                    controller.sword02.value = false;
                                    controller.introduction.value = true;
                                  },
                                  child: Container(
                                    width: 125,
                                    height: 50,
                                    color: Colors.transparent,
                                    child: const Center(
                                        child: Text(
                                      "khmer",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.sword11();
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 50,
                                    color: Colors.transparent,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeOutCirc,
                            left: controller.sword02.value ? -30 : -135,
                            top: 100,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/sword/2.png'))),
                              height: 50,
                              width: 200,
                              child: Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.sword01.value = false;
                                    controller.sword02.value = false;
                                    Get.to(const SettingScreen());
                                  },
                                  child: Container(
                                    width: 125,
                                    height: 50,
                                    color: Colors.transparent,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller.sword22();
                                    // final player = AudioPlayer();
                                    // Duration? playyy = await player
                                    //     .setUrl("assets/audios/1.mp3");
                                    // player
                                    //     .play(); // Play without waiting for completion
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 50,
                                    color: Colors.transparent,
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      color: Colors.black.withOpacity(0.94),
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 0.9 +
                                  MediaQuery.of(context).size.width / 9 / 2,
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: const EdgeInsets.only(bottom: 40),
                              padding: const EdgeInsets.only(
                                  left: 30, right: 20, top: 60, bottom: 20),
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
                                                    textStyle: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.9),
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
                              top: 10,
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
