import 'package:app/modules/database.dart';
import 'package:app/views/view_list.dart';
import 'package:app/widgets/widget_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: StreamBuilder<QuerySnapshot>(
        stream: Database.getChatrooms(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

          return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, int index) {
                final data = Database.sortChatrooms(snapshot)[index];
                return ChatroomTile(
                  data: data,
                  chatroomData: ChatroomData(
                    uid: data['uid'],
                    lastSentAt: data['last_sent_at'].toDate(),
                    lastSentMsg: data['last_sent_message'],
                    members: data['members'],
                  ),
                );
              },
            );

        }
      ),
    );
  }
}

class ChatroomTile extends StatelessWidget {
  const ChatroomTile({
    Key? key,
    required this.data,
    required this.chatroomData,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final ChatroomData chatroomData;

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Text('100'),
      child: ListTile(
        tileColor: Colors.grey[300]!.withOpacity(0.5),
        leading: UserAvatar(),
        trailing: Text(
          chatroomData.lastSentAt.toString(),
          overflow: TextOverflow.clip,
        ),
        title: Text(
          chatroomData.uid,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          chatroomData.lastSentMsg,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoom(
              chatroom: chatroomData,
            ))
          );
        },
      ),
    );
  }
}
