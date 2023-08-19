import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sultanpos/http/tokenprovider.dart';
import 'package:sultanpos/http/websocket/message.pb.dart';

abstract class IWebSocketTransport {
  StreamSubscription<Message> listen(Function(Message msg)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError});
  send(Message msg);
}

abstract class IOnline {
  StreamSubscription<bool> listenOnline(Function(bool msg)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError});
  Stream<bool> getOnlineStream();
}

class WebSocketTransport implements IWebSocketTransport, IOnline {
  String baseUrl;
  bool _shouldConnect = false;
  TokenProvider tokenProvider;
  WebSocket? wsConn;
  WebSocketTransport(this.baseUrl, this.tokenProvider);
  StreamController<Message> streamController = StreamController<Message>.broadcast();
  StreamController<bool> streamControllerOnline = StreamController<bool>();

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
              streamControllerOnline.add(false);
            }
          }
        },
        cancelOnError: false,
      );
      streamControllerOnline.add(true);
      debugPrint("ws connected");
    } catch (e) {
      debugPrint("connection failed: ${e.toString()}");
      _checkReconnect();
    }
  }

  Stream<Message> get stream => streamController.stream;

  @override
  StreamSubscription<Message> listen(Function(Message msg)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return stream.listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  }

  @override
  send(Message msg) {
    if (wsConn != null && wsConn!.readyState == WebSocket.open) {
      wsConn!.add(msg.writeToBuffer());
    }
  }

  @override
  StreamSubscription<bool> listenOnline(Function(bool msg)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return streamControllerOnline.stream.listen(onData, onError: onError, cancelOnError: cancelOnError, onDone: onDone);
  }

  @override
  Stream<bool> getOnlineStream() {
    return streamControllerOnline.stream;
  }
}
