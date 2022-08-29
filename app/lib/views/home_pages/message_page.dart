import 'package:app/modules/database.dart';
import 'package:app/views/view_list.dart';
import 'package:app/widgets/widget_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: StreamBuilder<QuerySnapshot>(
        stream: Database.getChatrooms(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : _ChatroomTiles(snapshot: snapshot);
        }
      ),
    );
  }
}

class _ChatroomTiles extends StatelessWidget {
  const _ChatroomTiles({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<QuerySnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: snapshot.data!.docs.map((DocumentSnapshot document) {
        final data = document.data()! as Map<String, dynamic>;
        final chatroomData = ChatroomData(
          uid: document.id,
          lastSentAt: data['last_sent_at'].toDate(),
          members: data['members'],
        );

        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatRoom(
                  data: chatroomData,
                ))
              );
            },
            child: Row(
              children: [

                Padding(
                  padding: EdgeInsets.all(16),
                  child: UserAvatar(),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chatroomData.uid),
                      SizedBox(
                        height: 20,
                        child: Text(
                          chatroomData.members.toString(),
                          overflow: TextOverflow.ellipsis,
                        )
                      ),
                    ],
                  )
                ),

                Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 20,
                        child: Text(
                          chatroomData.lastSentAt.toString(),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('1'),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
