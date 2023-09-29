import 'package:flutter/material.dart';

import '../../modules/game/screens/room_style.dart';

class CustomTextfile extends StatelessWidget {
  final TextEditingController controller;
  final Function? onchanged;
  final String? hintText;
  final TextInputType textInputType;
  const CustomTextfile({
    super.key,
    required this.controller,
    this.onchanged,
    this.textInputType = TextInputType.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 40
          // (MediaQuery.of(context).size.width *
          //         0.125)
          //     .toDouble(),
          ),
      painter: RoomStyle(),
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        // height: 45,
        child: TextFormField(
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          keyboardType: textInputType,
          controller: controller,
          onChanged: (value) {
            onchanged == null ? () {} : onchanged!(value);
          },
          decoration: InputDecoration(
              isDense: false,
              border: InputBorder.none,
              hintText: "$hintText",
              hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.8), fontSize: 14)),
        ),
      ),
    );
  }
}
