// ignore_for_file: unnecessary_null_comparison

import 'package:animation_aba/screens/home_screen.dart';
import 'package:animation_aba/utils/controller/image.dart';
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
      await obj.setString('king', "assets/king/1.png");
      await obj.setString('slave', "assets/slave/1.png");
      await obj.setString('soldier', "assets/soldier/1.png");
      await obj.setString('map', "assets/map/1.png");
      await obj.setString('back', "assets/back/1.png");
      Singleton.instance.back.value = obj.getString('back')!;
      Singleton.instance.map.value = obj.getString('map')!;
      Singleton.instance.king.value = obj.getString('king')!;
      Singleton.instance.soldier.value = obj.getString('soldier')!;
      Singleton.instance.slave.value = obj.getString('slave')!;
    } else {
      Singleton.instance.back.value = obj.getString('back')!;
      Singleton.instance.map.value = obj.getString('map')!;
      Singleton.instance.king.value = obj.getString('king')!;
      Singleton.instance.soldier.value = obj.getString('soldier')!;
      Singleton.instance.slave.value = obj.getString('slave')!;
    }
    Get.to(const HomeScreen());
  }

  @override
  void initState() {
    getiamge();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("aaaaaa"),
      ),
    );
  }
}
