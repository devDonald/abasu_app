import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/contants.dart';
import '../admin/drivers/driver_model.dart';
import '../authentication/model/app_users_model.dart';

class NotificationModel {
  String? type, senderId, message, receiverId, postId, createdAt, senderName;
  bool? isDriver;
  Timestamp? timestamp;
  UserModel? sender;
  DriverModel? sender1;

  NotificationModel({
    this.type,
    this.senderId,
    this.message,
    this.receiverId,
    this.postId,
    this.createdAt,
    this.senderName,
    this.isDriver,
    this.timestamp,
    this.sender,
    this.sender1,
  });

  toJson() {
    return {
      "type": type, //type of notification
      "senderId": senderId,
      "isDriver": isDriver,
      "message": message, //comment made
      "receiverId": receiverId,
      "postId": postId,
      'createdAt': createdAt,
      "timestamp": timestamp,
      "senderName": senderName,
    };
  }

  NotificationModel.fromSnapshot(DocumentSnapshot snap) {
    type = snap['type'];
    senderId = snap['senderId'];
    isDriver = snap['isDriver'];
    message = snap['message'];
    receiverId = snap['receiverId'];
    postId = snap['postId'];
    createdAt = snap['createdAt'];
    timestamp = snap['timestamp'];
    senderName = snap['senderName'];
  }

  Future<void> loadCustomer() async {
    if (isDriver!) {
      DocumentSnapshot ds = await driversRef.doc(senderId).get();
      sender1 = DriverModel.fromSnapshot(ds);
    } else {
      DocumentSnapshot ds = await usersRef.doc(senderId).get();
      sender = UserModel.fromSnapshot(ds);
    }
  }
}
