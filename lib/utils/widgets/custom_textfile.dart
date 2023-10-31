import 'package:animation_aba/const/appcolor.dart';
import 'package:flutter/material.dart';
import '../../modules/game/screens/room_style.dart';

class CustomTextfile extends StatelessWidget {
  final TextEditingController controller;
  final Function? onchanged;
  final String? hintText;
  final TextInputType textInputType;
  final int maxLength;
  const CustomTextfile({
    super.key,
    required this.controller,
    this.onchanged,
    this.maxLength = 1,
    this.textInputType = TextInputType.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("iiiiiiiiiiii ${MediaQuery.of(context).size.width}");
    return CustomPaint(
      painter: TextfileStyle(),
      child: Container(
        width: MediaQuery.of(context).size.width > 900
            ? 900
            : MediaQuery.of(context).size.width,
        height: 50,
        padding: const EdgeInsets.only(left: 80, right: 40, top: 10),
        child: TextFormField(
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          keyboardType: textInputType,
          controller: controller,
          cursorColor: AppColor.primary,
          onChanged: (value) {
            onchanged == null ? () {} : onchanged!(value);
          },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 8, bottom: 8),
              isDense: true,
              border: InputBorder.none,
              hintText: "$hintText",
              hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.8), fontSize: 14)),
        ),
      ),
    );
  }
}
