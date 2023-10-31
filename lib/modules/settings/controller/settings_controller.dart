import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/models/language_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  final imageShow = ''.obs;
  final back = [
    "assets/back/1.svg",
    "assets/back/2.svg",
    "assets/back/3.svg",
    "assets/back/4.svg",
    "assets/back/5.svg",
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

  final isShowLaw = false.obs;
  final isanimatedlaw = false.obs;
  void ontapLaw() {
    isShowLaw.value = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      isanimatedlaw.value = true;
    });
  }

  void ontapBackLaw() {
    isanimatedlaw.value = false;
    Future.delayed(const Duration(milliseconds: 400), () {
      isShowLaw.value = false;
    });
  }

  final isloadinglanguage = false.obs;
  Future<void> fetchLanguage() async {
    isloadinglanguage.value = true;
    final SharedPreferences obj = await SharedPreferences.getInstance();
    if (Singleton.instance.lang.value == 'kh') {
      Singleton.instance.lang.value = "en";
      obj.setString("language", "en");
    } else {
      Singleton.instance.lang.value = "kh";
      obj.setString("language", "kh");
    }
    FirebaseFirestore.instance
        .collection("languages")
        .doc(Singleton.instance.lang.value)
        .get()
        .then((value) {
      isloadinglanguage.value = false;
      Singleton.instance.languages.value =
          LanguagesModel.fromJson(value.data()!);
    }).onError((error, stackTrace) {
      isloadinglanguage.value = false;
    });
  }
}
