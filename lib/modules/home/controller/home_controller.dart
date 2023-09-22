import 'package:get/get.dart';

class HomeController extends GetxController {
  final sword01 = false.obs;
  final sword02 = false.obs;
  final introduction = false.obs;
  void sword11() {
    sword01.value = !sword01.value;
    sword02.value = false;
  }

  void sword22() {
    sword02.value = !sword02.value;
    sword01.value = false;
  }
}
