import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/settings/controller/settings_controller.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({super.key});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  final controller = Get.put(SettingController());

  @override
  void initState() {
    controller.imageShow.value = '';
    controller.setImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "${Singleton.instance.languages.value.customize}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 0, right: 5),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.imageShow.value =
                                  Singleton.instance.king.value;
                            },
                            child: Container(
                              height: w / 7 + w / 7 / 2,
                              width: w / 7,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.8),
                                      blurRadius: 50,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 3))
                                ],
                              ),
                              child: SvgPicture.asset(
                                Singleton.instance.king.value,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                              width: w / 7 * 2 + 20,
                              child: Wrap(
                                  children: controller.king.asMap().entries.map(
                                (e) {
                                  return GestureDetector(
                                    onTap: () async {
                                      final SharedPreferences obj =
                                          await SharedPreferences.getInstance();
                                      controller.king.removeAt(e.key);
                                      controller.king.insert(
                                          e.key, Singleton.instance.king.value);
                                      Singleton.instance.king.value = e.value;
                                      obj.setString("king",
                                          Singleton.instance.king.value);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      height: w / 7 + w / 7 / 2,
                                      width: w / 7,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: SvgPicture.asset(
                                        e.value,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              ).toList())),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.imageShow.value =
                                  Singleton.instance.soldier.value;
                            },
                            child: Container(
                              height: w / 7 + w / 7 / 2,
                              width: w / 7,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.8),
                                      blurRadius: 50,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 3))
                                ],
                                color: Colors.transparent,
                              ),
                              child: SvgPicture.asset(
                                Singleton.instance.soldier.value,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                              width: w / 7 * 2 + 20,
                              child: Wrap(
                                  children:
                                      controller.soldier.asMap().entries.map(
                                (e) {
                                  return GestureDetector(
                                    onTap: () async {
                                      final SharedPreferences obj =
                                          await SharedPreferences.getInstance();
                                      controller.soldier.removeAt(e.key);
                                      controller.soldier.insert(e.key,
                                          Singleton.instance.soldier.value);
                                      Singleton.instance.soldier.value =
                                          e.value;
                                      debugPrint(
                                          Singleton.instance.soldier.value);
                                      obj.setString("soldier",
                                          Singleton.instance.soldier.value);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      height: w / 7 + w / 7 / 2,
                                      width: w / 7,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: SvgPicture.asset(
                                        e.value,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              ).toList())),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.imageShow.value =
                                  Singleton.instance.slave.value;
                            },
                            child: Container(
                              height: w / 7 + w / 7 / 2,
                              width: w / 7,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.8),
                                      blurRadius: 50,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 3))
                                ],
                              ),
                              child: SvgPicture.asset(
                                Singleton.instance.slave.value,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                              width: w / 7 * 2 + 20,
                              child: Wrap(
                                  children:
                                      controller.slave.asMap().entries.map(
                                (e) {
                                  return GestureDetector(
                                    onTap: () async {
                                      final SharedPreferences obj =
                                          await SharedPreferences.getInstance();
                                      controller.slave.removeAt(e.key);
                                      controller.slave.insert(e.key,
                                          Singleton.instance.slave.value);
                                      Singleton.instance.slave.value = e.value;
                                      obj.setString("slave",
                                          Singleton.instance.slave.value);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      height: w / 7 + w / 7 / 2,
                                      width: w / 7,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: SvgPicture.asset(
                                        e.value,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              ).toList())),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 70,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.imageShow.value =
                                  Singleton.instance.back.value;
                            },
                            child: Container(
                              height: w / 7 + w / 7 / 2,
                              width: w / 7,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.9),
                                      blurRadius: 50,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 3))
                                ],
                              ),
                              child: SvgPicture.asset(
                                Singleton.instance.back.value,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                              width: w / 7 * 2 + 20,
                              child: Wrap(
                                  children: controller.back.asMap().entries.map(
                                (e) {
                                  return GestureDetector(
                                    onTap: () async {
                                      final SharedPreferences obj =
                                          await SharedPreferences.getInstance();
                                      controller.back.removeAt(e.key);
                                      controller.back.insert(
                                          e.key, Singleton.instance.back.value);
                                      Singleton.instance.back.value = e.value;
                                      obj.setString("back",
                                          Singleton.instance.back.value);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      height: w / 7 + w / 7 / 2,
                                      width: w / 7,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: SvgPicture.asset(
                                        e.value,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              ).toList())),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              if (controller.imageShow.value != '')
                GestureDetector(
                  onTap: () {
                    controller.imageShow.value = '';
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.9),
                    child: Center(
                      child: SvgPicture.asset(
                        controller.imageShow.value,
                        height: MediaQuery.of(context).size.width * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ));
  }
}
