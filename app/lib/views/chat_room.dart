import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/database.dart';
import 'package:app/widgets/widget_list.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ChatroomData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppBar(data),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          children: [

            Expanded(
              child: _MessageList(data: data),
            ),

            _ActionBar(data: data),

          ],
        ),
      )
    );
  }
}

class _ActionBar extends StatelessWidget {
  _ActionBar({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ChatroomData data;

  final user = FirebaseAuth.instance.currentUser!;
  final _messageTxtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
    
        Container(
          padding: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1
              ),
            ),
          ),
          child: Icon(
            Icons.camera_alt
          ),
        ),
    
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _messageTxtCtrl,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: "Type in message...",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
    
        ElevatedButton(
          onPressed: () {
            Database.sendMessage(
              data,
              MessageData(
                senderId: user.uid,
                sentAt: DateTime.now(),
                message: _messageTxtCtrl.text.trim(),
              )
            );
            _messageTxtCtrl.clear();
          },
          child: Icon(
            Icons.send,
          ),
        ),
    
      ],
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ChatroomData data;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Database.getMessages(data),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return !snapshot.hasData
          ? Center(child: CircularProgressIndicator())
          : _MessageTiles(snapshot: snapshot);
      },
    );
  }
}

class _MessageTiles extends StatelessWidget {
  _MessageTiles({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<QuerySnapshot> snapshot;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: snapshot.data!.docs.map((DocumentSnapshot document) {
        final data = document.data()! as Map<String, dynamic>;
        final messageData = MessageData(
          senderId: data['sender_id'],
          sentAt: data['sent_at'].toDate(),
          message: data['message'],
        );

        return user.uid == messageData.senderId
          ? _MessageRightTile(data: messageData)
          : _MessageLeftTile(data: messageData);
      }).toList(),
    );
  }
}

class _MessageLeftTile extends StatelessWidget {
  const _MessageLeftTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final MessageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Text(data.message),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                data.sentAt.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _MessageRightTile extends StatelessWidget {
  const _MessageRightTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final MessageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Text(data.message),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                data.sentAt.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}