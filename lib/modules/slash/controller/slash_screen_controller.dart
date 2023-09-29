import 'package:animation_aba/modules/home/screens/home_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlashScreenController extends GetxController {
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
      // Get.to(const HomeScreen());
    }
  }

  final time = 0.obs;

  double sadow() {
    if (time.value == 7) return -35;
    if (time.value == 8) return -30;
    if (time.value == 9) return -25;
    if (time.value == 10) return -20;
    if (time.value == 11) return -15;
    if (time.value == 13) return 10;
    if (time.value == 14) return 20;
    if (time.value == 15) return 25;
    if (time.value == 16) return 30;
    if (time.value == 17) return 35;
    if (time.value == 13) return 40;
    return 0;
  }

  Color night() {
    if (time.value < 7 || time.value >= 19) return Colors.black;
    if (time.value >= 7 && time.value < 19) return Colors.white;
    return Colors.red;
  }

  Color sadowColor() {
    if (time.value < 7 || time.value >= 19) {
      return Colors.white.withOpacity(0.7);
    }
    if (time.value >= 7 && time.value < 19) {
      return Colors.black.withOpacity(0.7);
    }
    return Colors.red;
  }
}
