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
      positionEnemyCard.add(Postion(x: i * 0.2 * w, y: 10));
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
      if (neww.y! > screenHigh.value / 2 - highOfCard.value + 5) {
        neww.y = screenHigh.value / 2 - highOfCard.value + 5;
      }
      newPostion.value = neww;
      positionYourCard[index] = neww;
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
        if (isStart.value && time.value > 0 && status.value == "") {
          time.value--;
          if (time.value == 0) {
            final play =
                FirebaseFirestore.instance.collection('room').doc(roomId.value);
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
      });
    }
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
              enmey(
                roomModel.slave!.index!,
                roomModel.slave!.card!,
              );
            }
          } else {
            if (roomModel.king!.turn == true) {
              enmey(roomModel.king!.index!, roomModel.king!.card!);
            }
          }
        }
      }
    }
  }

  void onVerticalDragEnd(int index) {
    debugPrint("value $type");
    if (!isPlaying.value) {
      if (positionYourCard[index].y! + 40 >
          screenHigh.value / 2 - highOfCard.value) {
        time.value = 120;
        isStart.value = false;
        newPostion.value = positionYourCard[index];
        isPlaying.value = true;
        positionYourCard.removeAt(index);
        listYourCard.removeAt(index);
        Future.delayed(const Duration(milliseconds: 50), () {
          positionYourCard.clear();
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
              "index": index,
              "length": listYourCard.length,
              "turn": true,
              "status": ""
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
              "index": index,
              "length": listYourCard.length,
              "turn": true,
              "status": ""
            },
            "king.turn": false
          });
        }
      } else {
        //  positionYourCard[index] =
        positionYourCard[index] = oldPostion.value;
        istouchCard.value = false;
        // Future.delayed(const Duration(milliseconds: 1000), () {
        // });
      }
      debugPrint("room id ${roomId.value}");
    }
  }

  void onVerticalDragStart(int i) {
    sword.value = false;
    if (!isPlaying.value) {
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
        y: screenHigh / 2 - highOfCard.value - 15);
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
              y: 10,
            ),
          );
        }
      });
    });
  }

  void endGame(String id) {
    rotate.value = 3.14;
    isStart.value = false;
    time.value = 120;
    Future.delayed(const Duration(milliseconds: 1500), () {
      isStart.value = true;
      if ((yourCard.value.name == "king" && enemyCard.value.name != "slave") ||
          (yourCard.value.name == "slave" && enemyCard.value.name == "king") ||
          (yourCard.value.name == "soldier" &&
              enemyCard.value.name == "slave")) {
        status.value = "win";
        isStart.value = true;
        debugPrint("kakkkk ${status.value}");
        removelife();
      } else if (yourCard.value.name == enemyCard.value.name) {
        status.value = "equal";
        isStart.value = false;
        Future.delayed(const Duration(milliseconds: 1500), () {
          status.value = "";
          isStart.value = true;
        });
      } else {
        isStart.value = true;
        status.value = "lose";
        debugPrint("kakkkk ${status.value}");
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
        interstitialAd!.show().then((value) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Get.back();
          });
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
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
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
