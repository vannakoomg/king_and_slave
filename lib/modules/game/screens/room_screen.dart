import 'package:animation_aba/modules/game/controller/room_controller.dart';
import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/modules/game/screens/game_screen.dart';
import 'package:animation_aba/modules/game/screens/room_style.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/models/landuage_model.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:animation_aba/utils/widgets/custom_textfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    controller.type.value = yourType;
    debugPrint("dfdsf ${controller.type.value}");
    return Scaffold(
        backgroundColor: Colors.black,
        body: Obx(
          () => SafeArea(
              child: Stack(
            children: [
              SizedBox(
                height: height,
                width: width,
                child: Column(
                  children: [
                    yourType == 0
                        ? Image.asset("assets/map/mongkot.png")
                        : Image.asset("assets/map/hat.png"),
                    Text(
                      yourType == 0
                          ? "${Singleton.instance.languages.value.king}"
                          : "${Singleton.instance.languages.value.slave}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    StreamBuilder<List<RoomModel>>(
                        stream: FirebaseFirestore.instance
                            .collection('room')
                            .orderBy("createDate", descending: true)
                            .snapshots()
                            .map(
                              (snapshots) => snapshots.docs
                                  .map((doc) => RoomModel.fromJson(doc.data()))
                                  .toList(),
                            ),
                        builder: (context, snapshots) {
                          if (snapshots.hasError) {
                            return const Expanded(
                                child: Center(
                              child: Text("Error Data "),
                            ));
                          } else if (snapshots.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: snapshots.data!.length,
                                itemBuilder: (context, i) {
                                  return snapshots.data![i].slave!.index == -2
                                      ? GestureDetector(
                                          onTap: () {
                                            if (Singleton.instance.life.value >
                                                0) {
                                              if (snapshots.data![i].password !=
                                                  '') {
                                                controller.roomId.value =
                                                    snapshots.data![i].id!;
                                                controller.roomPassword.value =
                                                    snapshots
                                                        .data![i].password!;
                                                controller.isenterPassword
                                                    .value = true;
                                              } else {
                                                final play = FirebaseFirestore
                                                    .instance
                                                    .collection('room')
                                                    .doc(
                                                        snapshots.data![i].id!);
                                                play.update({
                                                  "slave.index": -1
                                                }).then((value) => {
                                                      Get.to(
                                                        () => GameScreen(
                                                            id: snapshots
                                                                .data![i].id!,
                                                            you: yourType),
                                                      )
                                                    });
                                              }
                                            } else {
                                              debugPrint(
                                                  "You have no life more ");
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 5, left: 5),
                                            child: CustomPaint(
                                              size: Size(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  40
                                                  // (MediaQuery.of(context).size.width *
                                                  //         0.125)
                                                  //     .toDouble(),
                                                  ),
                                              painter: RoomStyle(),
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 30, right: 30),
                                                height: 45,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "${snapshots.data![i].name}",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.7),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                    ),
                                                    if (snapshots.data![i]
                                                            .password !=
                                                        '')
                                                      Image.asset(
                                                        "assets/shield/2.png",
                                                        width: 30,
                                                        height: 30,
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                            );
                          } else {
                            return const Expanded(
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.red,
                              )),
                            );
                          }
                        }),
                    GestureDetector(
                      onTap: () {
                        controller.createRoom();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 20, left: 5, right: 5),
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.5),
                              spreadRadius: 15,
                              blurRadius: 40,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "${Singleton.instance.languages.value.create}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
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
                      color: Colors.black.withOpacity(0.85),
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
                                  ? Image.asset(
                                      "assets/map/mongkot.png",
                                      height: 70,
                                      width: 70,
                                    )
                                  : Image.asset(
                                      "assets/map/hat.png",
                                      height: 70,
                                      width: 70,
                                    ),
                              CustomTextfile(
                                controller:
                                    controller.roomNameTextEditController.value,
                                hintText:
                                    '${Singleton.instance.languages.value.roomName}',
                                onchanged: (value) {
                                  if (value == '') {
                                    controller.isDisbleButtonOk.value = true;
                                  } else {
                                    controller.isDisbleButtonOk.value = false;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfile(
                                controller:
                                    controller.passwordTextEditController.value,
                                hintText:
                                    '${Singleton.instance.languages.value.password}',
                                textInputType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              controller.isloadingCreateroom.value == false
                                  ? CustomBotton(
                                      title:
                                          "${Singleton.instance.languages.value.ok}",
                                      ontap: () {
                                        controller.isDisbleButtonOk.value =
                                            true;
                                        controller.submit(yourType);
                                      },
                                      isdisble:
                                          controller.isDisbleButtonOk.value,
                                    )
                                  : LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.pink, size: 28),
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
                    color: Colors.black.withOpacity(0.9),
                    height: height,
                    width: width,
                    child: Center(
                      child: Container(
                        color: Colors.transparent,
                        height: 230,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            yourType == 0
                                ? Image.asset(
                                    "assets/map/mongkot.png",
                                    height: 70,
                                    width: 70,
                                  )
                                : Image.asset(
                                    "assets/map/hat.png",
                                    height: 70,
                                    width: 70,
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
                                  controller.isDisbleButtomJoin.value = true;
                                } else {
                                  controller.isDisbleButtomJoin.value = false;
                                }
                              },
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${Singleton.instance.languages.value.wrongPassword}",
                                style: TextStyle(
                                    color: controller.isWorngPassword.value
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
                              isdisble: controller.isDisbleButtomJoin.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            ],
          )),
        ));
  }
}
