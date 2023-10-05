import 'package:animation_aba/utils/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'modules/slash/screens/slash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // RequestConfiguration requestion =
  //     RequestConfiguration(testDeviceIds: ["33BE2250B43518CCDA7DE426D04EE231"]);
  // MobileAds.instance.updateRequestConfiguration(requestion);
  await Firebase.initializeApp();
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
