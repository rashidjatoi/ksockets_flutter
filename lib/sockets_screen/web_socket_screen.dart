import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketScreen extends StatefulWidget {
  final WebSocketChannel socketChannel;
  const WebSocketScreen({super.key, required this.socketChannel});

  @override
  State<WebSocketScreen> createState() => _WebSocketScreenState();
}

class _WebSocketScreenState extends State<WebSocketScreen> {
  late TextEditingController editingController;

  Future<void> _sendMessage() async {
    if (editingController.text.isNotEmpty) {
      widget.socketChannel.sink.add(editingController.text.trim());
    }
  }

  @override
  void initState() {
    editingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    editingController.dispose();
    widget.socketChannel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Socket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
                child: TextFormField(
              controller: editingController,
              decoration: InputDecoration(
                labelText: 'Send any message!',
              ),
            )),
            StreamBuilder(
              stream: widget.socketChannel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        child: const Icon(Icons.send),
      ),
    );
  }
}
