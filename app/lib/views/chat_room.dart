import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/modules/database.dart';
import 'package:app/widgets/widget_list.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({
    Key? key,
    required this.chatroom,
  }) : super(key: key);

  final ChatroomData chatroom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatroomAppbar(chatroom: chatroom),
      // bottomSheet: ActionBar(data: chatroom),
      bottomNavigationBar: ActionBar(chatroom: chatroom),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: MessageList(chatroom: chatroom),
      )
    );
  }
}


class ChatroomAppbar extends StatefulWidget
implements PreferredSizeWidget {
  const ChatroomAppbar({
    Key? key,
    required this.chatroom
  }) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  final ChatroomData chatroom;

  @override
  final Size preferredSize;

  @override
  State<ChatroomAppbar> createState() => _ChatroomAppbarState();
}

class _ChatroomAppbarState extends State<ChatroomAppbar>
with TickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [

          UserAvatar(),

          SizedBox(width: 20),

          Expanded(
            child: Text(
              "${widget.chatroom.members}",
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(width: 20),

          GestureDetector(
            onTap: () {
              if (_isPlaying == false) {
                _controller.forward();
                _isPlaying = true;
              } else {
                _controller.reverse();
                _isPlaying = false;
              }
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
            ),
          ),

        ],
      ),
      centerTitle: true,
      elevation: 10,
    );
  }
}

class TestBox extends StatelessWidget
implements PreferredSizeWidget {
  const TestBox({Key? key}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.ac_unit_outlined)
    );
  }
}

class ActionBar extends StatelessWidget {
  ActionBar({
    Key? key,
    required this.chatroom,
  }) : super(key: key);

  final ChatroomData chatroom;
  final user = FirebaseAuth.instance.currentUser!;

  final _messageTxtCtrl = TextEditingController();

  final popupMenuItem = ["awesome function", "super awesome function"];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [

          PopupMenuButton(
            icon: Icon(Icons.view_list),
            itemBuilder: (context) {
              return popupMenuItem.map((String name) {
                return PopupMenuItem(
                  child: Text(name),
                );
              }).toList();
            },
          ),

          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ChatroomMemberMenu(
                    chatroom: chatroom
                  );
                }
              );
            },
            icon: Icon(Icons.group),
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt_outlined),
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

          IconButton(
            onPressed: () {
              Database.sendMessage(
                chatroom,
                MessageData(
                  senderId: user.uid,
                  sentAt: DateTime.now(),
                  message: _messageTxtCtrl.text.trim(),
                )
              );
              _messageTxtCtrl.clear();
            },
            icon: Icon(Icons.send),
          ),

        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({
    Key? key,
    required this.chatroom,
  }) : super(key: key);

  final ChatroomData chatroom;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Database.getMessages(chatroom),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return !snapshot.hasData
          ? Center(child: CircularProgressIndicator())
          : MessageTiles(snapshot: snapshot);
      },
    );
  }
}

class MessageTiles extends StatelessWidget {
  MessageTiles({
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
          ? MessageRightTile(messageData: messageData)
          : MessageLeftTile(messageData: messageData);
      }).toList(),
    );
  }
}

class MessageLeftTile extends StatelessWidget {
  const MessageLeftTile({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

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
                child: Text(messageData.message),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                DateFormat('Hm').format(messageData.sentAt).toString(),
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

class MessageRightTile extends StatelessWidget {
  const MessageRightTile({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

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
                child: Text(messageData.message),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                DateFormat('Hm').format(messageData.sentAt).toString(),
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

class ChatroomMemberMenu extends StatefulWidget {
  const ChatroomMemberMenu({
    Key? key,
    required this.chatroom,
  }) : super(key: key);

  final ChatroomData chatroom;

  @override
  State<ChatroomMemberMenu> createState() => _ChatroomMemberMenuState();
}

class _ChatroomMemberMenuState extends State<ChatroomMemberMenu> {
  final _queryCtrl = TextEditingController();
  List<Map<String, dynamic>> searchResult = [];

  _onSearchChanged() {
    Database.getUsers().then((List<Map<String, dynamic>> result) {
        setState(() {
          searchResult = Database.filterUsers(result, _queryCtrl.text.trim());
        });
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _queryCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _queryCtrl.dispose();
    _queryCtrl.removeListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [

          Text("Search for member to chat with"),

          TextField(
            controller: _queryCtrl,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (BuildContext contxt, int index) {
                final user_info = searchResult[index];
                final user = UserData(
                  uid: user_info['uid'],
                  name: user_info['name'],
                );
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(user.name),
                    leading: UserAvatar(),
                    onTap: () {
                      Database.addMember(
                        widget.chatroom,
                        user
                      );
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
