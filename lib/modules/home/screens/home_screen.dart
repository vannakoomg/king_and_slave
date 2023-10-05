import 'package:animation_aba/modules/game/screens/room_screen.dart';
import 'package:animation_aba/modules/home/controller/home_controller.dart';
import 'package:animation_aba/modules/settings/screens/setting_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());

  @override
  void initState() {
    initBannerAd();
    debugPrint("ddd'");
    super.initState();
  }

  BannerAd? bannerad;
  var adUnit = "ca-app-pub-3940256099942544/6300978111";

  initBannerAd() {
    setState(() {
      bannerad = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: adUnit,
        listener: BannerAdListener(
          onAdLoaded: (value) {
            controller.isShowAdMob.value = false;
            debugPrint("khmer sl khmer ");
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            debugPrint(" error44444 $error");
          },
        ),
        request: const AdRequest(),
      );
      bannerad!.load();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            const Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.pink,
                            ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.black,
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
                // if (controller.isShowAdMob.value)
                //   bannerad == null
                //       ? Container(
                //           height: 40,
                //           width: 40,
                //           color: Colors.red,
                //         )
                //       : Container(
                //           color: Colors.red,
                //           width: double.infinity,
                //           child: AdWidget(
                //             ad: bannerad!,
                //           ),
                //         )
              ],
            )),
      ),
    );
  }
}
