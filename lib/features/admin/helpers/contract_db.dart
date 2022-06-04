import 'dart:io';

import 'package:abasu_app/features/profile/models/requests_model.dart';
import 'package:abasu_app/features/profile/models/sms_model.dart';
import 'package:abasu_app/features/profile/models/work_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import '../../../core/constants/contants.dart';
import '../../../core/constants/network_handler.dart';

class ContractDB {
  static addPreviousContracts(WorkModel todomodel) async {
    DocumentReference docRef = previousContractsRef.doc();
    todomodel.workId = docRef.id;
    todomodel.ownerId = auth.currentUser!.uid;
    docRef.set(todomodel.toJson()).then((doc) async {
      successToastMessage(msg: 'Previous Contracts Added Successfully');
    }).catchError((onError) async {
      errorToastMessage(msg: onError.toString());
    });
  }

  static hireAbasu(RequestModel requestModel) async {
    DocumentReference docRef = contractsRef.doc();
    requestModel.workId = docRef.id;
    requestModel.ownerId = auth.currentUser!.uid;
    docRef.set(requestModel.toJson()).then((doc) async {
      // await usersRef
      //     .doc(requestModel.artisanId)
      //     .update({"info": FieldValue.increment(1)});
      successToastMessage(
          msg: 'Request sent to Abasu Konsult Limited Successfully');
      // sendNotification(
      //     requestModel.workId!,
      //     requestModel.artisanId!,
      //     auth.currentUser!.displayName!,
      //     NotificationType.request,
      //     'A new Hire Request has been sent to you on Abasu App, quickly go and respond to it now');
    }).catchError((onError) async {
      errorToastMessage(msg: onError.toString());
    });
  }

  static sendSms(String phone, String message) async {
    SmsModel sms = SmsModel(
      token: '$smsToken, 09015210517',
      to: phone,
      sender: 'Abasu Team',
      message: message,
      type: 0,
      routing: 3,
    );
    NetworkHandler.postRequest(sms.toJson()).then((response) {
      print("marklogout ${response.body}");
    });
  }

  Future<List<String>> uploadFile(List<File> file) async {
    List<String> urls = [];
    for (var i = 0; i < file.length; i++) {
      var storageReference = FirebaseStorage.instance
          .ref()
          .child("profile")
          .child(Path.basename(file[i].path));
      await storageReference.putFile(file[i]);

      var url = await storageReference.getDownloadURL();

      urls.add(url);
    }
    return urls;
  }

  static void deleteFile(List<dynamic> images) async {
    for (var i = 0; i < images.length; i++) {
      String filePath = 'profile/${images[i]}';
      var storageReference = FirebaseStorage.instance.ref();
      await storageReference.child(filePath).delete();
    }
  }

  static void sendNotification(String postId, String receiverId,
      String senderName, String type, message) {
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
        "postId": postId,
        'createdAt': createdAt,
        "timestamp": timestamp,
        "senderName": senderName,
      });
    }
  }
}
