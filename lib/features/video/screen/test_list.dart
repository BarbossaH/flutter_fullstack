import 'package:amazone_clone/features/video/screen/control_device.dart';
import 'package:amazone_clone/features/video/screen/display_media_screen.dart';
import 'package:amazone_clone/features/video/screen/media_screen.dart';
import 'package:flutter/material.dart';

class TestList extends StatelessWidget {
  static const String routeName = 'test-list-screen';
  const TestList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RTC Sample"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('GetUserMedia'),
            onTap: () {
              Navigator.pushNamed(context, UserMedia.routeName);
            },
          ),
          ListTile(
            title: const Text('DisplayMedia'),
            onTap: () {
              Navigator.pushNamed(context, DisplayMedia.routeName);
            },
          ),
          ListTile(
            title: const Text('ControlDevice'),
            onTap: () {
              Navigator.pushNamed(context, ControlDevice.routeName);
            },
          ),
        ],
      ),
    );
  }
}
