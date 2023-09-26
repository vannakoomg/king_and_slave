import 'dart:math';

import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final startGame = false.obs;
  final rotate = 0.0.obs;
  final sword = false.obs;
  final showLoading = false.obs;
  final letStart = false.obs;
  void setDefault(double w, double h, int type) {
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
      if (neww.y! > screenHigh.value / 2 - highOfCard.value - 10) {
        neww.y = screenHigh.value / 2 - highOfCard.value - 10;
      }
      newPostion.value = neww;
      positionYourCard[index] = neww;
    }
  }

  void onVerticalDragEnd(int index) {
    debugPrint("value $type");
    if (!isPlaying.value) {
      if (positionYourCard[index].y! + 40 >
          screenHigh.value / 2 - highOfCard.value) {
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
              "turn": true
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
              "turn": true
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
    if (!isPlaying.value) {
      isPlaying.value = false;
      oldPostion.value = positionYourCard[i];
      index.value = i;
      yourCard.value = listYourCard[i];
    }
  }

  void enmey(int index, Cardmodel enmey) {
    debugPrint("vannak ka k play");
    enemyCard.value = enmey;
    openEnemy.value = false;
    positionEnemyCard[index] = Postion(
        x: screenWight / 2 - screenWight / 5 / 2,
        y: screenHigh / 2 - highOfCard.value - 10);
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
    String result = "";
    Future.delayed(const Duration(milliseconds: 500), () {
      if (yourCard.value.name == "king" && enemyCard.value.name != "slave") {
        result = "win";
        debugPrint("you win");
      } else if (yourCard.value.name == "slave" &&
          enemyCard.value.name == "king") {
        debugPrint("you win");
        result = "win";
      } else if (yourCard.value.name == "soldier" &&
          enemyCard.value.name == "slave") {
        result = "win";
        debugPrint("you win");
      } else if (yourCard.value.name == enemyCard.value.name) {
        debugPrint("you Drou");
        result = "drou";
      } else {
        debugPrint("your lose");
        result = "lose";
      }
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (result == 'drou') {
          Get.defaultDialog(
            actions: [const Text("fdsfdfdf")],
            custom: Container(
              height: 400,
              color: Colors.red,
              width: 400,
            ),
            title: "sdfasjkf",
          );
        } else {
          final play =
              FirebaseFirestore.instance.collection('room').doc(roomId.value);
          Get.back();
          play.delete();
        }
        isPlaying.value = false;
        showEnemy.value = false;
        rotate.value = 0;
        enemyCard.value = Cardmodel();
      });
    });
  }
}
