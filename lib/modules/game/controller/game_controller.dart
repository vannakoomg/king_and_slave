import 'dart:math';

import 'package:animation_aba/utils/controller/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/game_model.dart';

class Controller extends GetxController {
  final listYourCard = <GameCard>[].obs;
  final listEnemyCard = <GameCard>[].obs;
  final yourCard = GameCard().obs;
  final enemyCard = GameCard().obs;
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
      listYourCard.add(GameCard(
          image: you[j] == "king"
              ? Singleton.instance.king.value
              : you[j] == "slave"
                  ? Singleton.instance.slave.value
                  : Singleton.instance.soldier.value,
          name: you[j]));
      listEnemyCard.add(GameCard(
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
      } else {
        istouchCard.value = false;
        positionYourCard[index] = oldPostion.value;
      }
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

  void enmey(int index, GameCard enmey) {
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

  void endGame() {
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
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (result != "drou") {
          isPlaying.value = false;
          showEnemy.value = false;
        }
        rotate.value = 0;
        enemyCard.value = GameCard();
      });
    });
  }
}
