import 'package:get/get.dart';

class Language extends GetxController {
  static Language? _instance;
  Language._();
  static Language get instance => _instance ??= Language._();
  final language = LanguageModel(name: "vannk");
}

class LanguageModel {
  String? name;

  LanguageModel({this.name});
}
