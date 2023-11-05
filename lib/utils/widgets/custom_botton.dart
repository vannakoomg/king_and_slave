import 'package:animation_aba/const/appcolor.dart';
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
      this.h = 40,
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
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color:
                    isdisble ? Colors.white : AppColor.primary.withOpacity(0.7),
                spreadRadius: isdisble ? 1 : 10,
                blurRadius: isdisble ? 25 : 25,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          )),
        ));
  }
}
