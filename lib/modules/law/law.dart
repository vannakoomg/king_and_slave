import 'package:animation_aba/utils/controller/singleton.dart';
import 'package:animation_aba/utils/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LawScreen extends StatelessWidget {
  const LawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Container(
            color: Colors.black.withOpacity(0.9),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: MediaQuery.of(context).padding.top + 60),
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  "${Singleton.instance.languages.value.law}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //     Singleton.instance.languages.value.lawDetail!
                //         .replaceAll(r'\n', '\n'),
                //     style: TextStyle(
                //         color: Colors.white.withOpacity(0.7), fontSize: 18)),
                SvgPicture.asset(
                  "assets/setting/appsara.svg",
                  height: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomBotton(
                    title: "${Singleton.instance.languages.value.ok}",
                    ontap: () async {
                      // controller.isFirst.value = false;
                      // final SharedPreferences obj =
                      //     await SharedPreferences.getInstance();
                      // obj.setString('first', 'have');
                    },
                    isdisble: false)
              ]),
            ),
          )),
    );
  }
}
