import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:websocket_app/widgets/button.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  IOWebSocketChannel channel;
  bool canConnect;
  String messageToSend;
  String inputText;
  GlobalKey connectKey = GlobalKey();
  GlobalKey messageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text("Client", style: TextStyle(color: Colors.white, fontSize: 32)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (channel == null) _buildInput(),
                  if (channel != null) _buildMessageSender(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: BackButton(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future connectToServer({String host, int port = 8080}) async {
    print(host);
    print(port);
    setState(() {
      channel = IOWebSocketChannel.connect("ws://$host:${port.toString()}");
    });
    channel.stream.listen((message) {
      print("received: " + message);
      // channel.sink.add("received!");
      // channel.sink.close(status.goingAway);
    });
    setState(() {});
  }

  Widget _buildInput() {
    return Padding(
      key: connectKey,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)),
                child: TextField(
                  autocorrect: false,
                  enableSuggestions: false,
                  onChanged: (text) {
                    inputText = text;
                    if (inputText == null || inputText == "") {
                      canConnect = false;
                    } else {
                      canConnect = true;
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      labelText: "host",
                      labelStyle: TextStyle(color: Colors.grey)),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(width: 10),
            if (canConnect != null && canConnect)
              button('connect',
                  onPressed: () => connectToServer(host: inputText)),
          ]),
          SizedBox(height: 10),
          if (canConnect != null && !canConnect)
            Text(
              "you must enter the server host",
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }

  Widget _buildMessageSender() {
    return Padding(
      key: messageKey,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)),
                child: TextField(
                  autocorrect: false,
                  enableSuggestions: false,
                  onChanged: (text) {
                    setState(() {
                      messageToSend = text;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "message to send",
                      labelStyle: TextStyle(color: Colors.grey)),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(width: 10),
            if (messageToSend != null && messageToSend != "")
              button('send', onPressed: () {
                channel.sink.add(messageToSend);
                setState(() {
                  messageToSend = null;
                });
              }),
          ]),
        ],
      ),
    );
  }
}
