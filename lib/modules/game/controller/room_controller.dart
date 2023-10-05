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

  void onTapRoom({required List<RoomModel> roomList, required int type}) {
    if (Singleton.instance.life.value <= 0) {
      debugPrint("you have no life ");
    } else {
      for (int i = 0; i < roomList.length; ++i) {
        if (roomList[i].password != '') {
          roomId.value = roomList[i].id!;
          roomPassword.value = roomList[i].password!;
          isenterPassword.value = true;
        } else {
          final play = FirebaseFirestore.instance
              .collection('room')
              .doc(roomList[i].id!);
          play.update({"slave.index": -1}).then((value) => {
                Get.to(
                  () => GameScreen(id: roomList[i].id!, you: type),
                )
              });
        }
      }
    }
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

  Future join() async {
    if (roomPassword.value == enterPasswordTextEditController.value.text) {
      debugPrint("nice brother");
      final play =
          FirebaseFirestore.instance.collection('room').doc(roomId.value);
      play.update({"slave.index": -1}).then((value) => {
            Get.to(
              () => GameScreen(id: roomId.value, you: type.value),
            ),
            isenterPassword.value = false,
          });
    } else {
      isWorngPassword.value = true;
    }
  }

  RewardedAd? rewardedAd;
  final reward = "ca-app-pub-3940256099942544/5224354917".obs;
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
