import 'package:amazone_clone/common/widgets/bottom_bar.dart';
import 'package:amazone_clone/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone/features/home/screen/home_screen.dart';
import 'package:amazone_clone/features/video/screen/control_device.dart';
import 'package:amazone_clone/features/video/screen/display_media_screen.dart';
import 'package:amazone_clone/features/video/screen/media_screen.dart';
import 'package:amazone_clone/features/video/screen/peer_connect.dart';
import 'package:amazone_clone/features/video/screen/test_list.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case UserMedia.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const UserMedia());
    case DisplayMedia.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const DisplayMedia());
    case ControlDevice.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ControlDevice());
    case PeerConnection.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PeerConnection());
    case TestList.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const TestList());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Screen does not exist"),
                ),
              ));
  }
}
