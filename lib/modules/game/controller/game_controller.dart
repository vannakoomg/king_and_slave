import 'dart:async';
import 'dart:math';

import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/game_model.dart';

class Controller extends GetxController {
  final type = 0.obs;
  final roomId = "".obs;
  final listYourCard = <Cardmodel>[].obs;
  final listEnemyCard = <Cardmodel>[].obs;
  final yourCard = Cardmodel().obs;
  final enemyCard = Cardmodel().obs;
  final positionYourCard = <Postion>[].obs;
  final positionEnemyCard = <Postion>[].obs;
  final oldPostion = Postion(x: 0, y: 0).obs;
  final newPostion = Postion(x: 0, y: 0).obs;
  final newPostionEnmey = Postion(x: 0, y: 0).obs;
  final istouchCard = false.obs;
  final screenWight = 0.0.obs;
  final screenHigh = 0.0.obs;
  final highOfCard = 0.0.obs;
  final isPlaying = false.obs;
  final onTapEnemy = false.obs;
  final showEnemy = false.obs;
  final index = 0.obs;
  final openEnemy = false.obs;
  final rotate = 0.0.obs;
  final sword = false.obs;
  final showLoading = false.obs;
  final letStart = false.obs;
  final time = 120.obs;
  final isStart = false.obs;
  final isShowTime = false.obs;
  final gamePlay = false.obs;
  final status = "".obs;
  final isShowAdMob = false.obs;
  final timeEnemy = 0.obs;
  final ischeckEnemy = true.obs;
  final isRedLine = false.obs;
  final enemyMessage = ''.obs;
  final yourMessage = ''.obs;
  final isEnemyMessage = false.obs;
  final isYourMessage = false.obs;
  final isChat = false.obs;
  final chatTextController = TextEditingController().obs;
  final chatText = ''.obs;
  void setDefault(double w, double h, int type) {
    gamePlay.value = false;
    screenWight.value = w;
    screenHigh.value = h;
    List you = type == 0
        ? ["king", "soldier", "soldier", "soldier", "soldier"]
        : ["slave", "soldier", "soldier", "soldier", "soldier"];

    List enemy = type == 0
        ? ["slave", "soldier", "soldier", "soldier", "soldier"]
        : ["king", "soldier", "soldier", "soldier", "soldier"];
    highOfCard.value = 0.2 * w + 0.2 * w / 3;
    positionYourCard.clear();
    positionEnemyCard.clear();
    listYourCard.clear();
    listEnemyCard.clear();
    for (int i = 0; i < 5; ++i) {
      positionYourCard.add(Postion(x: i * 0.2 * w, y: 10));
      positionEnemyCard.add(Postion(x: i * 0.2 * w, y: 0));
      int j = Random().nextInt(you.length);
      int k = Random().nextInt(enemy.length);
      listYourCard.add(Cardmodel(
          image: you[j] == "king"
              ? Singleton.instance.king.value
              : you[j] == "slave"
                  ? Singleton.instance.slave.value
                  : Singleton.instance.soldier.value,
          name: you[j]));
      listEnemyCard.add(Cardmodel(
          image: enemy[k] == "king"
              ? Singleton.instance.king.value
              : you[j] == "slave"
                  ? Singleton.instance.slave.value
                  : Singleton.instance.soldier.value,
          name: you[k]));
      you.removeAt(j);
      enemy.removeAt(k);
    }
  }

  void onVerticalDragUpdate(Postion old, Postion neww, int index) {
    if (!isPlaying.value) {
      // for get new posstion
      istouchCard.value = true;
      if (neww.x! < 0) {
        neww.x = 00;
      }
      if (neww.x! > screenWight.value - screenWight.value * 0.2) {
        neww.x = screenWight.value - screenWight.value * 0.2;
      }
      if (neww.y! < 0) {
        neww.y = 0;
      }
      if (neww.y! > screenHigh.value / 2 - highOfCard.value - 5) {
        neww.y = screenHigh.value / 2 - highOfCard.value - 5;
      }
      newPostion.value = neww;
      positionYourCard[index] = neww;
      positionYourCard[index].y! + 40 > screenHigh.value / 2 - highOfCard.value
          ? isRedLine.value = true
          : isRedLine.value = false;
    }
  }

  Timer? timer;
  void removelife() async {
    final SharedPreferences obj = await SharedPreferences.getInstance();
    int life = obj.getInt('life')!;
    obj.setInt('life', life - 1);
    Singleton.instance.life.value = obj.getInt('life')!;
    debugPrint("life in game = ${obj.getInt('life')}");
  }

  void checkTime() {
    if (status.value == "") {
      timer = Timer.periodic(const Duration(milliseconds: 1000),
          (Timer timer) async {
        final play =
            FirebaseFirestore.instance.collection('room').doc(roomId.value);
        if (isStart.value && time.value > 0 && status.value == "") {
          time.value--;
          if (time.value == 0) {
            if (type.value == 0) {
              play.update({
                "king.status": "lose",
              });
            } else {
              play.update({
                "slave.status": "lose",
              });
            }
            status.value = "you_surrender";
          }
        }
        if (timeEnemy.value > 0) {
          if (ischeckEnemy.value) {
            timeEnemy.value--;
            debugPrint("timegmae ${timeEnemy.value} ");
          }
          if (timeEnemy.value <= 0) {
            debugPrint("eneme_surrender ");
            if (type.value == 0) {
              play.update({
                "slave.status": "lose",
              });
            } else {
              play.update({
                "king.status": "lose",
              });
            }
            status.value = "enemy_surrender";
          }
        }
      });
    }
  }

  void ontapChat() {
    isChat.value = true;
  }

  void listionGamePaly(RoomModel roomModel) {
    if (status.value == '') {
      if (roomModel.slave!.index == -2) {
        showLoading.value = true;
      } else {
        showLoading.value = false;
      }
      if (roomModel.slave!.index == -1 &&
          roomModel.king!.index == -1 &&
          roomModel.king!.status == '' &&
          roomModel.slave!.status == '') {
        letStart.value = true;
        Future.delayed(const Duration(milliseconds: 5500), () {
          timeEnemy.value = 120;
          letStart.value = false;
          isStart.value = true;
          isShowTime.value = true;
          gamePlay.value = true;
        });
      }
      if (roomModel.king!.status != '' || roomModel.slave!.status != '') {
        if (roomModel.slave!.status == "lose" &&
            roomModel.king!.status == "lose") {
          isStart.value = false;
          sword.value = false;
          status.value = "you_surrender";
        } else {
          if ((type.value == 0 && roomModel.slave!.status == "lose")) {
            status.value = 'enemy_surrender';
            isStart.value = false;
            sword.value = false;
          }
          if (type.value == 1 && roomModel.king!.status == "lose") {
            status.value = 'enemy_surrender';
            isStart.value = false;
            sword.value = false;
          }
        }
        removelife();
      } else {
        if (roomModel.slave!.index! >= 0 || roomModel.king!.index! >= 0) {
          if (roomModel.slave!.length == roomModel.king!.length) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              endGame(roomModel.id!);
            });
          }
          if (type.value == 0) {
            if (roomModel.slave!.turn == true) {
              ischeckEnemy.value = false;
              enmey(
                roomModel.slave!.index!,
                roomModel.slave!.card!,
              );
            }
          } else {
            if (roomModel.king!.turn == true) {
              enmey(roomModel.king!.index!, roomModel.king!.card!);
              ischeckEnemy.value = false;
            }
          }
        }
      }
      if (type.value == 0) {
        if (roomModel.slave!.message != '' &&
            roomModel.slave!.message != enemyMessage.value) {
          enemyMessage.value = roomModel.slave!.message!;
          isEnemyMessage.value = true;
          Future.delayed(const Duration(milliseconds: 4000), () {
            isEnemyMessage.value = false;
          });
        }
      } else {
        if (roomModel.king!.message != '' &&
            roomModel.king!.message != enemyMessage.value) {
          enemyMessage.value = roomModel.king!.message!;
          isEnemyMessage.value = true;
          Future.delayed(const Duration(milliseconds: 4000), () {
            isEnemyMessage.value = false;
          });
        }
      }
    }
  }

  void sendMessage() {
    final play =
        FirebaseFirestore.instance.collection('room').doc(roomId.value);
    if (type.value == 0) {
      play.update({
        "king.message": chatText.value,
      });
    } else {
      play.update({
        "slave.message": chatText.value,
      });
    }
    isChat.value = false;
    yourMessage.value = chatText.value;
    isYourMessage.value = true;
    chatText.value = '';
    chatTextController.value = TextEditingController();
    Future.delayed(const Duration(milliseconds: 4000), () {
      isYourMessage.value = false;
    });
  }

  void onVerticalDragEnd(int index) {
    if (isPlaying.value == false) {
      if (positionYourCard[index].y! + 40 >
          screenHigh.value / 2 - highOfCard.value) {
        time.value = 120;
        isStart.value = false;
        newPostion.value = positionYourCard[index];
        isPlaying.value = true;
        debugPrint("remove at $index");
        positionYourCard.removeAt(index);
        listYourCard.removeAt(index);
        Future.delayed(const Duration(milliseconds: 100), () {
          positionYourCard.clear();
          debugPrint(" romver kkkk$listYourCard");
          istouchCard.value = false;
          for (int i = 0; i < listYourCard.length; ++i) {
            positionYourCard.add(Postion(
                x: i * 0.2 * screenWight.value +
                    (5 - listYourCard.length) * 0.2 * screenWight.value / 2,
                y: 10));
          }
        });
        final play =
            FirebaseFirestore.instance.collection('room').doc(roomId.value);
        if (type.value == 0) {
          play.update({
            "king": {
              "card": {
                "image": yourCard.value.image,
                "name": yourCard.value.name
              },
              "profile": {
                "avatar": Singleton.instance.avatar.value,
                "name": Singleton.instance.nickName.value,
              },
              "index": index,
              "length": listYourCard.length,
              "turn": true,
              "status": "",
              "message": "",
            },
            "slave.turn": false
          });
        } else {
          play.update({
            "slave": {
              "card": {
                "image": yourCard.value.image,
                "name": yourCard.value.name
              },
              "profile": {
                "avatar": Singleton.instance.avatar.value,
                "name": Singleton.instance.nickName.value,
              },
              "index": index,
              "length": listYourCard.length,
              "turn": true,
              "status": "",
              "message": ""
            },
            "king.turn": false
          });
        }
      } else {
        positionYourCard[index] = oldPostion.value;
        istouchCard.value = false;
      }
    }
  }

  void onVerticalDragStart(int i) {
    sword.value = false;
    debugPrint("isPlaying ${isPlaying.value}");
    if (isPlaying.value == false) {
      isPlaying.value = false;
      oldPostion.value = positionYourCard[i];
      index.value = i;
      yourCard.value = listYourCard[i];
    }
  }

  void enmey(int index, Cardmodel enmey) {
    enemyCard.value = enmey;
    openEnemy.value = false;
    positionEnemyCard[index] = Postion(
        x: screenWight / 2 - screenWight / 5 / 2,
        y: screenHigh / 2 - highOfCard.value - 5);
    Future.delayed(const Duration(milliseconds: 500), () {
      showEnemy.value = true;
      newPostionEnmey.value = positionEnemyCard[index];
      onTapEnemy.value = true;
      listEnemyCard.removeAt(index);
      positionEnemyCard.removeAt(index);
      Future.delayed(const Duration(milliseconds: 50), () {
        onTapEnemy.value = false;
        positionEnemyCard.clear();
        for (int i = 0; i < listEnemyCard.length; ++i) {
          positionEnemyCard.add(
            Postion(
              x: i * 0.2 * screenWight.value +
                  (5 - listEnemyCard.length) * 0.2 * screenWight.value / 2,
              y: 0,
            ),
          );
        }
      });
    });
  }

  void endGame(String id) {
    rotate.value = 3.14;
    isStart.value = false;
    ischeckEnemy.value = true;
    timeEnemy.value = 120;
    time.value = 120;
    isRedLine.value = false;
    Future.delayed(const Duration(milliseconds: 1500), () {
      isStart.value = true;
      if ((yourCard.value.name == "king" && enemyCard.value.name != "slave") ||
          (yourCard.value.name == "slave" && enemyCard.value.name == "king") ||
          (yourCard.value.name == "soldier" &&
              enemyCard.value.name == "slave")) {
        status.value = "win";
        isStart.value = true;
        removelife();
      } else if (yourCard.value.name == enemyCard.value.name) {
        status.value = "equal";
        debugPrint("status 1 : ${status.value}");
        isStart.value = false;
        Future.delayed(const Duration(milliseconds: 1500), () {
          status.value = "";
          isStart.value = true;
        });
      } else {
        isStart.value = true;
        status.value = "lose";
        removelife();
      }
      isPlaying.value = false;
      showEnemy.value = false;
      rotate.value = 0;
      enemyCard.value = Cardmodel();
    });
  }

  void ontapSword02() {
    if (isStart.value || showLoading.value) {
      sword.value = false;
      final play =
          FirebaseFirestore.instance.collection('room').doc(roomId.value);
      if (gamePlay.value == false) {
        Get.back();
        play.delete();
      } else {
        if (type.value == 0) {
          play.update({
            "king.status": "lose",
          });
        } else {
          play.update({
            "slave.status": "lose",
          });
        }
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });
      }
    }
  }

  void ontapSword01() {
    if (isStart.value || showLoading.value) {
      sword.value = !sword.value;
    }
  }

  InterstitialAd? interstitialAd;

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3625881169262046/9283118792",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // _moveToHome();
            },
          );

          interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
}
