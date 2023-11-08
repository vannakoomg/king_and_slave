import 'package:flutter/material.dart';
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
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(0),
            color: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.97),
                  borderRadius: BorderRadius.circular(70)),
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.justify,
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 16),
                      autofocus: true,
                      showCursor: true,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  if (_controller.text != "")
                    Container(
                      height: 25,
                      width: 30,
                      color: Colors.green,
                    ),
                  GestureDetector(
                      onTap: () {
                        _controller.text = "";
                      },
                      child: const Icon(Icons.golf_course)),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
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
    );
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

  // void _textInputHandler(String text) => onTextInput.call(text);

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
            child: controller.isSymbol.value
                ? Column(
                    children: [
                      buildRow(controller.symbol1, EdgeInsets.zero,
                          controller.isUpperCase.value),
                      buildRow(controller.symbol2, EdgeInsets.zero,
                          controller.isUpperCase.value),
                      buildRow3(controller.symbol3, EdgeInsets.zero,
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
                        debugPrint("dfsfdsfd");
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
          children: letter.map((e) {
            return TextKey(
              text: isUpperCase ? e.toUpperCase() : e,
              onTextInput: onTextInput,
              isUpperCase: isUpperCase,
            );
          }).toList(),
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
                margin: const EdgeInsets.all(4),
                width: 40,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Row(
                children: letter.map((e) {
                  return TextKey(
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
                margin: const EdgeInsets.all(4),
                width: 40,
                color: Colors.white,
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
            Expanded(
                child: GestureDetector(
              onTap: () {
                onTextInput.call(" ");
              },
              child: Container(
                margin: const EdgeInsets.only(left: 4, right: 4),
                decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(0.8),
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
                width: 60,
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

class TextKey extends StatelessWidget {
  const TextKey({
    super.key,
    required this.text,
    required this.onTextInput,
    required this.isUpperCase,
    this.flex = 1,
  });

  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;
  final bool isUpperCase;

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
                  color: Colors.pink, borderRadius: BorderRadius.circular(5)),
              margin:
                  const EdgeInsets.only(left: 1, right: 1, top: 4, bottom: 2),
              child: Center(
                  child: Text(
                isUpperCase ? text.toUpperCase() : text.toLowerCase(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
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
  final enRow1 = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"];
  final enRow2 = ["a", "s", "d", "f", "g", "h", "j", "k", "l"];
  final enRow3 = ["z", "x", "c", "v", "b", "n", "m"];
  final symbol1 = ["☾", "⅕", "➵", "♪♫", "0", "1", "•", "≠", "⌗", "👻"];
  final symbol2 = ["π", "∞", "％", "∛", "∅", "∆", "∫", "∥", "=", "∡"];
  final symbol3 = ["♟", "卐", "៛", "❆", "⌘", "℃", "＠", "♞"];
}
