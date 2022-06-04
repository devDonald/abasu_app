import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? productName, category, subCategory, adminId, productId, description;
  int? unitPrice, availableUnits, formerPrice;
  dynamic imageUrls, imageNames, reviews, ratings, likes;
  bool? approved, isTop;
  double? latitude, longitude;

  Product(
      {this.approved,
      this.availableUnits,
      this.category,
      this.imageUrls,
      this.description,
      this.longitude,
      this.latitude,
      this.productId,
      this.productName,
      this.unitPrice,
      this.isTop,
      this.subCategory,
      this.imageNames,
      this.formerPrice,
      this.likes,
      this.ratings,
      this.reviews,
      this.adminId});

  toJson() {
    return {
      'productName': productName,
      'subCategory': subCategory,
      'unitPrice': unitPrice,
      'availableUnits': availableUnits,
      'approved': approved,
      'likes': likes,
      'formerPrice': formerPrice,
      'ratings': ratings,
      'reviews': reviews,
      'imageNames': imageNames,
      'imageUrls': imageUrls,
      'description': description,
      'longitude': longitude,
      'latitude': latitude,
      'category': category,
      'productId': productId,
      'adminId': adminId,
      'isTop': isTop
    };
  }

  Product.fromSnapshot(DocumentSnapshot firestore) {
    productName = firestore['productName'];
    subCategory = firestore['subCategory'];
    unitPrice = firestore['unitPrice'];
    availableUnits = firestore['availableUnits'];
    approved = firestore['approved'];
    imageUrls = firestore['imageUrls'];
    description = firestore['description'];
    latitude = firestore['latitude'];
    longitude = firestore['longitude'];
    productId = firestore['productId'];
    category = firestore['category'];
    isTop = firestore['isTop'];
    adminId = firestore['adminId'];
    likes = firestore['likes'];
    formerPrice = firestore['formerPrice'];
    ratings = firestore['ratings'];
    reviews = firestore['reviews'];
    imageNames = firestore['imageNames'];
  }
}
