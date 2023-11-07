import 'package:animation_aba/const/appcolor.dart';
import 'package:flutter/material.dart';
import '../../modules/game/screens/room_style.dart';

class CustomTextfile extends StatelessWidget {
  final TextEditingController controller;
  final Function? onchanged;
  final String? hintText;
  final TextInputType textInputType;
  final Function? onComplete;
  final int maxLength;
  final bool autofous;
  const CustomTextfile({
    super.key,
    required this.controller,
    this.onchanged,
    this.onComplete,
    this.autofous = false,
    this.maxLength = 1,
    this.textInputType = TextInputType.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TextfileStyle(),
      child: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: TextFormField(
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          keyboardType: textInputType,
          controller: controller,
          cursorColor: AppColor.primary,
          onChanged: (value) {
            onchanged == null ? () {} : onchanged!(value);
          },
          onEditingComplete: () {
            onComplete!();
          },
          autofocus: autofous,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 6, bottom: 6),
            isDense: true,
            border: InputBorder.none,
            hintText: "$hintText",
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          ),
        ),
      ),
    );
  }
}
