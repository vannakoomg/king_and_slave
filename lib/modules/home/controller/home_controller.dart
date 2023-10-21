import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final introduction = false.obs;
  final isSetting = false.obs;
  final isShowAdMob = false.obs;
  final isFirst = false.obs;
  void checkIsFirst() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.getString('first') == null) {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        isFirst.value = true;
      });
    } else {
      isFirst.value = false;
    }
  }
}
