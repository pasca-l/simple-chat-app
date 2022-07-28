import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future addUserInfo(String uid, String username) async {
    try{
      // final Collection
    } catch(e) {

    }
  }
}

@immutable
class MessageData {
  MessageData({
    required this.senderName,
    required this.message,
    required this.sentTime
  });

  final String senderName;
  final String message;
  final DateTime sentTime;
}