// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CountTimte extends StatelessWidget {
  int time;
  CountTimte({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          height: 5,
          width: MediaQuery.of(context).size.width * time / 120,
          decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.white, width: 0.8)),
        ));
  }
}
