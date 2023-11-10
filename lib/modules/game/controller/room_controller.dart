import 'dart:math';

import 'package:animation_aba/modules/game/models/chat_model.dart';
import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/modules/game/screens/game_screen.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomController extends GetxController {
  final type = 0.obs;
  final isCreateRoom = false.obs;
  final isenterPassword = false.obs;
  final roomNameTextEditController = TextEditingController().obs;
  final passwordTextEditController = TextEditingController().obs;
  final enterPasswordTextEditController = TextEditingController().obs;
  final roomId = ''.obs;
  final chatId = ''.obs;
  final roomPassword = ''.obs;
  final isWorngPassword = false.obs;
  final isDisbleButtonOk = true.obs;
  final isDisbleButtomJoin = true.obs;
  final isloadingCreateroom = false.obs;
  final isNoMoreLife = false.obs;
  void createRoom() {
    if (Singleton.instance.life.value <= 0) {
      debugPrint("You have no life more");
      isNoMoreLife.value = true;
    } else {
      if (roomNameTextEditController.value.text == "") {
        isDisbleButtonOk.value = true;
      } else {
        isDisbleButtonOk.value = false;
      }
      isCreateRoom.value = true;
    }
  }

  Color randomColors() {
    int i = Random().nextInt(3);
    if (i == 0) {
      return const Color(0xff2a9d8f);
    } else if (i == 1) {
      return const Color(0xfff4a261);
    } else if (i == 2) {
      return const Color(0xffe76f51);
    } else {
      return const Color(0xffe9c46a);
    }
  }

  int randomNumber() {
    int i = Random().nextInt(10) + 1;
    return i != 4 ? i : Random().nextInt(3);
  }

  void submit(int type) async {
    isloadingCreateroom.value = true;
    final docuser = FirebaseFirestore.instance.collection("room").doc();
    final docChat = FirebaseFirestore.instance.collection("chat").doc();
    final chat = ChatModel(
        messagelking: Messagelking(title: "", turn: false),
        messagelslave: Messagelking(title: "", turn: false));
    final jsonChat = chat.toJson();
    await docChat.set(jsonChat).then((value) async {
      final room = RoomModel(
        chatId: docChat.id,
        createDate: DateTime.now().toString(),
        type: type,
        id: docuser.id,
        name: roomNameTextEditController.value.text.trim(),
        password: passwordTextEditController.value.text.trim(),
        king: King(
            card: Cardmodel(image: "", name: ""),
            index: -1,
            length: -1,
            turn: false,
            status: '',
            profile: ProfileModel(
                avatar: type == 0 ? Singleton.instance.avatar.value : "",
                name: type == 0 ? Singleton.instance.nickName.value : '')),
        slave: King(
            card: Cardmodel(image: "", name: ""),
            index: -2,
            length: -1,
            turn: false,
            status: '',
            profile: ProfileModel(
                avatar: type == 1 ? Singleton.instance.avatar.value : "",
                name: type == 1 ? Singleton.instance.nickName.value : '')),
      );
      final json = room.toJson();
      await docuser.set(json).then((value) => {
            isloadingCreateroom.value = false,
            Get.to(() => GameScreen(
                  id: docuser.id,
                  you: type,
                  chatID: docChat.id,
                ))
          });
    });

    isCreateRoom.value = false;
    roomNameTextEditController.value = TextEditingController();
    passwordTextEditController.value = TextEditingController();
  }

  Future join() async {
    if (roomPassword.value == enterPasswordTextEditController.value.text) {
      final play =
          FirebaseFirestore.instance.collection('room').doc(roomId.value);
      if (type.value == 0) {
        debugPrint("dddddd");
        play.update({
          "slave.index": -1,
          "king.profile": {
            "avatar": Singleton.instance.avatar.value,
            "name": Singleton.instance.nickName.value
          }
        }).then((value) => {
              Get.to(
                () => GameScreen(
                    id: roomId.value, you: type.value, chatID: chatId.value),
              ),
              isenterPassword.value = false,
            });
      } else {
        play.update({
          "slave.profile": {
            "avatar": Singleton.instance.avatar.value,
            "name": Singleton.instance.nickName.value
          }
        });
        play.update({"slave.index": -1}).then((value) => {
              Get.to(
                () => GameScreen(
                  id: roomId.value,
                  you: type.value,
                  chatID: chatId.value,
                ),
              ),
              isenterPassword.value = false,
            });
      }
    } else {
      isWorngPassword.value = true;
    }
  }

  RewardedAd? rewardedAd;
  final reward = "ca-app-pub-3625881169262046/6426404050".obs;
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: reward.value,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              rewardedAd = null;
              loadRewardedAd();
            },
          );
          rewardedAd = ad;
        },
        onAdFailedToLoad: (err) async {
          debugPrint('failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  void viewAds() {
    rewardedAd?.show(
      onUserEarnedReward: (_, reward) async {
        debugPrint("value KHmer khmer ${reward.amount}");
        final SharedPreferences obj = await SharedPreferences.getInstance();
        await obj.setInt('life', 5);
        Singleton.instance.life.value = 5;
        isNoMoreLife.value = false;
      },
    );
  }
}
