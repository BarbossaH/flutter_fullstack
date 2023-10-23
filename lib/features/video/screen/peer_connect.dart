import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class PeerConnection extends StatefulWidget {
  static const String routeName = 'connection-screen';
  const PeerConnection({super.key});

  @override
  State<PeerConnection> createState() => _PeerConnectionState();
}

class _PeerConnectionState extends State<PeerConnection> {
  late MediaStream _localStream;
  late MediaStream _remoteStream;
  late RTCPeerConnection _localConnection;
  late RTCPeerConnection _remoteConnection;
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  bool _isConnected = false;

  final Map<String, dynamic> mediaConstraints = {
    'audio': true,
    'video': {
      'mandatory': {'minWidth': '640', 'minHeigh': '480', 'minFrameRate': '30'},
      'facingMode': 'user',
      'optional': [],
    }
  };
  final Map<String, dynamic> sdpConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };
  final Map<String, dynamic> pcConstraints = {
    'mandatory': {},
    'optional': [
      {"DtlsSrtpKeyAgreement": false}
    ],
  };
  final Map<String, dynamic> configuration = {
    'iceServers': [
      {"url": "stun:stun.l.google.com:19302"},
    ],
  };

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  _onLocalCandidate(RTCIceCandidate candidate) {
    _remoteConnection.addCandidate(candidate);
  }

  _onLocalIceConnectionState(RTCIceConnectionState state) {
    print(state);
  }

  _onRemoteCandidate(RTCIceCandidate candidate) {
    _localConnection.addCandidate(candidate);
  }

  _onRemoteConnectionState(RTCIceConnectionState state) {
    print(state);
  }

  _onRemoteAddStream(MediaStream stream) {
    _remoteStream = stream;
    _remoteRenderer.srcObject = stream;
  }

  Future<void> _open() async {
    // if (_localConnection != null || _remoteConnection != null) return;
    try {
      _localStream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localRenderer.srcObject = _localStream;

      _localConnection =
          await createPeerConnection(configuration, pcConstraints);
      _localConnection.onIceCandidate = _onLocalCandidate;
      _localConnection.onIceConnectionState = _onLocalIceConnectionState;

      _localConnection.addStream(_localStream);
      Helper.setMicrophoneMute(false, _localStream.getAudioTracks()[0]);
      // _localStream.getAudioTracks()[0].setMicrophoneMute(false);
      _remoteConnection =
          await createPeerConnection(configuration, pcConstraints);
      _remoteConnection.onIceCandidate = _onRemoteCandidate;
      _remoteConnection.onAddStream = _onRemoteAddStream;
      _remoteConnection.onIceConnectionState = _onRemoteConnectionState;

      RTCSessionDescription offer =
          await _localConnection.createOffer(sdpConstraints);
      _localConnection.setLocalDescription(offer);
      _remoteConnection.setRemoteDescription(offer);

      RTCSessionDescription answer =
          await _remoteConnection.createAnswer(sdpConstraints);
      _remoteConnection.setLocalDescription(answer);
      _localConnection.setRemoteDescription(answer);
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isConnected = true;
    });
  }

  Future<void> _close() async {
    try {
      await _localStream.dispose();
      await _remoteStream.dispose();
      await _remoteConnection.close();
      await _localConnection.close();
      // _localConnection = null;
      // _remoteConnection = null;
      _localRenderer.srcObject = null;
      _remoteRenderer.srcObject = null;
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _isConnected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Sample'),
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
        onPressed: _isConnected ? _close : _open,
        child: Icon(_isConnected ? Icons.close : Icons.add),
      ),
    );
  }
}
