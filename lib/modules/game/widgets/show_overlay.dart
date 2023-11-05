import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/game/controller/game_controller.dart';
import 'package:animation_aba/utils/widgets/custom_textfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

OverlayState? overlayState; //require
OverlayEntry? overlayEntry;
void showOverlay(
  BuildContext context,
) async {
  overlayState = Overlay.of(context);
  overlayEntry = OverlayEntry(
    builder: (_) {
      final controller = Get.put(Controller());
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            overlayEntry?.remove();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 10,
            ),
            color: Colors.transparent,
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfile(
                        autofous: true,
                        controller: controller.chatTextController.value,
                        hintText: '',
                        onchanged: (value) {
                          controller.chatText.value = value;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.sendMessage();
                      },
                      icon: Icon(
                        Icons.send,
                        size: 33,
                        color: AppColor.primary,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  overlayState
      ?.insert(overlayEntry!); //insert overlay eg. showDialog, showOvelay
}
