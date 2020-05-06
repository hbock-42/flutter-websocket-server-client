import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:wifi/wifi.dart';

class ServerPage extends StatefulWidget {
  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  HttpServer server;
  String receivedMessage;

  @override
  void initState() {
    super.initState();
    startServer();
  }

  @override
  void dispose() {
    server?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text("Server", style: TextStyle(color: Colors.white, fontSize: 32)),
            if (server != null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "host: ${server.address.host}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text("address: ${server.address}",
                        style: TextStyle(color: Colors.white)),
                    Text("port: ${server.port}",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 40),
                    if (receivedMessage != null)
                      Text("message received:    $receivedMessage",
                          style: TextStyle(color: Colors.white)),
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

  void startServer() async {
    var handler = webSocketHandler((webSocket) {
      webSocket.stream.listen((message) {
        print("message receivvvved:" + message);
        setState(() {
          receivedMessage = message;
        });
        webSocket.sink.add("echo $message");
      });
    });
    String ip = await Wifi.ip;
    // shelf_io.serve(handler, 'localhost', 8080).then((server) {
    // shelf_io.serve(handler, InternetAddress.loopbackIPv4, 8080).then((server) {
    shelf_io.serve(handler, ip, 8080).then((server) {
      print('Serving at ws://${server.address.host}:${server.port}');
      setState(() {
        this.server = server;
      });
    });
  }
}
