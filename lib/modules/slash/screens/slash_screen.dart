import 'dart:math';

import 'package:animation_aba/modules/slash/controller/slash_screen_controller.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/models/landuage_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  final controller = Get.put(SlashScreenController());
  String image = 'assets/background/${Random().nextInt(5) + 1}.png';
  @override
  void initState() {
    controller.setLife();
    controller.setupLanguages().then((value) => {
          debugPrint("language : $value"),
          FirebaseFirestore.instance
              .collection("languages")
              .doc(value)
              .get()
              .then((value) {
            Singleton.instance.languages.value =
                LanguagesModel.fromJson(value.data()!);
            controller.getiamge();
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.time.value = DateTime.now().hour;
    return Scaffold(
      body: Center(
        child: Container(
          color: controller.night(),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: controller.sadowColor(),
                          blurRadius: 30,
                          spreadRadius: 6,
                          offset: Offset(controller.sadow(), 0))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(image),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
