import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedBackController extends GetxController {
  final descriptionTextController = TextEditingController().obs;
  final description = ''.obs;
  final isloading = false.obs;
  final _connect = GetConnect();
  Future feedback() async {
    isloading.value = true;
    try {
      await _connect.post(
        'https://api.telegram.org/bot6650556480:AAGW4hsUlJOAg7Q-Xjw2lxezaJkoxW5xB5Y/sendmessage?chat_id=-4084728733&text=${description.value.trim()}',
        {},
      ).then((value) {
        descriptionTextController.value = TextEditingController();
        description.value = '';
        isloading.value = false;
      });
    } catch (e) {
      debugPrint("server down ");
      isloading.value = false;
    } finally {
      isloading.value = false;
    }
  }
}
