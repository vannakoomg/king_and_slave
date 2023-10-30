import 'package:animation_aba/const/appcolor.dart';
import 'package:animation_aba/main.dart';
import 'package:animation_aba/modules/feedback/controller/feedback_controller.dart';
import 'package:animation_aba/modules/feedback/screen/csutom.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../utils/controller/singleton.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedBackController());
    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "${Singleton.instance.languages.value.feedback}",
              style: const TextStyle(color: Colors.white),
            ),
            leadingWidth: 40,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                unFocus(context);
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${Singleton.instance.languages.value.feedbackTitle}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.9)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AnimatedRotation(
                                  turns:
                                      controller.description.value.length >= 2
                                          ? 1
                                          : 1,
                                  alignment: Alignment.centerRight,
                                  curve: Curves.ease,
                                  duration: const Duration(milliseconds: 200),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            AppColor.primary.withOpacity(0.25),
                                        border: Border.all(
                                            width: 1, color: AppColor.primary)),
                                    child: CustomTextfield02(
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 19),
                                      hintText: Singleton.instance.languages
                                          .value.enterFeedback!,
                                      onChanged: (value) {
                                        controller.description.value = value;
                                      },
                                      textEditController: controller
                                          .descriptionTextController.value,
                                      maxLines: 4,
                                      textInputType: TextInputType.multiline,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      CustomBotton(
                          title: "${Singleton.instance.languages.value.create}",
                          ontap: () {
                            controller.feedback().then((value) {
                              Get.dialog(Scaffold(
                                backgroundColor: Colors.black.withOpacity(0.8),
                                body: Center(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColor.primary,
                                                  blurRadius: 80,
                                                  spreadRadius: 30),
                                            ]),
                                        child: const Text(
                                          "THANK YOU",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25),
                                        ))),
                              ));
                              Future.delayed(const Duration(milliseconds: 3000),
                                  () {
                                Get.back();
                              });
                            });
                            unFocus(context);
                          },
                          isdisble: controller.description.value.length <= 2
                              ? true
                              : false),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )),
              if (controller.isloading.value)
                Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColor.primary, size: 30),
                ),
            ],
          ),
        ));
  }
}
