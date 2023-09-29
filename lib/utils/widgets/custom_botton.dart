import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  final String title;
  final Function ontap;
  final bool isdisble;

  const CustomBotton(
      {super.key,
      required this.title,
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
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: isdisble ? Colors.white : Colors.pink.withOpacity(0.5),
                spreadRadius: isdisble ? 1 : 20,
                blurRadius: isdisble ? 30 : 40,
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
