import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class UserMedia extends StatefulWidget {
  static const String routeName = 'media-screen';
  const UserMedia({super.key});

  @override
  State<UserMedia> createState() => _UserMediaState();
}

class _UserMediaState extends State<UserMedia> {
  late MediaStream _localStream;
  final _localRenderer = RTCVideoRenderer();
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  _initRenderers() async {
    await _localRenderer.initialize();
  }

  _open() async {
    final Map<String, dynamic> mediaConstraints = {
      "audio": true,
      "video": {"width": 1280, "height": 700}
    };
    try {
      await navigator.mediaDevices
          .getUserMedia(mediaConstraints)
          .then((stream) {
        _localStream = stream;
        _localRenderer.srcObject = _localStream;
      });
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isOpen = true;
    });
  }

  _close() async {
    try {
      await _localStream.dispose();
      _localRenderer.srcObject = null;
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserMedia'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: RTCVideoView(_localRenderer),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isOpen ? _close : _open,
        child: Icon(_isOpen ? Icons.close : Icons.add),
      ),
    );
  }
}
