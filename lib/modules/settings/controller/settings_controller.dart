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
    "assets/map/1.png",
    "assets/map/1.png",
    "assets/map/1.png",
    "assets/map/1.png",
  ].obs;
  final king = [
    "assets/king/1.png",
    "assets/king/2.png",
    "assets/king/3.png",
    "assets/king/4.png",
    "assets/king/5.png",
  ].obs;
  final slave = [
    "assets/slave/1.png",
    "assets/slave/2.png",
    "assets/slave/3.png",
    "assets/slave/4.png",
    "assets/slave/5.png",
  ].obs;
  final soldier = [
    "assets/soldier/1.png",
    "assets/soldier/2.png",
    "assets/soldier/3.png",
    "assets/soldier/4.png",
    "assets/soldier/5.png",
    "assets/soldier/6.png",
    "assets/soldier/7.png",
  ].obs;
  final setting = [].obs;
  void setImage() {
    back.remove(Singleton.instance.back.value);
    map.remove(Singleton.instance.map.value);
    king.remove(Singleton.instance.king.value);
    slave.remove(Singleton.instance.slave.value);
    soldier.remove(Singleton.instance.soldier.value);
  }
}
