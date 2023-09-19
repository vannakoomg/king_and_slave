import 'package:animation_aba/modules/settings/controller/settings_controller.dart';
import 'package:animation_aba/utils/controller/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final controller = Get.put(SettingController());

  @override
  void initState() {
    controller.setImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Obx(
      () => SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 5),
          color: Colors.white,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.tapSalve();
                    },
                    child: Container(
                      height: w / 7 + w / 7 / 3,
                      width: w / 7,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: controller.isTapSoldier.value
                              ? Border.all(color: Colors.pink, width: 2)
                              : null),
                      child: Image.asset(
                        Singleton.instance.soldier.value,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                      width: w / 7 * 2 + 20,
                      child: Wrap(
                          children: controller.soldier.asMap().entries.map(
                        (e) {
                          return GestureDetector(
                            onTap: () async {
                              final SharedPreferences obj =
                                  await SharedPreferences.getInstance();
                              controller.soldier.removeAt(e.key);
                              controller.soldier.insert(
                                  e.key, Singleton.instance.soldier.value);
                              Singleton.instance.soldier.value = e.value;
                              obj.setString(
                                  "soldier", Singleton.instance.soldier.value);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              height: w / 7 + w / 7 / 2,
                              width: w / 7,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: controller.isTapSalve.value
                                      ? Border.all(
                                          color: Colors.pink, width: 0.5)
                                      : null),
                              child: Image.asset(
                                e.value,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ).toList())),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
