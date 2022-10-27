import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/order/sub_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../admin/drivers/driver_model.dart';
import '../authentication/model/app_users_model.dart';

class OrderModel {
  String? orderId,
      driverId,
      customerId,
      destination,
      distance,
      status,
      createdAt;
  List<Products>? products;
  int? price;
  Timestamp? timestamp;
  String? driverName, driverPhoto, phone, email, customerName, customerPhoto;
  bool? isCustomer = false, isDriver = false, withDelivery = false;
  double? lat, long;
  UserModel? customer;
  DriverModel? driver;

  OrderModel({
    this.orderId,
    this.driverId,
    this.customerId,
    this.destination,
    this.distance,
    this.products,
    this.price,
    this.status,
    this.timestamp,
    this.createdAt,
    this.isCustomer,
    this.driver,
    this.customer,
    this.driverName,
    this.driverPhoto,
    this.customerName,
    this.customerPhoto,
    this.isDriver,
    this.lat,
    this.long,
    this.withDelivery,
    this.phone,
    this.email,
  });

  toJson() {
    return {
      'orderId': orderId,
      'driverId': driverId,
      'customerId': customerId,
      'destination': destination,
      'distance': distance,
      'products': products!.map((v) => v.toJson()).toList(),
      'price': price,
      'status': status,
      'createdAt': createdAt,
      'timestamp': timestamp,
      'lat': lat,
      'long': long,
      'withDelivery': withDelivery,
      'phone': phone,
      'email': email,
      'customerName': customerName,
    };
  }

  OrderModel.fromSnapshot(DocumentSnapshot snap) {
    orderId = snap['orderId'];
    driverId = snap['driverId'];
    customerId = snap['customerId'];
    destination = snap['destination'];
    distance = snap['distance'];
    withDelivery = snap['withDelivery'];
    price = snap['price'];
    status = snap['status'];
    timestamp = snap['timestamp'];
    createdAt = snap['createdAt'];
    lat = snap['lat'];
    long = snap['long'];
    phone = snap['phone'];
    email = snap['email'];
    customerName = snap['customerName'];
    if (snap['products'] != null) {
      products = <Products>[];
      snap['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }

    if (auth.currentUser!.uid == snap['customerId']) {
      isCustomer = true;
    } else {
      isCustomer = false;
    }
    if (auth.currentUser!.uid == snap['driverId']) {
      isDriver = true;
    } else {
      isDriver = false;
    }
  }
  Future<void> loadCustomer() async {
    if (driverId != '') {
      DocumentSnapshot ds = await driversRef.doc(driverId).get();

      driver = DriverModel.fromSnapshot(ds);
      driverName = driver!.name;
      driverPhoto = driver!.photo;
    }

    DocumentSnapshot ds2 = await usersRef.doc(customerId).get();
    customer = UserModel.fromSnapshot(ds2);
    customerPhoto = customer!.photo;
    customerName = customer!.name;
  }
}
