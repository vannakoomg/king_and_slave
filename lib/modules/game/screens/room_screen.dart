import 'package:animation_aba/modules/game/controller/room_controller.dart';
import 'package:animation_aba/modules/game/models/room_model.dart';
import 'package:animation_aba/modules/game/screens/game_screen.dart';
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
        body: Obx(
      () => SafeArea(
          child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            color: Colors.white,
            height: height,
            width: width,
            child: Column(
              children: [
                Container(
                  color: Colors.green,
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(yourType == 0 ? "King" : "Slave"),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          controller.createRoom();
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
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
                                  final play = FirebaseFirestore.instance
                                      .collection('room')
                                      .doc(snapshots.data![i].id!);
                                  play.update({"slave.index": -1}).then(
                                      (value) => {
                                            Get.to(
                                              () => GameScreen(
                                                  id: snapshots.data![i].id!,
                                                  you: yourType),
                                            )
                                          });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  width: double.infinity,
                                  color: Colors.red,
                                  child: Row(
                                    children: [
                                      Text("${snapshots.data![i].name}"),
                                      const Spacer(),
                                      if (snapshots.data![i].password != '')
                                        const Icon(Icons.lock)
                                    ],
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
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          if (controller.isCreateRoom.value)
            GestureDetector(
              onTap: () {
                controller.isCreateRoom.value = false;
              },
              child: Container(
                color: Colors.black.withOpacity(0.7),
                height: height,
                width: width,
                child: Center(
                  child: Container(
                    color: Colors.white,
                    height: 240,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomTextfile(
                          controller:
                              controller.roomNameTextEditController.value,
                          hintText: 'Room Name',
                        ),
                        const SizedBox(
                          height: 20,
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
                          isdisble: controller
                                      .roomNameTextEditController.value.text ==
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
          if (controller.isenterPassword.value)
            GestureDetector(
              onTap: () {
                controller.isenterPassword.value = false;
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                height: height,
                width: width,
                child: Center(
                  child: Container(
                    color: Colors.white,
                    height: 240,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomTextfile(
                          controller:
                              controller.enterPasswordTextEditController.value,
                          hintText: 'Enter Password',
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBotton(
                          title: "JOIN",
                          ontap: () {
                            controller.join();
                          },
                          isdisble: controller.enterPasswordTextEditController
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
            )
        ],
      )),
    ));
  }
}
