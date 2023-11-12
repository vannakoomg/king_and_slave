import 'dart:math';

import 'package:animation_aba/modules/bot/screen/bot_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final introduction = false.obs;
  final isSetting = false.obs;
  final isShowAdMob = false.obs;
  final isFirst = false.obs;
  final isshowLaw = false.obs;

  void checkIsFirst() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.getString('first') == null) {
      isFirst.value = true;
    } else {
      isFirst.value = false;
    }
  }

  void agress() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();
    obj.setString('first', "s");
    isshowLaw.value = false;
    Get.to(() => const BotScreen(you: 0));
  }

  void getiamge() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.getString('king') == null) {
      await obj.setString('king', "assets/king/${Random().nextInt(5) + 1}.svg");
      await obj.setString(
          'slave', "assets/slave/${Random().nextInt(5) + 1}.svg");
      await obj.setString(
          'soldier', "assets/soldier/${Random().nextInt(5) + 1}.svg");
      await obj.setString('back', "assets/back/${Random().nextInt(5) + 1}.svg");
      Singleton.instance.back.value = obj.getString('back')!;
      Singleton.instance.king.value = obj.getString('king')!;
      Singleton.instance.soldier.value = obj.getString('soldier')!;
      Singleton.instance.slave.value = obj.getString('slave')!;
    } else {
      Singleton.instance.back.value = obj.getString('back')!;
      Singleton.instance.king.value = obj.getString('king')!;
      Singleton.instance.soldier.value = obj.getString('soldier')!;
      Singleton.instance.slave.value = obj.getString('slave')!;
      Singleton.instance.avatar.value = obj.getString('avatar')!;
      debugPrint(
          "Singleton.instance.avatar.value ${Singleton.instance.avatar.value}");
      Singleton.instance.nickName.value = obj.getString('nickName')!;
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
      }
    }
  }

  final time = 0.obs;
  final index = 2.obs;
  final imagePrifile = [
    "assets/profile/1.svg",
    "assets/profile/2.svg",
    "assets/profile/3.svg",
    "assets/profile/4.svg",
    "assets/profile/5.svg",
  ].obs;
  final imageEdit = [];
  final oldimage = ''.obs;
  void selecteProfile(int i) async {
    index.value = i;
  }

  final editPrifile = ''.obs;
  void seletedProfileEdit(int i) {
    oldimage.value = editPrifile.value;
    editPrifile.value = imageEdit[i];
    imageEdit[i] = oldimage.value;
  }

  final page = 0.obs;
  final profileimage = ''.obs;
  void onTap() async {
    if (page.value == 0) {
      page.value = 1;
    } else {
      final SharedPreferences obj = await SharedPreferences.getInstance();
      obj.setString('avatar', imagePrifile[index.value]);
      obj.setString('nickName', userName.value.trim());
      obj.setString('first', "s");
      Singleton.instance.nickName.value = userName.value.trim();
      Singleton.instance.avatar.value = imagePrifile[index.value];
      isshowLaw.value = true;
      isFirst.value = false;
    }
  }

  void edit() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();
    obj.setString('avatar', editPrifile.value);
    obj.setString('name', userName.value.trim());
    Singleton.instance.nickName.value = userName.value.trim();
    Singleton.instance.avatar.value = editPrifile.value;
    Get.back();
  }

  final pageController = PageController().obs;
  final userNameController = TextEditingController().obs;
  final userName = ''.obs;
}
