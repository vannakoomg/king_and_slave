import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/game/screens/room_style.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  final String title;
  final Function ontap;
  final bool isdisble;
  final double h;
  final double w;

  const CustomBotton(
      {super.key,
      required this.title,
      this.h = 35,
      this.w = 100,
      required this.ontap,
      required this.isdisble});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (isdisble == false) {
            ontap();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: h,
          width: w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColor.primary.withOpacity(0.6),
                spreadRadius: isdisble ? 1 : 9,
                blurRadius: isdisble ? 25 : 30,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CustomPaint(
            painter: SettingStyle(),
            child: SizedBox(
              height: h,
              width: w,
              child: Center(
                  child: Text(
                title,
                style: TextStyle(
                    color:
                        isdisble ? Colors.white.withOpacity(0.7) : Colors.white,
                    fontSize: Singleton.instance.lang.value == "kh" ? 18 : 15,
                    fontWeight: FontWeight.w500),
              )),
            ),
          ),
        ));
  }
}
