import 'package:animation_aba/modules/home/screens/home_screen.dart';
import 'package:animation_aba/utils/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await LocalStorage.init();
  WidgetsBinding.instance
      .addObserver(LifecycleEventHandler(detachedCallBack: () async {
    debugPrint("khmer sl khmer 01");
  }, resumeCallBack: () async {
    debugPrint("khmer sl khmer 02");
  }));

  await Future.delayed(const Duration(milliseconds: 1000), () {
    FlutterNativeSplash.remove();
  });

  runApp(const MyApp());
}

void unFocus(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler(
      {required this.resumeCallBack, required this.detachedCallBack});

  final VoidCallback resumeCallBack;
  final VoidCallback detachedCallBack;

//  @override
//  Future<bool> didPopRoute()

//  @override
//  void didHaveMemoryPressure

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        detachedCallBack();
        break;
      case AppLifecycleState.resumed:
        resumeCallBack();
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
//     _log.finest('''
// =============================================================
//                $state
// =============================================================
// ''');
  }

//  @override
//  void didChangeLocale(Locale locale)

//  @override
//  void didChangeTextScaleFactor()

//  @override
//  void didChangeMetrics();

//  @override
//  Future<bool> didPushRoute(String route)
}
