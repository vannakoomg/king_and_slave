// ignore_for_file: must_be_immutable

import 'package:animation_aba/const/appcolor.dart';
import 'package:flutter/material.dart';

class CountTimte extends StatelessWidget {
  int time;
  CountTimte({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        child: Column(
          children: [
            Container(
              height: 0.8,
              width: MediaQuery.of(context).size.width * time / 120,
              color: Colors.white,
            ),
            Container(
              height: 4,
              width: MediaQuery.of(context).size.width * time / 120,
              decoration: BoxDecoration(
                color: AppColor.primary,
              ),
            ),
          ],
        ));
  }
}
