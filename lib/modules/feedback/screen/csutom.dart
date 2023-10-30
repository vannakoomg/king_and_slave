import 'package:animation_aba/const/appcolor.dart';
import 'package:flutter/material.dart';

class CustomTextfield02 extends StatelessWidget {
  final double high;
  final String hintText;
  final Function? onChanged;
  final Widget? prefixIcon;
  final Widget? subfix;
  final TextInputType textInputType;
  final TextEditingController? textEditController;
  final bool autofocus;
  final int maxLines;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final int? maxLength;
  final Color? color;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final bool isDense;
  const CustomTextfield02({
    super.key,
    required this.onChanged,
    required this.textEditController,
    this.textStyle,
    this.hintText = '',
    this.textInputType = TextInputType.text,
    this.autofocus = false,
    this.focusNode,
    this.high = 0,
    this.hintTextStyle,
    this.maxLines = 1,
    this.color,
    this.subfix,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.isDense = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: high == 0 ? null : high,
      padding: const EdgeInsets.only(left: 10, right: 8),
      child: TextField(
        textAlign: textAlign,
        focusNode: focusNode,
        autofocus: autofocus,
        controller: textEditController,
        style: textStyle,
        onChanged: (value) {
          onChanged!(value);
        },
        enableSuggestions: false,
        autocorrect: false,
        maxLength: maxLength == 0 ? null : maxLength,
        keyboardType: textInputType,
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 8, top: 8),
          prefixIcon: prefixIcon,
          suffix: subfix,
          prefixIconConstraints: const BoxConstraints(),
          border: InputBorder.none,
          hintText: hintText,
          counterText: "",
          hintStyle:
              TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
          isDense: isDense,
        ),
        maxLines: maxLines == 0 ? null : maxLines,
      ),
    );
  }
}
