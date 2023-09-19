import 'package:animation_aba/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/slash/screens/slash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SlashScreen(),
    );
  }
}
