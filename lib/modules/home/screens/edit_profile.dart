import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/modules/home/controller/home_controller.dart';
import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/custom_textfile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    controller.userNameController.value.text =
        Singleton.instance.nickName.value;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "${Singleton.instance.languages.value.updateProfile}",
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Obx(() => Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                controller.editPrifile.value,
                                height: MediaQuery.of(context).size.width * 0.5,
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: controller.imageEdit
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.seletedProfileEdit(e.key);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 3, right: 3, top: 6),
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.width / 6,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(e.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: SvgPicture.asset(e.value),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextfile(
                                      controller:
                                          controller.userNameController.value,
                                      hintText:
                                          "${Singleton.instance.languages.value.nickName}",
                                      onchanged: (value) {
                                        controller.userName.value =
                                            value.toString().trim();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  CustomBotton(
                      h: 40,
                      w: 120,
                      title: "${Singleton.instance.languages.value.ok}",
                      ontap: () {
                        controller.edit();
                      },
                      isdisble: controller.userName.value == '' ? true : false),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ))),
    );
  }
}
