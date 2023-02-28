import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/contants.dart';

class SendNoti {
  static void sendNow(String postId, String receiverId, String senderName,
      String type, message) {
    // add a notification to the postOwner's activity feed only if comment made by OTHER user (to avoid getting notification for our own like)
    bool isNotPostOwner = auth.currentUser!.uid != receiverId;
    if (!isNotPostOwner) {
      DocumentReference _docRef =
          root.collection('feed').doc(receiverId).collection('feeds').doc();
      _docRef.set({
        "type": type, //type of notification
        "senderId": auth.currentUser!.uid,
        "seen": false,
        "message": message, //comment made
        "receiverId": receiverId,
        'isDriver': false,
        "postId": postId,
        'createdAt': createdAt,
        "timestamp": timestamp,
        "senderName": senderName,
      });
    }
  }

  static void sendDriver(String postId, String receiverId, String senderName,
      String type, message) {
    DocumentReference _docRef =
        root.collection('driverFeed').doc(receiverId).collection('feeds').doc();
    _docRef.set({
      "type": type, //type of notification
      "senderId": auth.currentUser!.uid,
      "seen": false,
      "message": message, //comment made
      "receiverId": receiverId,
      'isDriver': false,
      "postId": postId,
      'createdAt': createdAt,
      "timestamp": timestamp,
      "senderName": senderName,
    });
  }

  static void sendAdmin(String postId, String receiverId, String senderName,
      String type, message) {
    DocumentReference _docRef = root.collection('adminFeed').doc();
    _docRef.set({
      "type": type, //type of notification
      "senderId": auth.currentUser!.uid,
      "seen": false,
      "message": message, //comment made
      "receiverId": receiverId,
      'isDriver': false,
      "postId": postId,
      'createdAt': createdAt,
      "timestamp": timestamp,
      "senderName": senderName,
    });
  }
}
