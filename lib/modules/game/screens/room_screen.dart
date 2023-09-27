import 'package:animation_aba/modules/game/controller/room_controller.dart';
import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/modules/game/screens/game_screen.dart';
import 'package:animation_aba/modules/game/screens/room_style.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:animation_aba/utils/widgets/custom_textfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Container(
                decoration: const BoxDecoration(
                    // color: Colors.black.withOpacity(0.9),
                    // image: DecorationImage(
                    //     image: AssetImage("assets/background/game.png"),
                    //     fit: BoxFit.fitHeight),
                    ),
                height: height,
                width: width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    yourType == 0
                        ? Image.asset("assets/map/mongkot.png")
                        : Image.asset("assets/map/hat.png"),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          yourType == 0 ? "K I N G" : "S L A V E",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<List<RoomModel>>(
                        stream: FirebaseFirestore.instance
                            .collection('room')
                            .where("type", isEqualTo: yourType == 0 ? 1 : 0)
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
                                  return GestureDetector(
                                    onTap: () {
                                      if (snapshots.data![i].password != '') {
                                        controller.roomId.value =
                                            snapshots.data![i].id!;
                                        controller.roomPassword.value =
                                            snapshots.data![i].password!;
                                        controller.isenterPassword.value = true;
                                      } else {
                                        final play = FirebaseFirestore.instance
                                            .collection('room')
                                            .doc(snapshots.data![i].id!);
                                        play.update({"slave.index": -1}).then(
                                            (value) => {
                                                  Get.to(
                                                    () => GameScreen(
                                                        id: snapshots
                                                            .data![i].id!,
                                                        you: yourType),
                                                  )
                                                });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 5, left: 5),
                                      child: CustomPaint(
                                        size: Size(
                                            MediaQuery.of(context).size.width,
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
                                              Text(
                                                "${snapshots.data![i].name}",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              const Spacer(),
                                              if (snapshots.data![i].password !=
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
                                  );
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
                        debugPrint("kkkkk ${controller.isCreateRoom.value}");
                        controller.createRoom();
                        controller.isCreateRoom.value = true;
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
                              color: const Color.fromARGB(255, 229, 64, 64)
                                  .withOpacity(0.5),
                              spreadRadius: 15,
                              blurRadius: 40,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                          // border: Border.all(color: Colors.pink),
                        ),
                        child: const Center(
                          child: Text(
                            "C R E A T E",
                            style: TextStyle(
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
                          height: 280,
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
                                hintText: 'Room Name',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfile(
                                controller:
                                    controller.passwordTextEditController.value,
                                hintText: 'Password',
                                textInputType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomBotton(
                                title: "OK",
                                ontap: () {
                                  controller.submit(yourType);
                                },
                                isdisble: controller.roomNameTextEditController
                                            .value.text ==
                                        ''
                                    ? true
                                    : false,
                              ),
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
                              hintText: 'Enter Password',
                              textInputType: TextInputType.number,
                              onchanged: (value) {
                                controller.isWorngPassword.value = false;
                              },
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "wrong password",
                                style: TextStyle(
                                    color: controller.isWorngPassword.value
                                        ? Colors.white
                                        : Colors.transparent),
                              ),
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            CustomBotton(
                              title: "JOIN",
                              ontap: () {
                                controller.join();
                              },
                              isdisble: controller
                                          .enterPasswordTextEditController
                                          .value
                                          .text ==
                                      ''
                                  ? true
                                  : false,
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
