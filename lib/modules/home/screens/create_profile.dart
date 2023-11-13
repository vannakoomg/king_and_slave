import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/main.dart';
import 'package:animation_aba/modules/home/controller/home_controller.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/custom_textfile.dart';

class ProfielScreen extends StatelessWidget {
  const ProfielScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(() => Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              controller.page.value == 0
                  ? "${Singleton.instance.languages.value.avatar}"
                  : "${Singleton.instance.languages.value.nickName}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              // height: 160,
              child: controller.page.value == 0
                  ? Wrap(
                      alignment: WrapAlignment.center,
                      children:
                          controller.imagePrifile.asMap().entries.map((e) {
                        return GestureDetector(
                          onTap: () {
                            controller.selecteProfile(e.key);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 3, right: 3, top: 6),
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.width / 6,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(e.value),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  width: 3,
                                  color: controller.index.value == e.key
                                      ? AppColor.primary
                                      : Colors.black,
                                )),
                            child: SvgPicture.asset(e.value),
                          ),
                        );
                      }).toList(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextfile(
                          autofous: true,
                          controller: controller.userNameController.value,
                          hintText:
                              "${Singleton.instance.languages.value.nickName}",
                          onchanged: (value) {
                            controller.userName.value = value;
                          },
                        ),
                      ],
                    ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomBotton(
              h: 40,
              w: 120,
              title: controller.page.value == 0
                  ? "${Singleton.instance.languages.value.ok}"
                  : "${Singleton.instance.languages.value.create}",
              ontap: () {
                unFocus(context);
                controller.onTap();
              },
              isdisble:
                  controller.page.value == 1 && controller.userName.value == ''
                      ? true
                      : false,
            ),
          ]),
        ));
  }
}
