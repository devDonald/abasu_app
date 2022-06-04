import 'package:abasu_app/core/constants/contants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../authentication/model/app_users_model.dart';

class RequestModel {
  String? workId,
      ownerId,
      category,
      workTitle,
      workDescription,
      artisanId,
      status,
      duration,
      createdAt,
      phone,
      address;
  List<dynamic>? images, imagesNames;
  int? budget;
  Timestamp? timestamp;
  String? artisanName, artisanPhoto, customerName, customerPhoto;
  bool? isOwner, isArtisan;
  UserModel? artisan, customer;

  RequestModel({
    this.workId,
    this.ownerId,
    this.category,
    this.workTitle,
    this.workDescription,
    this.images,
    this.imagesNames,
    this.artisanId,
    this.budget,
    this.duration,
    this.status,
    this.timestamp,
    this.createdAt,
    this.isOwner,
    this.phone,
    this.artisan,
    this.customer,
    this.address,
    this.artisanName,
    this.artisanPhoto,
    this.customerName,
    this.customerPhoto,
    this.isArtisan,
  });

  toJson() {
    return {
      'workId': workId,
      'ownerId': ownerId,
      'category': category,
      'workTitle': workTitle,
      'workDescription': workDescription,
      'images': images,
      'imagesNames': imagesNames,
      'artisanId': artisanId,
      'budget': budget,
      'duration': duration,
      'status': status,
      'createdAt': createdAt,
      'timestamp': timestamp,
      'address': address,
      'phone': phone,
    };
  }

  RequestModel.fromSnapshot(DocumentSnapshot snap) {
    workId = snap['workId'];
    ownerId = snap['ownerId'];
    category = snap['category'];
    workTitle = snap['workTitle'];
    workDescription = snap['workDescription'];
    images = snap['images'];
    imagesNames = snap['imagesNames'];
    artisanId = snap['artisanId'];
    budget = snap['budget'];
    duration = snap['duration'];
    status = snap['status'];
    timestamp = snap['timestamp'];
    createdAt = snap['createdAt'];
    address = snap['address'];
    phone = snap['phone'];

    if (auth.currentUser!.uid == snap['ownerId']) {
      isOwner = true;
    } else {
      isOwner = false;
    }
    if (auth.currentUser!.uid == snap['artisanId']) {
      isArtisan = true;
    } else {
      isArtisan = false;
    }
  }
  Future<void> loadCustomer() async {
    DocumentSnapshot ds = await usersRef.doc(ownerId).get();

    customer = UserModel.fromSnapshot(ds);
    customerName = customer!.name;
    customerPhoto = customer!.photo;

    DocumentSnapshot ds2 = await usersRef.doc(artisanId).get();
    artisan = UserModel.fromSnapshot(ds2);
    artisanPhoto = artisan!.photo;
    artisanName = artisan!.name;
  }
}
