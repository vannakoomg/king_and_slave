import 'package:animation_aba/utils/models/language_model.dart';
import 'package:get/get.dart';

class Singleton extends GetxController {
  static Singleton? _instance;
  Singleton._();
  static Singleton get instance => _instance ??= Singleton._();
  final back = ''.obs;
  final king = ''.obs;
  final slave = ''.obs;
  final soldier = ''.obs;
  final languages = LanguagesModel().obs;
  final lang = ''.obs;
  final life = 0.obs;
}
