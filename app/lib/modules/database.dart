import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  // static Stream<QuerySnapshot> 

  static Future<void> createNewChatroom() {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    final docId = db.collection('chatrooms').doc().id;
    return db.collection('chatrooms').doc(docId)
      .set({
        "uid": docId,
        "last_sent_at": Timestamp.fromDate(DateTime.now()),
        "last_sent_message": "",
        "members": [user.uid],
      });
  }

  static Stream<QuerySnapshot> getChatrooms() {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    return db.collection('chatrooms')
      .where('members', arrayContains: user.uid)
      // .orderBy('last_sent_at', descending: true) // needs 'composite index'
      .snapshots();
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
