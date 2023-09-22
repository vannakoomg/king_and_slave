import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  final roomData = <RoomModel>[
    RoomModel(
        password: "", roomId: "1", roomName: "KAKPLAY", userId: "1314456"),
    RoomModel(password: "111", roomId: "2", roomName: "ZIN2", userId: "2222"),
    RoomModel(
        password: "2344", roomId: "3", roomName: "HOKOLO", userId: "454545"),
  ];
  final isCreateRoom = false.obs;
  final isenterPassword = false.obs;
  final roomNameTextEditController = TextEditingController().obs;
  final passwordTextEditController = TextEditingController().obs;
  final enterPasswordTextEditController = TextEditingController().obs;

  final password = ''.obs;
  final roomName = ''.obs;
  final enterPassword = "".obs;
  void createRoom() {
    isCreateRoom.value = true;
  }

  void submit() {
    debugPrint("$password ");
  }

  void join() {
    debugPrint("$enterPassword ");
  }

  void onchangeRoomName(String value) {
    roomName.value = value;
  }

  void onchangePassword(String value) {
    password.value = value;
  }

  void onchangeEnterPassword(String value) {
    enterPassword.value = value;
  }
}
