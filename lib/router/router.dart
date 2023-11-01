import 'package:animation_aba/modules/feedback/screen/feedback_screen.dart';
import 'package:animation_aba/modules/game/screens/game_screen.dart';
import 'package:animation_aba/modules/game/screens/room_screen.dart';
import 'package:animation_aba/modules/home/screens/home_screen.dart';
import 'package:animation_aba/modules/settings/screens/customize_screen.dart';
import 'package:animation_aba/modules/settings/screens/setting_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
        path: '/room',
        builder: (context, state) {
          return const RoomScreen();
        },
        routes: [
          GoRoute(
            path: 'game-play',
            builder: (context, state) {
              return const GameScreen(
                id: '',
                you: 1,
              );
            },
          ),
        ]),
    GoRoute(
        path: '/setting',
        builder: (context, state) {
          return const SettingScreen();
        },
        routes: [
          GoRoute(
            path: 'feedback',
            builder: (context, state) {
              return const FeedBackScreen();
            },
          ),
          GoRoute(
            path: 'customize',
            builder: (context, state) {
              return const CustomizeScreen();
            },
          ),
        ]),
  ],
);
