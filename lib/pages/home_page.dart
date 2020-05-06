import 'package:flutter/material.dart';
import 'package:websocket_app/widgets/button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          button("Create server",
              onPressed: () => Navigator.pushNamed(context, '/server')),
          SizedBox(width: 20),
          button("Connect to server",
              onPressed: () => Navigator.pushNamed(context, '/client')),
        ],
      ),
    );
  }
}
