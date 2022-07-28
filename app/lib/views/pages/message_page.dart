import 'package:app/modules/database.dart';
import 'package:app/views/view_list.dart';
import 'package:app/widgets/widget_list.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate( (context, index) {
                return _MessageTile(
                  messageData: MessageData(
                    senderName: "ME",
                    message: "hello world!!!!!",
                    sentTime: DateTime(2020, 10, 2, 12, 10),
                  )
                );
              },
            )
          ),
        ],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            ChatRoom.route(messageData),
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
                  Text(messageData.senderName),
                  SizedBox(
                    height: 20,
                    child: Text(
                      messageData.message,
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
                      messageData.sentTime.toString(),
                      overflow: TextOverflow.clip,
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