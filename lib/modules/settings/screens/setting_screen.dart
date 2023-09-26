import 'package:animation_aba/modules/settings/controller/settings_controller.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            "ការកំណត់",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        body: Obx(
          () => SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 5),
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
                              GestureDetector(
                                onTap: () {
                                  controller.tapKing();
                                },
                                child: Container(
                                  height: w / 7 + w / 7 / 2,
                                  width: w / 7,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: controller.isTapKing.value
                                        ? Border.all(
                                            color: Colors.pink, width: 2)
                                        : null,
                                  ),
                                  child: Image.asset(
                                    Singleton.instance.king.value,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: w / 7 * 2 + 20,
                                  child: Wrap(
                                      children:
                                          controller.king.asMap().entries.map(
                                    (e) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final SharedPreferences obj =
                                              await SharedPreferences
                                                  .getInstance();
                                          controller.king.removeAt(e.key);
                                          controller.king.insert(e.key,
                                              Singleton.instance.king.value);
                                          Singleton.instance.king.value =
                                              e.value;
                                          obj.setString("king",
                                              Singleton.instance.king.value);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          height: w / 7 + w / 7 / 2,
                                          width: w / 7,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: controller.isTapKing.value
                                                  ? Border.all(
                                                      color: Colors.pink,
                                                      width: 0.5)
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tapSoldier();
                                },
                                child: Container(
                                  height: w / 7 + w / 7 / 2,
                                  width: w / 7,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: controller.isTapSoldier.value
                                        ? Border.all(
                                            color: Colors.pink, width: 0.5)
                                        : null,
                                  ),
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
                                      children: controller.soldier
                                          .asMap()
                                          .entries
                                          .map(
                                    (e) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final SharedPreferences obj =
                                              await SharedPreferences
                                                  .getInstance();
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
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border:
                                                  controller.isTapSoldier.value
                                                      ? Border.all(
                                                          color: Colors.pink,
                                                          width: 0.5)
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
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tapSalve();
                                },
                                child: Container(
                                  height: w / 7 + w / 7 / 2,
                                  width: w / 7,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: controller.isTapSalve.value
                                        ? Border.all(
                                            color: Colors.pink, width: 2)
                                        : null,
                                  ),
                                  child: Image.asset(
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
                                              await SharedPreferences
                                                  .getInstance();
                                          controller.slave.removeAt(e.key);
                                          controller.slave.insert(e.key,
                                              Singleton.instance.slave.value);
                                          Singleton.instance.slave.value =
                                              e.value;
                                          obj.setString("slave",
                                              Singleton.instance.slave.value);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          height: w / 7 + w / 7 / 2,
                                          width: w / 7,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border:
                                                  controller.isTapSalve.value
                                                      ? Border.all(
                                                          color: Colors.pink,
                                                          width: 0.5)
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
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tapKing();
                                },
                                child: Container(
                                  height: w / 7 + w / 7 / 2,
                                  width: w / 7,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: controller.isTapBack.value
                                        ? Border.all(
                                            color: Colors.pink, width: 2)
                                        : null,
                                  ),
                                  child: Image.asset(
                                    Singleton.instance.back.value,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: w / 7 * 2 + 20,
                                  child: Wrap(
                                      children:
                                          controller.back.asMap().entries.map(
                                    (e) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final SharedPreferences obj =
                                              await SharedPreferences
                                                  .getInstance();
                                          controller.back.removeAt(e.key);
                                          controller.back.insert(e.key,
                                              Singleton.instance.back.value);
                                          Singleton.instance.back.value =
                                              e.value;
                                          obj.setString("back",
                                              Singleton.instance.back.value);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          height: w / 7 + w / 7 / 2,
                                          width: w / 7,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: controller.isTapBack.value
                                                  ? Border.all(
                                                      color: Colors.pink,
                                                      width: 0.5)
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
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tapKing();
                                },
                                child: Container(
                                  height: w / 7 + w / 7 / 2,
                                  width: w / 7,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: controller.isTapKing.value
                                        ? Border.all(
                                            color: Colors.pink, width: 2)
                                        : null,
                                  ),
                                  child: Image.asset(
                                    Singleton.instance.king.value,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: w / 7 * 2 + 20,
                                  child: Wrap(
                                      children:
                                          controller.king.asMap().entries.map(
                                    (e) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final SharedPreferences obj =
                                              await SharedPreferences
                                                  .getInstance();
                                          controller.king.removeAt(e.key);
                                          controller.king.insert(e.key,
                                              Singleton.instance.king.value);
                                          Singleton.instance.king.value =
                                              e.value;
                                          obj.setString("soldier",
                                              Singleton.instance.king.value);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          height: w / 7 + w / 7 / 2,
                                          width: w / 7,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: controller.isTapKing.value
                                                  ? Border.all(
                                                      color: Colors.pink,
                                                      width: 0.5)
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
                ),
              ],
            ),
          ),
        ));
  }
}
