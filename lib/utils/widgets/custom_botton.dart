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
          ontap();
        },
        child: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 229, 64, 64).withOpacity(0.5),
                spreadRadius: 20,
                blurRadius: 40,
                offset: const Offset(0, 2), // changes position of shadow
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
