import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Future<void> addMember (ChatroomData chatroom, UserData user) {
    final db = FirebaseFirestore.instance;

    return db.collection('chatrooms').doc(chatroom.uid)
      .update({
        "members": FieldValue.arrayUnion([user.uid])
      });
  }

  static ChatroomData createNewChatroom() {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    final docId = db.collection('chatrooms').doc().id;
    final tempSentAt = DateTime.now();
    final tempSentMsg = "";
    final members = [user.uid];

    db.collection('chatrooms').doc(docId)
      .set({
        "uid": docId,
        "last_sent_at": Timestamp.fromDate(tempSentAt),
        "last_sent_message": tempSentMsg,
        "members": members,
      });

    return ChatroomData(
      uid: docId,
      lastSentAt: tempSentAt,
      lastSentMsg: tempSentMsg,
      members: members,
    );
  }

  static Stream<QuerySnapshot> getChatrooms() {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    return db.collection('chatrooms')
      .where('members', arrayContains: user.uid)
      // .orderBy('last_sent_at', descending: true) // needs 'composite index'
      .snapshots();
  }

  static List<Map<String, dynamic>> sortChatrooms(
    AsyncSnapshot<QuerySnapshot> snapshot
  ) {
    final snapshotList = snapshot.data!.docs.map((DocumentSnapshot document) {
      return document.data() as Map<String, dynamic>;
    }).toList();
    snapshotList.sort((a,b) => b['last_sent_at'].compareTo(a['last_sent_at']));
    return snapshotList;
  }

  static Stream<QuerySnapshot> getMessages(ChatroomData chatroom) {
    final db = FirebaseFirestore.instance;

    return db.collection('chatrooms').doc(chatroom.uid)
      .collection('messages')
      .orderBy('sent_at', descending: false)
      .snapshots();
  }

  static Future<void> sendMessage(ChatroomData chatroom, MessageData message) {
    final db = FirebaseFirestore.instance;

    db.collection('chatrooms').doc(chatroom.uid)
      .collection('messages')
      .add({
        "message": message.message,
        "sender_id": message.senderId,
        "sent_at": Timestamp.fromDate(message.sentAt),
    });

    return db.collection('chatrooms').doc(chatroom.uid)
      .update({
        "last_sent_at": Timestamp.fromDate(message.sentAt),
        "last_sent_message": message.message,
      });
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = FirebaseFirestore.instance;

    final QuerySnapshot snapshot = await db.collection('users').get();
    return snapshot.docs.map((DocumentSnapshot doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  }

  static List<Map<String, dynamic>> filterUsers(
    List<Map<String, dynamic>> result,
    String query
  ) {
    return result.isEmpty
      ? []
      : result.where((data) => data['name'].contains(query)).toList();
  }

}

class UserData {
  const UserData({
    required this.uid,
    required this.name,
  });

  final String uid;
  final String name;
}

class ChatroomData {
  const ChatroomData({
    required this.uid,
    required this.lastSentAt,
    required this.lastSentMsg,
    required this.members,
  });

  final String uid;
  final DateTime lastSentAt;
  final String lastSentMsg;
  final List<dynamic> members;
}

@immutable
class MessageData {
  const MessageData({
    required this.senderId,
    required this.sentAt,
    required this.message,
  });

  final String senderId;
  final DateTime sentAt;
  final String message;
}
