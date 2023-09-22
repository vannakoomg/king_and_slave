import 'package:animation_aba/modules/game/controller/room_controller.dart';
import 'package:animation_aba/modules/game/screens/game_screen.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:animation_aba/utils/widgets/custom_textfile.dart';
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
                      const Text("ROOM"),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            controller.createRoom();
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: controller.roomData.length + 20,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.roomData[i].password == '') {
                          Get.to(() => const GameScreen(), arguments: 1);
                        } else {
                          controller.isenterPassword.value = true;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        margin: const EdgeInsets.only(top: 10),
                        height: 50,
                        width: double.infinity,
                        color: Colors.pink,
                        // child: Row(children: [
                        //   Text("${controller.roomData[i].roomName}"),
                        //   const Spacer(),
                        //   if (controller.roomData[i].password != "")
                        //     const Icon(Icons.lock)
                        // ]
                        // ),
                      ),
                    );
                  },
                )),
                Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.red,
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
                          onchanged: (value) {
                            controller.onchangeRoomName(value);
                          },
                          hintText: 'Room Name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextfile(
                          controller:
                              controller.passwordTextEditController.value,
                          onchanged: (value) {
                            controller.onchangePassword(value);
                          },
                          hintText: 'Password',
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomBotton(
                          title: "OK",
                          ontap: () {
                            controller.submit();
                          },
                          isdisble:
                              controller.roomName.value == '' ? true : false,
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
                          onchanged: (value) {
                            controller.onchangeEnterPassword(value);
                          },
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
                          isdisble: controller.enterPassword.value == ''
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
