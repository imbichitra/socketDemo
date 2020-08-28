import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class SocketDemo extends StatefulWidget {
  @override
  _SocketDemoState createState() => _SocketDemoState();
}

class _SocketDemoState extends State<SocketDemo> {
  StompClient client;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: (){initSocket();},child: Text("Connect"),),
    );
  }

  static dynamic onConnect(StompClient client, StompFrame frame) {
    client.subscribe(
        destination: '/topic/asiczen',
        callback: (StompFrame frame) {
          //List<dynamic> result = json.decode(frame.body);
          print(json.decode(frame.body));
        });
  }
//https://devscorpious.asiczen.com/livegeodata-websocket //ws://45.114.48.150:8084/andriodendpoint
  void initSocket() {
    client = StompClient(
        config: StompConfig(
            url: 'ws://45.114.48.150:8084/andriodendpoint',
            onConnect: onConnect,
            onWebSocketError: (dynamic error) => print(error.toString())));

    client.activate();
  }
}
