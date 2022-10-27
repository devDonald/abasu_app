import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/contants.dart';

class DriverModel {
  String? driverId;
  String? name;
  String? country;
  String? photo;
  String? email;
  String? phone;
  String? code;
  String? gender, address;
  String? dialCode;
  String? marital,
      status,
      vehicleManufacturer,
      vehicleColour,
      plateNo,
      bankName,
      accountName,
      accountNo,
      vehicleModel;
  double? latitude = 0.0, longitude = 0.0;
  String? experience;
  String? licenceNo;
  int? wallet = 0, info = 0;
  String? token;
  bool? isOnline = false, isVerified = false, isHired = false;
  bool? isOwner = false;

  DriverModel({
    this.driverId,
    this.name,
    this.country,
    this.photo,
    this.email,
    this.phone,
    this.code,
    this.dialCode,
    this.gender,
    this.marital,
    this.experience,
    this.isOwner,
    this.address,
    this.wallet,
    this.info,
    this.isOnline,
    this.isVerified,
    this.isHired,
    this.longitude,
    this.latitude,
    this.accountName,
    this.accountNo,
    this.bankName,
    this.licenceNo,
    this.plateNo,
    this.vehicleColour,
    this.vehicleManufacturer,
    this.vehicleModel,
    this.token,
    this.status,
  });

  updateUser() {}
  toJson() {
    return {
      "driverId": driverId,
      "email": email,
      'name': name,
      'country': country,
      'photo': photo,
      'code': code,
      'dialCode': dialCode,
      'phone': phone,
      'token': '',
      'gender': gender,
      'isOnline': isOnline,
      'wallet': wallet,
      'marital': marital,
      'longitude': longitude,
      'latitude': latitude,
      'experience': experience,
      'licenceNo': licenceNo,
      'address': address,
      'isHired': isHired,
      'isVerified': isVerified,
      'info': info,
      'accountName': accountName,
      'accountNo': accountNo,
      'bankName': bankName,
      'plateNo': plateNo,
      'vehicleColour': vehicleColour,
      'vehicleManufacturer': vehicleManufacturer,
      'vehicleModel': vehicleModel,
      'status': 'UnVerified'
    };
  }

  DriverModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot['name'];
    email = snapshot['email'];
    country = snapshot['country'];
    photo = snapshot['photo'];
    driverId = snapshot['driverId'];
    phone = snapshot['phone'];
    code = snapshot['code'];
    dialCode = snapshot['dialCode'];
    gender = snapshot['gender'];
    address = snapshot['address'];
    licenceNo = snapshot['licenceNo'];
    experience = snapshot['experience'];
    marital = snapshot['marital'];
    isOnline = snapshot['isOnline'];
    info = snapshot['info'];
    wallet = snapshot['wallet'];
    isVerified = snapshot['isVerified'];
    isHired = snapshot['isHired'];
    accountNo = snapshot['accountNo'];
    accountName = snapshot['accountName'];
    bankName = snapshot['bankName'];
    plateNo = snapshot['plateNo'];
    status = snapshot['status'];
    vehicleModel = snapshot['vehicleModel'];
    vehicleManufacturer = snapshot['vehicleManufacturer'];
    vehicleColour = snapshot['vehicleColour'];
    if (auth.currentUser!.uid == snapshot['driverId']) {
      isOwner = true;
    } else {
      isOwner = false;
    }
  }
}
