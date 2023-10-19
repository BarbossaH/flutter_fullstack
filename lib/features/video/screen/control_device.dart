import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class ControlDevice extends StatefulWidget {
  static const String routeName = 'control-screen';
  const ControlDevice({super.key});

  @override
  State<ControlDevice> createState() => _ControlDeviceState();
}

class _ControlDeviceState extends State<ControlDevice> {
  late MediaStream _localStream;
  final _localRenderer = RTCVideoRenderer();
  bool _isOpen = false;
  //是否关闭摄像头
  bool _cameraOff = false;
  //是否关闭麦克风
  bool _microphoneOff = false;
  //是否打开扬声器
  bool _speakerOn = true;
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

  _switchSpeaker() {
    setState(() {
      _speakerOn = !_speakerOn;
      MediaStreamTrack audioTrack = _localStream.getAudioTracks()[0];
      audioTrack.enableSpeakerphone(_speakerOn);
      print("Shift to " + (_speakerOn ? "Speaker " : "Handset"));
    });
  }

  _switchCamera() {
    if (_localStream.getVideoTracks().isNotEmpty) {
      Helper.switchCamera(_localStream.getVideoTracks()[0]);
      // _localStream.getVideoTracks()[0].switchCamera();
      // _localStream.getVideoTracks().forEach((track) {
      // track.switchCamera();
      // Helper.switchCamera(track);
      // });
    } else {
      print('不能切换摄像头');
    }
  }

  _turnCamera() {
    if (_localStream.getVideoTracks().isNotEmpty) {
      var muted = !_cameraOff;
      setState(() {
        _cameraOff = muted;
      });
      _localStream.getVideoTracks()[0].enabled = !muted;
    } else {
      print('不能操作摄像头');
    }
  }

  _turnMicrophone() {
    if (_localStream.getVideoTracks().isNotEmpty) {
      var muted = !_microphoneOff;
      setState(() {
        _microphoneOff = muted;
      });
      _localStream.getAudioTracks()[0].enabled = !muted;
      if (muted) {
        print("Muted");
      } else {
        print("Cancel muted");
      }
    } else {
      // print('不能操作摄像头');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ControlDevice'),
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
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                _turnCamera();
              },
              icon: Icon(_cameraOff ? Icons.videocam_off : Icons.videocam)),
          IconButton(
              onPressed: () {
                _switchCamera();
              },
              icon: Icon(Icons.switch_camera)),
          IconButton(
              onPressed: () {
                _turnMicrophone();
              },
              icon: Icon(_microphoneOff ? Icons.mic_off : Icons.mic)),
          IconButton(
              onPressed: () {
                _switchSpeaker();
              },
              icon: Icon(_speakerOn ? Icons.volume_up : Icons.volume_down)),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _isOpen ? _close : _open,
        child: Icon(_isOpen ? Icons.close : Icons.add),
      ),
    );
  }
}
