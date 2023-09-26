// ignore_for_file: unnecessary_null_comparison

import 'package:animation_aba/modules/home/screens/home_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/models/landuage_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  void getiamge() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();

    if (obj.getString('king') == null) {
      debugPrint("not yet login ");
      await obj.setString('king', "assets/king/1.png");
      await obj.setString('slave', "assets/slave/1.png");
      await obj.setString('soldier', "assets/soldier/1.png");
      await obj.setString('map', "assets/map/1.png");
      await obj.setString('back', "assets/back/1.png");
      Singleton.instance.back.value = obj.getString('back')!;
      Singleton.instance.map.value = obj.getString('map')!;
      Singleton.instance.king.value = obj.getString('king')!;
      Singleton.instance.soldier.value = obj.getString('soldier')!;
      debugPrint(Singleton.instance.soldier.value);
      Singleton.instance.slave.value = obj.getString('slave')!;
      Get.to(const HomeScreen());
    } else {
      Singleton.instance.back.value = obj.getString('back')!;
      Singleton.instance.map.value = obj.getString('map')!;
      Singleton.instance.king.value = obj.getString('king')!;
      Singleton.instance.soldier.value = obj.getString('soldier')!;
      Singleton.instance.slave.value = obj.getString('slave')!;
      // debugPrint(Singleton.instance.soldier.value);
      Get.to(const HomeScreen());
    }
  }

  @override
  void initState() {
    getiamge();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("aaaaaa"),
            StreamBuilder<LanguageModel>(
                stream: FirebaseFirestore.instance
                    .collection('languages')
                    .doc("TGLjst4gP3SQdpiY33EH")
                    .snapshots()
                    .map((json) => LanguageModel.fromJson(json.data()!)),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    debugPrint("data come ${snapshots.data}");
                    Singleton.instance.languages = snapshots.data!;
                  }

                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
