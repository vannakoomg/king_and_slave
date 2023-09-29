import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/modules/game/screens/game_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  final type = 0.obs;
  final isCreateRoom = false.obs;
  final isenterPassword = false.obs;
  final roomNameTextEditController = TextEditingController().obs;
  final passwordTextEditController = TextEditingController().obs;
  final enterPasswordTextEditController = TextEditingController().obs;
  final roomId = ''.obs;
  final roomPassword = ''.obs;
  final isWorngPassword = false.obs;
  final isDisbleButtonOk = true.obs;
  final isloadingCreateroom = false.obs;
  void createRoom() {
    if (roomNameTextEditController.value.text == "") {
      isDisbleButtonOk.value = true;
    } else {
      isDisbleButtonOk.value = false;
    }
    isCreateRoom.value = true;
  }

  void submit(int type) async {
    isloadingCreateroom.value = true;
    final docuser = FirebaseFirestore.instance.collection("room").doc();
    final room = RoomModel(
      createDate: DateTime.now().toString(),
      type: type,
      id: docuser.id,
      name: roomNameTextEditController.value.text,
      password: passwordTextEditController.value.text,
      king: King(
          card: Cardmodel(image: "", name: ""),
          index: -1,
          length: -1,
          turn: false,
          status: ''),
      slave: King(
          card: Cardmodel(image: "", name: ""),
          index: -2,
          length: -1,
          turn: false,
          status: ''),
    );
    final json = room.toJson();
    await docuser.set(json).then((value) => {
          isloadingCreateroom.value = false,
          Get.to(() => GameScreen(id: docuser.id, you: type))
        });
    isCreateRoom.value = false;
    roomNameTextEditController.value = TextEditingController();
    passwordTextEditController.value = TextEditingController();
  }

  void join() {
    debugPrint(
        "${roomPassword.value}, ${enterPasswordTextEditController.value.text}");
    if (roomPassword.value == enterPasswordTextEditController.value.text) {
      debugPrint("nice brother");
      final play =
          FirebaseFirestore.instance.collection('room').doc(roomId.value);
      play.update({"slave.index": -1}).then((value) => {
            Get.to(
              () => GameScreen(id: roomId.value, you: type.value),
            )
          });
    } else {
      isWorngPassword.value = true;
    }
  }
}
