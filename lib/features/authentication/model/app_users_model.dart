import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/contants.dart';
import '../../../core/widgets/abasu_tags.dart';

class UserModel {
  String? userId;
  String? name;
  String? country;
  String? photo;
  String? email;
  String? phone;
  String? code;
  String? type, address;
  String? dialCode;
  dynamic skills;
  double? latitude = 0.0, longitude = 0.0;
  String? specialization;
  String? charge;
  int? info = 0, cart = 0;
  dynamic previousWorks;
  bool? isOnline = false, isVerified = false, isHired = false, isTop = false;
  bool? isOwner = false, isAdmin = false, isArtisan = false, isTagAdded = false;
  List<Tags> addedTags = [];

  UserModel(
      {this.userId,
      this.name,
      this.country,
      this.photo,
      this.email,
      this.phone,
      this.code,
      this.dialCode,
      this.type,
      this.skills,
      this.specialization,
      this.isOwner,
      this.address,
      this.info,
      this.cart,
      this.isOnline,
      this.previousWorks,
      this.isAdmin,
      this.isVerified,
      this.isHired,
      this.isArtisan,
      this.longitude,
      this.latitude,
      this.isTop,
      this.charge});

  updateUser() {}
  toJson() {
    return {
      "userId": userId,
      "email": email,
      'name': name,
      'country': country,
      'photo': photo,
      'code': code,
      'dialCode': dialCode,
      'phone': phone,
      'token': '',
      'type': type,
      'isOnline': isOnline,
      'info': info,
      'previousWorks': previousWorks,
      'skills': skills,
      'longitude': longitude,
      'latitude': latitude,
      'specialization': specialization,
      'charge': charge,
      'address': address,
      'isHired': isHired,
      'isVerified': isVerified,
      'cart': cart,
      'isTop': isTop,
    };
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot['name'];
    email = snapshot['email'];
    country = snapshot['country'];
    photo = snapshot['photo'];
    userId = snapshot['userId'];
    phone = snapshot['phone'];
    code = snapshot['code'];
    dialCode = snapshot['dialCode'];
    type = snapshot['type'];
    address = snapshot['address'];
    charge = snapshot['charge'];
    specialization = snapshot['specialization'];
    skills = snapshot['skills'];
    previousWorks = snapshot['previousWorks'];
    isOnline = snapshot['isOnline'];
    cart = snapshot['cart'];
    info = snapshot['info'];
    isTop = snapshot['isTop'];
    isVerified = snapshot['isVerified'];
    isHired = snapshot['isHired'];
    if (auth.currentUser!.uid == snapshot['userId']) {
      isOwner = true;
    } else {
      isOwner = false;
    }
    if (snapshot['type'] == 'Artisan') {
      isArtisan = true;
    } else {
      isArtisan = false;
    }
    if (snapshot['email'] == 'donaldebuga@gmail.com' ||
        snapshot['email'] == 'abasuteam@gmail.com' ||
        snapshot['email'] == 'fwangkatdaburak@gmail.com') {
      isAdmin = true;
    }
    if (snapshot['skills'] != null) {
      isTagAdded = true;
      for (var i = 0; i < skills.length; i++) {
        addedTags.add(Tags(tag: skills[i]));
      }
    } else {
      isTagAdded = false;
    }
  }
}
