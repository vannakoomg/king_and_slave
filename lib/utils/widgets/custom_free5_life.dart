import 'package:animation_aba/modules/game/controller/room_controller.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFree5Life extends StatelessWidget {
  const CustomFree5Life({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoomController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${Singleton.instance.languages.value.tellTrueAnswer}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 1,
                color: Colors.white,
                width: double.infinity,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "${Singleton.instance.languages.value.question}",
                style: const TextStyle(color: Colors.white, fontSize: 32),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  final SharedPreferences obj =
                      await SharedPreferences.getInstance();
                  obj.setInt('life', 5);
                  Singleton.instance.life.value = 5;
                  controller.isNoMoreLife.value = false;
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                          color: controller.randomColors(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "${controller.randomNumber()}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                          color: controller.randomColors(),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "4",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
