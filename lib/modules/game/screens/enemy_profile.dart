import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EnemyPrifile extends StatelessWidget {
  final String name;
  final String avatar;
  const EnemyPrifile({super.key, required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        controller.isEnemyProfile.value = false;
      },
      child: Container(
        color: Colors.black.withOpacity(0.6),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Stack(
            children: [
              SvgPicture.asset(
                avatar,
                height: MediaQuery.of(context).size.width / (3 / 2),
                width: MediaQuery.of(context).size.width / (3 / 2),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.98),
                    ),
                    child: Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
