import 'dart:math';

import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNoLife extends StatelessWidget {
  final Function ontapVideo;
  final Function ontap;
  const CustomNoLife(
      {super.key, required this.ontapVideo, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / (4 / 3) + 40 + 20,
              width: MediaQuery.of(context).size.width / (4 / 3) + 20,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.width / (4 / 3) + 40,
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  decoration: BoxDecoration(
                      color: const Color(0xffffc4d6),
                      borderRadius: BorderRadius.circular(70)),
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${Singleton.instance.languages.value.noLife}",
                      style: TextStyle(
                          fontSize: 28,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/noLife/${Random().nextInt(3) + 1}.svg",
                      height: 120,
                      width: 120,
                    ),
                    const Spacer(),
                    Text(
                      "${Singleton.instance.languages.value.nextDayYouGetX5life}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffff5d8f),
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        ontapVideo();
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.primary,
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.ondemand_video_rounded,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${Singleton.instance.languages.value.x5}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primary, width: 2),
                    color: const Color(0xffffc4d6),
                    shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: AppColor.primary,
                    size: 30,
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
