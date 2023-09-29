// ignore_for_file: unnecessary_null_comparison

import 'dart:ffi';

import 'package:animation_aba/modules/home/screens/home_screen.dart';
import 'package:animation_aba/modules/slash/controller/slash_screen_controller.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/models/landuage_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  final controller = Get.put(SlashScreenController());
  @override
  void initState() {
    controller.getiamge();
    FirebaseFirestore.instance
        .collection("languages")
        .doc("kh")
        .get()
        .then((value) {
      Singleton.instance.languages.value =
          LanguageModel.fromJson(value.data()!);
      debugPrint("lane ${Singleton.instance.languages.value.password}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // controller.time.value = DateTime.now().hour;
    debugPrint(DateFormat('h:mm a').format(DateTime.now()));
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
                    image: const DecorationImage(
                      image: AssetImage("assets/background/1.png"),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
