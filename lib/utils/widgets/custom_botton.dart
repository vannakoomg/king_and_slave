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
      child: SizedBox(
          height: 50,
          child: Row(
            children: [
              const Spacer(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Colors.pink,
                  child: Text(title)),
              const Spacer(),
            ],
          )),
    );
  }
}
