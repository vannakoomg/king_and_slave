import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      color: Colors.green,
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        onChanged: (value) {
          onchanged == null ? () {} : onchanged!(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "$hintText",
        ),
      ),
    );
  }
}
