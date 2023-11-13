import 'dart:async';
import 'dart:math';
import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../game/models/game_model.dart';

class BotController extends GetxController {
  final isEnemyProfile = false.obs;
  final isBot = false.obs;
  final type = 0.obs;
  final roomId = "".obs;
  final chatId = "".obs;
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
  final isChat = false.obs;
  final chatTextController = TextEditingController().obs;
  final chatText = ''.obs;
  final botImage = "".obs;
  final botMessage = "".obs;
  final isShowhand = false.obs;
  final handHigh = 0.0.obs;
  final understand = false.obs;
  Future<void> setDefault(double w, double h, int type, bool isfirst) async {
    debugPrint("Your Type $type");
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
              : enemy[k] == "slave"
                  ? Singleton.instance.slave.value
                  : Singleton.instance.soldier.value,
          name: enemy[k]));
      debugPrint("iamge enemy ${listEnemyCard[i].name}");
      debugPrint("iamge enemy ${listEnemyCard[i].image}");
      you.removeAt(j);
      enemy.removeAt(k);
    }
    if (isfirst) {
      Future.delayed(const Duration(seconds: 1), () {
        botMessage.value = "Hi I am Bot , come for help you!";
        Future.delayed(const Duration(seconds: 3), () {
          botMessage.value = "";
          int i = Random().nextInt(5);
          enmey(
            i,
            Cardmodel(
              image: listEnemyCard[i].image,
              name: listEnemyCard[i].name,
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            botMessage.value = "ខ្ញុំបានបោះសន្លឹលបៀរមួយហើយដល់វេនរបស់អ្នកម្ដង";
            Future.delayed(const Duration(milliseconds: 1500), () {
              isShowhand.value = true;
            });
            handHigh.value = 10;
            Future.delayed(const Duration(seconds: 2), () async {
              botMessage.value = "longPress and move the card";
              handHigh.value = h / 2 - 100;
              for (int i = 0; i < 10; ++i) {
                if (understand.value == false) {
                  await Future.delayed(const Duration(milliseconds: 2500),
                      () async {
                    isShowhand.value = false;
                    handHigh.value = 10;
                    await Future.delayed(const Duration(seconds: 1), () async {
                      isShowhand.value = true;
                      await Future.delayed(const Duration(milliseconds: 100),
                          () {
                        handHigh.value = h / 2 - 100;
                      });
                    });
                  });
                }
              }
            });
          });
        });
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        int i = Random().nextInt(5);
        enmey(
          i,
          Cardmodel(
            image: listEnemyCard[i].image,
            name: listEnemyCard[i].name,
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          enemyMessage.value =
              "HI BOT ${emoji1[Random().nextInt(10)]} ${emoji1[Random().nextInt(10)]}";
          isEnemyMessage.value = true;
          Future.delayed(const Duration(milliseconds: 5000), () {
            enemyMessage.value = "";
            isEnemyMessage.value = true;
          });
        });
      });
    }
  }

  void onVerticalDragUpdate(Postion old, Postion neww, int index) {
    if (!isPlaying.value && showEnemy.value == true) {
      understand.value = true;

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

  final emoji1 = ["😂", "😄", "🤪", "😉", "😝", "🤫", "🤧", "🤖", "🤡", "🤖"];

  Timer? timer;

  void checkTime() {
    timer =
        Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) async {
      if (status.value == "") {
        time.value--;
        if (time.value == 0) {
          status.value = "you_surrender";
        }
      }
    });
  }

  void ontapChat() {
    isChat.value = !isChat.value;
  }

  void sendMessage() async {
    yourMessage.value = chatText.value;
    isChat.value = false;
    chatText.value = '';
    chatTextController.value = TextEditingController();
    Future.delayed(const Duration(seconds: 4), () async {
      yourMessage.value = "";
      debugPrint("message ${yourMessage.value}");
    });
    Future.delayed(const Duration(seconds: 2), () {
      enemyMessage.value = "Bot can replye 😂😂😂😂";
      Future.delayed(const Duration(seconds: 3), () {
        enemyMessage.value = "";
      });
    });
  }

  void onVerticalDragEnd(int index, bool isfirst) {
    if (isPlaying.value == false && showEnemy.value == true) {
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
              y: 10,
            ));
          }
        });
        if (listYourCard.length == listEnemyCard.length) {
          endGame();
        }
        if (isfirst) {
          Future.delayed(const Duration(milliseconds: 3200), () {
            if (status.value == '') {
              Future.delayed(const Duration(milliseconds: 600), () {
                botMessage.value = "you did it good";
              });
              Future.delayed(const Duration(seconds: 2), () {
                int i = Random().nextInt(listEnemyCard.length);
                debugPrint("image url ${listEnemyCard[i].name}");
                enmey(
                    i,
                    Cardmodel(
                      image: listEnemyCard[i].image,
                      name: listEnemyCard[i].name,
                    ));
                Future.delayed(const Duration(seconds: 2), () {
                  botMessage.value = "";
                });
              });
            } else {
              botMessage.value = status.value == "lose"
                  ? "What The F* bro , you play lose with the bot !!!"
                  : "Nice bro you win with the bot  🤖🤖🤖🤖 ";
              Future.delayed(const Duration(seconds: 4), () {
                botMessage.value = "";
                Future.delayed(const Duration(milliseconds: 1000), () {
                  botMessage.value = status.value == "lose"
                      ? "but never mind ,Now you can enjoy the Real World 🌹🌹🌹🌹🌹🌹, go lock ! "
                      : "Now you can enjoy the Real World 🌹🌹🌹🌹🌹🌹, go lock ! ";
                });
              });
            }
          });
        } else {
          Future.delayed(const Duration(milliseconds: 3200), () {
            if (status.value == '') {
              int i = Random().nextInt(listEnemyCard.length);
              enmey(
                  i,
                  Cardmodel(
                    image: listEnemyCard[i].image,
                    name: listEnemyCard[i].name,
                  ));
            }
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
    if (isPlaying.value == false && showEnemy.value == true) {
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

  void endGame() {
    rotate.value = 3.14;
    isStart.value = false;
    ischeckEnemy.value = true;
    timeEnemy.value = 120;
    time.value = 120;
    isRedLine.value = false;
    Future.delayed(const Duration(milliseconds: 1500), () {
      debugPrint("image image ${yourCard.value.name} ${enemyCard.value.name}");
      isStart.value = true;
      if ((yourCard.value.name == "king" && enemyCard.value.name != "slave") ||
          (yourCard.value.name == "slave" && enemyCard.value.name == "king") ||
          (yourCard.value.name == "soldier" &&
              enemyCard.value.name == "slave")) {
        status.value = "win";
        isStart.value = true;
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
      }
      debugPrint("status 4444 : ${status.value}");

      isPlaying.value = false;
      showEnemy.value = false;
      rotate.value = 0;
      enemyCard.value = Cardmodel();
    });
  }

  void ontapSword02() {
    sword.value = false;
    if (gamePlay.value == false) {
      Get.back();
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    }
  }

  void ontapSword01() {
    sword.value = !sword.value;
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
