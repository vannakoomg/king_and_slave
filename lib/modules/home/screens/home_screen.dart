import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/game/screens/room_screen.dart';
import 'package:animation_aba/modules/home/controller/home_controller.dart';
import 'package:animation_aba/modules/home/widgets/custom_setting.dart';
import 'package:animation_aba/modules/settings/screens/setting_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/models/language_model.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
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
  @override
  void initState() {
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
            debugPrint("iiiii${Singleton.instance.languages}");
            Future.delayed(const Duration(milliseconds: 50), () {
              controller.isshowLaw.value = true;
            });
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
                                width: (MediaQuery.of(context).size.width / 2) *
                                    0.8,
                              )),
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
                                  height:
                                      (MediaQuery.of(context).size.width / 2) *
                                          0.8,
                                  width:
                                      (MediaQuery.of(context).size.width / 2) *
                                          0.8,
                                )),
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
                    height: 50,
                    child: Row(
                      children: [
                        for (int i = 0; i < Singleton.instance.life.value; ++i)
                          const Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.black,
                          ),
                      ],
                    ),
                  )),
              Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CustomPaint(
                    size: const Size(100, 100),
                    painter: Customsetting(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20),
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          Get.to(() => const SettingScreen(),
                              transition: Transition.noTransition);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              if (Singleton.instance.languages.value.lawDetail != null &&
                  controller.isFirst.value)
                AnimatedOpacity(
                  curve: Curves.easeInOutCirc,
                  opacity: controller.isshowLaw.value ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    color: Colors.black.withOpacity(0.9),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: MediaQuery.of(context).padding.top + 60),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Text(
                          "${Singleton.instance.languages.value.law}",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            Singleton.instance.languages.value.lawDetail!
                                .replaceAll(r'\n', '\n'),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 20)),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBotton(
                            title: "${Singleton.instance.languages.value.ok}",
                            ontap: () async {
                              controller.agress();
                            },
                            isdisble: false)
                      ]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
