import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomResult extends StatelessWidget {
  final String status;
  final String roomId;
  const CustomResult({super.key, required this.status, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.2),
        child: Center(
            child: Stack(
          children: [
            Center(
              child: Container(
                height: 1,
                width: 1,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 246, 208, 15)
                          .withOpacity(0.5),
                      spreadRadius: 100,
                      blurRadius: 60,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Center(
                child: Text(
              status == "enemy_surrender"
                  ? "ENEMY SURRENDER"
                  : status == "you_surrender"
                      ? "YOU SURRENDER"
                      : status == "win"
                          ? "YOU WIN"
                          : status == "lose"
                              ? "YOU LOSE"
                              : "WE DROU",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            )),
            Positioned(
              bottom: 0,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 17, 17, 16)
                          .withOpacity(0.9),
                      spreadRadius: 100,
                      blurRadius: 40,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            if (status != "drou")
              Positioned(
                bottom: 10,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CustomBotton(
                          title: "Next",
                          ontap: () {
                            final play = FirebaseFirestore.instance
                                .collection('room')
                                .doc(roomId);
                            if (status == "enemy_surrender") {
                              Get.back();
                              play.delete();
                            } else {
                              Get.back();
                            }
                          },
                          isdisble: false),
                    )),
              )
          ],
        )));
  }
}
