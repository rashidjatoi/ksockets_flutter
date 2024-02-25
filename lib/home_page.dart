import 'package:flutter/material.dart';
import 'package:ksockets/sockets_screen/web_socket_screen.dart';
import 'package:web_socket_channel/io.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Socket'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebSocketScreen(
                      socketChannel:
                          IOWebSocketChannel.connect('ws://echo.websocket.org'),
                    ),
                  ));
            },
            child: const Text('Socket'),
          ),
        ],
      ),
    );
  }
}
