// ignore_for_file: deprecated_member_use

import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/main.dart';
import 'package:animation_aba/modules/game/controller/room_controller.dart';
import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/modules/game/screens/game_screen.dart';
import 'package:animation_aba/modules/game/screens/room_style.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:animation_aba/utils/widgets/custom_free5_life.dart';
import 'package:animation_aba/utils/widgets/custom_no_life.dart';
import 'package:animation_aba/utils/widgets/custom_textfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<RoomScreen> {
  var yourType = Get.arguments;
  final controller = Get.put(RoomController());
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    controller.type.value = yourType;
    return Scaffold(
      backgroundColor: Colors.black,
      body: OrientationBuilder(
          builder: (context, orientation) => Obx(
                () => SafeArea(
                    child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      left: 10,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 33,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: height,
                      width: width,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            yourType == 0
                                ? "assets/map/mongkot.svg"
                                : "assets/map/hat.svg",
                            color: AppColor.primary,
                            height: 50,
                          ),
                          Text(
                            yourType == 0
                                ? "${Singleton.instance.languages.value.king}"
                                : "${Singleton.instance.languages.value.slave}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                          StreamBuilder<List<RoomModel>>(
                              stream: FirebaseFirestore.instance
                                  .collection('room')
                                  .orderBy("createDate", descending: true)
                                  .snapshots()
                                  .map(
                                    (snapshots) => snapshots.docs
                                        .map((doc) =>
                                            RoomModel.fromJson(doc.data()))
                                        .toList(),
                                  ),
                              builder: (context, snapshots) {
                                if (snapshots.hasError) {
                                  return const Expanded(
                                      child: Center(
                                    child: Text(
                                      "Error Data",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ));
                                } else if (snapshots.hasData) {
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshots.data!.length,
                                      itemBuilder: (context, i) {
                                        return snapshots
                                                    .data![i].slave!.index ==
                                                -2
                                            ? (yourType == 0 &&
                                                        snapshots.data![i]
                                                                .type ==
                                                            1) ||
                                                    (yourType == 1 &&
                                                        snapshots.data![i]
                                                                .type ==
                                                            0)
                                                ? GestureDetector(
                                                    onTap: () {
                                                      if (Singleton.instance
                                                              .life.value >
                                                          0) {
                                                        if (snapshots.data![i]
                                                                .password !=
                                                            '') {
                                                          controller.roomId
                                                                  .value =
                                                              snapshots
                                                                  .data![i].id!;
                                                          controller.chatId
                                                                  .value =
                                                              snapshots.data![i]
                                                                  .chatId!;
                                                          controller
                                                                  .roomPassword
                                                                  .value =
                                                              snapshots.data![i]
                                                                  .password!;
                                                          controller
                                                              .isenterPassword
                                                              .value = true;
                                                        } else {
                                                          final play =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'room')
                                                                  .doc(snapshots
                                                                      .data![i]
                                                                      .id!);
                                                          final chat =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'chat')
                                                                  .doc(snapshots
                                                                      .data![i]
                                                                      .chatId);

                                                          if (yourType == 0) {
                                                            chat.update({
                                                              "messagelking.profile":
                                                                  {
                                                                "avatar":
                                                                    Singleton
                                                                        .instance
                                                                        .avatar
                                                                        .value,
                                                                "name": Singleton
                                                                    .instance
                                                                    .nickName
                                                                    .value,
                                                              }
                                                            });
                                                            play.update({
                                                              "slave.index": -1,
                                                            }).then((value) => {
                                                                  Get.to(
                                                                    () =>
                                                                        GameScreen(
                                                                      id: snapshots
                                                                          .data![
                                                                              i]
                                                                          .id!,
                                                                      you:
                                                                          yourType,
                                                                      chatID: snapshots
                                                                          .data![
                                                                              i]
                                                                          .chatId!,
                                                                    ),
                                                                  )
                                                                });
                                                          } else {
                                                            chat.update({
                                                              "messagelslave.profile":
                                                                  {
                                                                "avatar":
                                                                    Singleton
                                                                        .instance
                                                                        .avatar
                                                                        .value,
                                                                "name": Singleton
                                                                    .instance
                                                                    .nickName
                                                                    .value,
                                                              }
                                                            });
                                                            play
                                                                .update({
                                                              "slave.index": -1
                                                            }).then((value) => {
                                                                      Get.to(
                                                                        () =>
                                                                            GameScreen(
                                                                          id: snapshots
                                                                              .data![i]
                                                                              .id!,
                                                                          you:
                                                                              yourType,
                                                                          chatID: snapshots
                                                                              .data![i]
                                                                              .chatId!,
                                                                        ),
                                                                      )
                                                                    });
                                                          }
                                                        }
                                                      } else {
                                                        controller.isNoMoreLife
                                                            .value = true;
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              right: 5,
                                                              left: 5),
                                                      child: CustomPaint(
                                                        size: Size(
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                            50),
                                                        painter: RoomStyle(),
                                                        child: Container(
                                                          padding: EdgeInsets.only(
                                                              left: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.1,
                                                              right: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.1),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  "${snapshots.data![i].name}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.7),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ),
                                                              if (snapshots
                                                                      .data![i]
                                                                      .password !=
                                                                  '')
                                                                yourType == 0
                                                                    ? SvgPicture
                                                                        .asset(
                                                                        "assets/shield/2.svg",
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            30,
                                                                      )
                                                                    : SvgPicture
                                                                        .asset(
                                                                        "assets/shield/1.svg",
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            30,
                                                                      )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox()
                                            : const SizedBox();
                                      },
                                    ),
                                  );
                                } else {
                                  return Expanded(
                                    child: Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                              color: AppColor.primary,
                                              size: 25),
                                    ),
                                  );
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomBotton(
                              h: 40,
                              w: 140,
                              title:
                                  "${Singleton.instance.languages.value.create}",
                              ontap: () {
                                controller.createRoom();
                              },
                              isdisble: false),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    if (controller.isCreateRoom.value)
                      GestureDetector(
                        onTap: () {
                          controller.isCreateRoom.value = false;
                        },
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 1000),
                          opacity: controller.isCreateRoom.value ? 1 : 0,
                          child: Container(
                            color: Colors.black.withOpacity(0.92),
                            height: height,
                            width: width,
                            child: Center(
                              child: Container(
                                color: Colors.transparent,
                                height: 298,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    yourType == 0
                                        ? SvgPicture.asset(
                                            "assets/map/mongkot.svg",
                                            height: 50,
                                            color: Colors.white,
                                            width: 50,
                                          )
                                        : SvgPicture.asset(
                                            "assets/map/hat.svg",
                                            height: 50,
                                            color: Colors.white,
                                            width: 50,
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextfile(
                                      controller: controller
                                          .roomNameTextEditController.value,
                                      hintText:
                                          '${Singleton.instance.languages.value.roomName}',
                                      onchanged: (value) {
                                        if (value == '') {
                                          controller.isDisbleButtonOk.value =
                                              true;
                                        } else {
                                          controller.isDisbleButtonOk.value =
                                              false;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextfile(
                                      controller: controller
                                          .passwordTextEditController.value,
                                      hintText:
                                          '${Singleton.instance.languages.value.password}',
                                      textInputType: TextInputType.number,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    controller.isloadingCreateroom.value ==
                                            false
                                        ? CustomBotton(
                                            h: 35,
                                            title:
                                                "${Singleton.instance.languages.value.ok}",
                                            ontap: () {
                                              debugPrint("vanak");
                                              unFocus(context);
                                              controller.isDisbleButtonOk
                                                  .value = true;
                                              controller.submit(yourType);
                                            },
                                            isdisble: controller
                                                .isDisbleButtonOk.value,
                                          )
                                        : LoadingAnimationWidget
                                            .staggeredDotsWave(
                                                color: AppColor.primary,
                                                size: 28),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (controller.isenterPassword.value)
                      GestureDetector(
                        onTap: () {
                          controller.isenterPassword.value = false;
                          controller.enterPasswordTextEditController.value =
                              TextEditingController();
                          controller.isWorngPassword.value = false;
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.92),
                          height: height,
                          width: width,
                          child: Center(
                            child: Container(
                              color: Colors.transparent,
                              height: 230,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  yourType == 0
                                      ? SvgPicture.asset(
                                          "assets/map/mongkot.svg",
                                          height: 50,
                                          width: 50,
                                        )
                                      : SvgPicture.asset(
                                          "assets/map/hat.svg",
                                          height: 50,
                                          width: 50,
                                        ),
                                  CustomTextfile(
                                    controller: controller
                                        .enterPasswordTextEditController.value,
                                    hintText:
                                        '${Singleton.instance.languages.value.password}',
                                    textInputType: TextInputType.number,
                                    onchanged: (value) {
                                      controller.isWorngPassword.value = false;
                                      if (value == '') {
                                        controller.isDisbleButtomJoin.value =
                                            true;
                                      } else {
                                        controller.isDisbleButtomJoin.value =
                                            false;
                                      }
                                    },
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${Singleton.instance.languages.value.wrongPassword}",
                                      style: TextStyle(
                                          color:
                                              controller.isWorngPassword.value
                                                  ? Colors.white
                                                  : Colors.transparent),
                                    ),
                                  ),
                                  CustomBotton(
                                    title:
                                        "${Singleton.instance.languages.value.join}",
                                    ontap: () {
                                      controller.join();
                                    },
                                    isdisble:
                                        controller.isDisbleButtomJoin.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (controller.isNoMoreLife.value)
                      CustomNoLife(
                        ontapVideo: () {
                          Get.to(const CustomFree5Life());
                          controller.isNoMoreLife.value = false;
                        },
                        ontap: () {
                          controller.isNoMoreLife.value = false;
                        },
                      ),
                  ],
                )),
              )),
    );
  }
}
