import 'package:animation_aba/const/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomOwnTextfile extends StatefulWidget {
  final Function onChange;
  final Function onSaveMessage;
  const CustomOwnTextfile({
    super.key,
    required this.onChange,
    required this.onSaveMessage,
  });

  @override
  CustomOwnTextfileState createState() => CustomOwnTextfileState();
}

class CustomOwnTextfileState extends State<CustomOwnTextfile> {
  final TextEditingController _controller = TextEditingController();
  final controlleeeee = Get.put(Controler());
  @override
  Widget build(BuildContext context) {
    _controller.text = controlleeeee.textInput.value;
    return Obx(() => Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.5),
          child: Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      color: Colors.black,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.97),
                            borderRadius: BorderRadius.circular(70)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                cursorColor: AppColor.primary,
                                textAlign: TextAlign.justify,
                                controller: _controller,
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(color: Colors.white),
                                  contentPadding: EdgeInsets.only(
                                      left: 10, right: 8, top: 4, bottom: 4),
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                autofocus: true,
                                showCursor: true,
                                readOnly: true,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            GestureDetector(
                                onTap: () {
                                  widget.onSaveMessage();
                                  _controller.text = "";
                                  widget.onChange("");
                                  controlleeeee.textInput.value = "";
                                },
                                child: AnimatedContainer(
                                  height: 25,
                                  width: 25,
                                  duration: const Duration(milliseconds: 250),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controlleeeee.textInput.value != ''
                                        ? AppColor.primary
                                        : Colors.transparent,
                                  ),
                                  child: const Center(
                                      child: Icon(
                                    Icons.arrow_upward_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller.text = "";
                      widget.onChange("");
                      controlleeeee.textInput.value = "";
                    },
                    child: Container(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(3.14),
                      transformAlignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 2, right: 2),
                      height: 27,
                      width: 27,
                      color: Colors.transparent,
                      child: const Center(
                          child: Icon(
                        Icons.cut,
                        color: Colors.white,
                      )),
                    ),
                  )
                ],
              ),
              CustomKeyboard(
                ontap: widget.onSaveMessage,
                onTextInput: (myText) {
                  _insertText(myText);
                },
                onBackspace: () {
                  _backspace();
                },
              ),
            ],
          ),
        ));
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    controlleeeee.textInput.value = newText;
    widget.onChange(newText);
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );

      return;
    }

    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
    widget.onChange(newText);
    controlleeeee.textInput.value = newText;
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomKeyboard extends StatelessWidget {
  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;
  final Function ontap;
  const CustomKeyboard({
    super.key,
    required this.onTextInput,
    required this.onBackspace,
    required this.ontap,
  });

  void deleteText() => onBackspace.call();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controler());
    return Obx(() => GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.only(left: 1, right: 1),
            height: MediaQuery.of(context).size.width / 1.9,
            color: Colors.black,
            child: controller.isEmoji.value
                ? Column(
                    children: [
                      buildRow(controller.emoji1, EdgeInsets.zero,
                          controller.isUpperCase.value),
                      buildRow(controller.emoji2, EdgeInsets.zero,
                          controller.isUpperCase.value),
                      buildRow4(controller.emoji3, EdgeInsets.zero,
                          controller.isUpperCase.value, () {}),
                      buildRowThree(ontap),
                    ],
                  )
                : controller.isSymbol.value
                    ? Column(
                        children: [
                          buildRow(controller.symbol1, EdgeInsets.zero,
                              controller.isUpperCase.value),
                          buildRow(controller.symbol2, EdgeInsets.zero,
                              controller.isUpperCase.value),
                          buildRow4(controller.symbol3, EdgeInsets.zero,
                              controller.isUpperCase.value, () {}),
                          buildRowThree(ontap),
                        ],
                      )
                    : Column(
                        children: [
                          buildRow(controller.enRow1, EdgeInsets.zero,
                              controller.isUpperCase.value),
                          buildRow(
                              controller.enRow2,
                              const EdgeInsets.only(left: 30, right: 30),
                              controller.isUpperCase.value),
                          buildRow3(
                              controller.enRow3,
                              const EdgeInsets.only(left: 20, right: 20),
                              controller.isUpperCase.value, () {
                            controller.isUpperCase.value =
                                !controller.isUpperCase.value;
                          }),
                          buildRowThree(ontap),
                        ],
                      ),
          ),
        ));
  }

  Expanded buildRow(List<String> letter, EdgeInsets pedding, bool isUpperCase) {
    return Expanded(
      child: Container(
        padding: pedding,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: letter.map((e) {
                  return Textyyyyyyy(
                    text: isUpperCase ? e.toUpperCase() : e,
                    onTextInput: onTextInput,
                    isUpperCase: isUpperCase,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildRow3(List<String> letter, EdgeInsets pedding, bool isUpperCase,
      Function ontap) {
    return Expanded(
      child: Container(
        padding: pedding,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                ontap();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.primary.withOpacity(0.3),
                ),
                margin: const EdgeInsets.only(right: 2, top: 2),
                width: 45,
                child: SvgPicture.asset(
                    !isUpperCase ? "assets/chat/3.svg" : "assets/chat/4.svg"),
              ),
            ),
            Expanded(
              child: Row(
                children: letter.map((e) {
                  return Textyyyyyyy(
                    text: e,
                    onTextInput: onTextInput,
                    isUpperCase: isUpperCase,
                  );
                }).toList(),
              ),
            ),
            GestureDetector(
              onTap: () {
                deleteText();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffff0a54)),
                margin: const EdgeInsets.only(left: 2, top: 5, bottom: 3),
                width: 45,
                child: const Center(
                    child: Icon(
                  Icons.backspace_sharp,
                  color: Colors.white,
                  size: 18,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildRow4(List<String> letter, EdgeInsets pedding, bool isUpperCase,
      Function ontap) {
    return Expanded(
      child: Container(
        padding: pedding,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: letter.map((e) {
                  return e != ""
                      ? Textyyyyyyy(
                          text: e,
                          onTextInput: onTextInput,
                          isUpperCase: isUpperCase,
                        )
                      : Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              deleteText();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 4, left: 2, right: 3, bottom: 2),
                              decoration: BoxDecoration(
                                  color: const Color(0xffff0a54),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Icon(
                                Icons.backspace_sharp,
                                color: Colors.black,
                                size: 16,
                              )),
                            ),
                          ),
                        );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildRowThree(Function ontapSend) {
    final controler = Get.put(Controler());
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 6, bottom: 8, left: 2, right: 2),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                controler.isSymbol.value = !controler.isSymbol.value;
                controler.isEmoji.value = false;
              },
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(1),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  controler.isSymbol.value ? "ABC" : "❆ π ♪",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                controler.isEmoji.value = !controler.isEmoji.value;
              },
              child: AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 230),
                margin: const EdgeInsets.only(left: 4),
                width: 40,
                decoration: BoxDecoration(
                    color: controler.isEmoji.value
                        ? Colors.white.withOpacity(1)
                        : Colors.pink.withOpacity(1),
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                    child: Text(
                  "🎃",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
              ),
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {
                onTextInput.call(" ");
              },
              child: Container(
                margin: const EdgeInsets.only(left: 4, right: 4),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 229, 42, 98),
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                    child: Text(
                  "Space",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )),
            GestureDetector(
              onTap: () {
                ontapSend();
              },
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    controler.send.value,
                    style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Textyyyyyyy extends StatelessWidget {
  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;
  final bool isUpperCase;
  const Textyyyyyyy({
    super.key,
    required this.text,
    required this.onTextInput,
    required this.isUpperCase,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: InkWell(
            onTap: () {
              onTextInput.call(text);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xffff5c8a),
                  borderRadius: BorderRadius.circular(5)),
              margin:
                  const EdgeInsets.only(left: 1, right: 1, top: 4, bottom: 2),
              child: Center(
                  child: Text(
                isUpperCase ? text.toUpperCase() : text.toLowerCase(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
          ),
        ));
  }
}

class Controler extends GetxController {
  final send = 'Send'.obs;
  final isUpperCase = false.obs;
  final isSymbol = false.obs;
  final isEmoji = false.obs;
  final textInput = "".obs;
  final enRow1 = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"];
  final enRow2 = ["a", "s", "d", "f", "g", "h", "j", "k", "l"];
  final enRow3 = ["z", "x", "c", "v", "b", "n", "m"];
  final symbol1 = ["☾", "⅕", "➵", "♪♫", "0", "1", "•", "≠", "⌗", "‱"];
  final symbol2 = ["π", "∞", "％", "∛", "∅", "∆", "∫", "∥", "=", "∡"];
  final symbol3 = ["⍬", "♟", "卐", "៛", "❆", "⌘", "℃", "＠", "♞", ""];
  final emoji1 = ["😂", "😄", "🤪", "😉", "😝", "🤫", "🤧", "😱", "😏", "😇"];
  final emoji2 = ["🤑", "🥶️", "🥴️", "😬", "🤮", "🤯", "😑", "😵", "👽", "👻"];
  final emoji3 = ["🙈", "🤖", "🤡", "🔪", "😈", "🌹", "💖", "💘", "💞", ""];
}
