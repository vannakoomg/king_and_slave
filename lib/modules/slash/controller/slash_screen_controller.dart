// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:animation_aba/modules/home/screens/home_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlashScreenController extends GetxController {
  final isFirst = false.obs;
  void getiamge() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.getString('king') == null) {
      await obj.setString('king', "assets/king/${Random().nextInt(3) + 1}.svg");
      await obj.setString(
          'slave', "assets/slave/${Random().nextInt(3) + 1}.svg");
      await obj.setString(
          'soldier', "assets/soldier/${Random().nextInt(3) + 1}.svg");
      await obj.setString('back', "assets/back/1.png");
      Singleton.instance.back.value = obj.getString('back')!;
      Singleton.instance.king.value = obj.getString('king')!;
      Singleton.instance.soldier.value = obj.getString('soldier')!;
      Singleton.instance.slave.value = obj.getString('slave')!;
    } else {
      Singleton.instance.back.value = obj.getString('back')!;
      Singleton.instance.king.value = obj.getString('king')!;
      Singleton.instance.soldier.value = obj.getString('soldier')!;
      Singleton.instance.slave.value = obj.getString('slave')!;
    }
    if (obj.getString('first') == null) {
      isFirst.value = true;
    } else {
      isFirst.value = false;
    }
  }

  Future<String> setupLanguages() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.getString('language') == null) {
      await obj.setString('language', 'kh');
      Singleton.instance.lang.value = obj.getString("language")!;
      return "kh";
    } else {
      Singleton.instance.lang.value = obj.getString("language")!;
      return obj.getString("language")!;
    }
  }

  Future setLife() async {
    debugPrint("life life ");
    final SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.getInt('life') == null) {
      await obj.setInt('life', 5);
      await obj.setString(
          'date', DateFormat('yyyy-MM-dd').format(DateTime.now()));
      Singleton.instance.life.value = 5;
    } else {
      debugPrint(
          "life = ${obj.getString("date")} ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
      if (obj.getString("date") ==
          DateFormat('yyyy-MM-dd').format(DateTime.now())) {
        Singleton.instance.life.value = obj.getInt("life")!;
        debugPrint("the same  ${Singleton.instance.life.value}");
      } else {
        Singleton.instance.life.value = 5;
        await obj.setString(
            'date', DateFormat('yyyy-MM-dd').format(DateTime.now()));
        await obj.setInt('life', 5);
        debugPrint(
            "uuuuuuuuu ${Singleton.instance.life.value} ${obj.getInt('life')} ${obj.getString('date')}");
      }
    }
  }

  final time = 0.obs;
}
