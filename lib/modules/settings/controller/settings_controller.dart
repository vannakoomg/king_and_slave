import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final back = [
    "assets/back/1.png",
    "assets/back/2.png",
    "assets/back/3.png",
    "assets/back/4.png",
    "assets/back/5.png",
  ].obs;
  final map = [
    "assets/map/1.svg",
    "assets/map/1.svg",
    "assets/map/1.svg",
    "assets/map/1.svg",
  ].obs;
  final king = [
    "assets/king/1.svg",
    "assets/king/2.svg",
    "assets/king/3.svg",
    "assets/king/4.svg",
    "assets/king/5.svg",
  ].obs;
  final slave = [
    "assets/slave/1.svg",
    "assets/slave/2.svg",
    "assets/slave/3.svg",
    "assets/slave/4.svg",
    "assets/slave/5.svg",
  ].obs;
  final soldier = [
    "assets/soldier/1.svg",
    "assets/soldier/2.svg",
    "assets/soldier/3.svg",
    "assets/soldier/4.svg",
    "assets/soldier/5.svg",
    "assets/soldier/6.svg",
    "assets/soldier/7.svg",
  ].obs;
  final setting = [].obs;
  void setImage() {
    back.remove(Singleton.instance.back.value);
    king.remove(Singleton.instance.king.value);
    slave.remove(Singleton.instance.slave.value);
    soldier.remove(Singleton.instance.soldier.value);
  }

  final isLaw = false.obs;
  final issetting = true.obs;
  final isShowSetting = true.obs;
  final isShowLaw = false.obs;
  void ontapLaw() {
    issetting.value = false;
    isShowLaw.value = true;
    Future.delayed(const Duration(milliseconds: 1000), () {
      isShowSetting.value = false;
    });
  }

  void ontapBackLaw() {
    isLaw.value = false;
    isShowSetting.value = true;
    Future.delayed(const Duration(milliseconds: 50), () {
      issetting.value = true;
    });
  }
}
