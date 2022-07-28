import 'package:flutter/material.dart';
import 'package:app/modules/database.dart';
import 'package:app/widgets/widget_list.dart';

class ChatRoom extends StatelessWidget {
  static Route route(MessageData data) {
    return MaterialPageRoute(
      builder: (context) => ChatRoom(
        messageData: data,
      ),
    );
  }

  const ChatRoom({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppBar(messageData.senderName),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text("chat room")
              ],
            ),
          ),

          _ActionBar(),
        ],
      )
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        children: [
          Icon(Icons.camera_alt),

          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}