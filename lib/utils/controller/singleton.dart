import 'package:animation_aba/utils/models/landuage_model.dart';
import 'package:get/get.dart';

class Singleton extends GetxController {
  static Singleton? _instance;
  Singleton._();
  static Singleton get instance => _instance ??= Singleton._();
  final back = ''.obs;
  final map = ''.obs;
  final king = ''.obs;
  final slave = ''.obs;
  final soldier = ''.obs;
  LanguageModel languages = LanguageModel();
}
