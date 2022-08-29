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
            : Column(
              children: [

                Expanded(
                  child: _SortedChatroomTiles(context, snapshot),
                  // child: ListView.builder(
                  //   itemCount: snapshot.data!.docs.length,
                  //   itemBuilder: (context, index) {
                  //     final revIndex = snapshot.data!.docs.length - index - 1;
                  //     final data = snapshot.data!.docs[index];
                  //     print(data.data() as Map<String, dynamic>);
                  //     final chatroomData = ChatroomData(
                  //       uid: data.id,
                  //       lastSentAt: data['last_sent_at'].toDate(),
                  //       lastSentMsg: data['last_sent_message'],
                  //       members: data['members'],
                  //     );
                  //     return _ChatroomTile(
                  //       data: data,
                  //       chatroomData: chatroomData,
                  //     );
                  //   },
                  // ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      Database.createNewChatroom();
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ChatroomMakingMenu();
                        }
                      );
                    },
                    child: Icon(Icons.add)
                  ),
                ),

              ],
            );
        }
      ),
    );
  }
}

ListView _SortedChatroomTiles(
  BuildContext context,
  AsyncSnapshot<QuerySnapshot> snapshot
) {
  final snapshotList = snapshot.data!.docs.map((DocumentSnapshot document) {
    return document.data() as Map<String, dynamic>;
  }).toList();
  snapshotList.sort((a,b) => b['last_sent_at'].compareTo(a['last_sent_at']));

  return ListView.builder(
    itemCount: snapshotList.length,
    itemBuilder: (context, index) {
      final data = snapshotList[index];
      return _ChatroomTile(
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

class _ChatroomTile extends StatelessWidget {
  const _ChatroomTile({
    Key? key,
    required this.data,
    required this.chatroomData,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final ChatroomData chatroomData;

  @override
  Widget build(BuildContext context) {
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
                      chatroomData.lastSentMsg,
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
  }
}

class ChatroomMakingMenu extends StatefulWidget {
  const ChatroomMakingMenu({Key? key}) : super(key: key);

  @override
  State<ChatroomMakingMenu> createState() => _ChatroomMakingMenuState();
}

class _ChatroomMakingMenuState extends State<ChatroomMakingMenu> {
  final _searchTxtCtrl = TextEditingController();

  _onSearchChanged() {
    print(_searchTxtCtrl.text);
  }

  @override
  void initState() {
    super.initState();
    _searchTxtCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _searchTxtCtrl.dispose();
    _searchTxtCtrl.removeListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
    
          Text("hi"),
    
          TextField(
            controller: _searchTxtCtrl,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
          ),

          // StreamBuilder(
          //   stream: Database.,
          //   builder: 
          // ),
    
        ],
      ),
    );
  }
}
