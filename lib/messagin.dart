import 'dart:async';
import 'package:firebase/firebase.dart' as firebase;

class FBMessaging {
  FBMessaging._();
  static FBMessaging _instance = FBMessaging._();
  static FBMessaging get instance => _instance;
  firebase.Messaging _mc;
  String _token;

  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  void close() {
    _controller?.close();
  }

  Future<void> init() async {
    _mc = firebase.messaging();
    _mc.usePublicVapidKey('BGLwklOBtNEMycQ6Bk2D-bSHusSTB_I0YRc2HMhGwLI5zsi1zQADEO6U03IcJ3ijeoaOiRNBQCsKKkUI2fA7OBU');
    _mc.onMessage.listen((event) {
      _controller.add(event?.data);
    });
  }

  Future requestPermission() {
    return _mc.requestPermission();
  }

  Future<String> getToken([bool force = false]) async {
    if (force || _token == null) {
      _token = await _mc.getToken();
      await requestPermission();
      
    }
    return _token;
  }
}