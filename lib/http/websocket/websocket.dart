import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sultanpos/http/tokenprovider.dart';
import 'package:sultanpos/http/websocket/message.pb.dart';

class WebSocketTransport {
  String baseUrl;
  bool _shouldConnect = false;
  TokenProvider tokenProvider;
  WebSocket? wsConn;
  WebSocketTransport(this.baseUrl, this.tokenProvider);
  StreamController<Message> streamController = StreamController<Message>.broadcast();

  connect() async {
    if (wsConn != null) return;
    _shouldConnect = true;
    _doConnect();
  }

  close() async {
    _shouldConnect = false;
    if (wsConn != null && wsConn!.readyState == WebSocket.open) {
      await wsConn!.close();
    }
  }

  _checkReconnect() {
    if (!_shouldConnect) return;
    if (wsConn != null) {
      if (wsConn!.readyState == WebSocket.closed || wsConn!.readyState == WebSocket.closing) {
        Future.delayed(
          const Duration(seconds: 10),
          () {
            _doConnect();
          },
        );
      }
    } else {
      Future.delayed(
        const Duration(seconds: 10),
        () {
          _doConnect();
        },
      );
    }
  }

  _doConnect() async {
    final url = '$baseUrl/transport/ws/';
    try {
      wsConn = await WebSocket.connect(
        url,
        headers: {'Authorization': 'Bearer ${tokenProvider.getToken()}'},
        protocols: ["sultanpos-grpc"],
      );
      wsConn!.listen(
        (event) {
          if (event is List<int>) {
            final msg = Message.fromBuffer(event);
            if (msg.hasWelcome()) {
              debugPrint("websocket welcome message recieved");
            } else {
              debugPrint("new websocket message");
              streamController.add(msg);
            }
          }
        },
        onDone: () {
          if (wsConn != null) {
            if (wsConn!.closeCode != null) {
              debugPrint("ws connection closed: ${wsConn!.closeCode}");
              _checkReconnect();
            }
          }
        },
        cancelOnError: false,
      );
      debugPrint("ws connected");
    } catch (e) {
      debugPrint("connection failed: ${e.toString()}");
      _checkReconnect();
    }
  }

  Stream<Message> get stream => streamController.stream;
}
