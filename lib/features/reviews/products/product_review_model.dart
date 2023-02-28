import 'package:abasu_app/core/constants/contants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductReviewModel {
  String? comment, reviewer, productId, userId;
  int? rating;
  String? createdAt;
  Timestamp? timestamp;
  dynamic images, imagesNames;
  bool? isOwner = false;

  ProductReviewModel(
      {this.comment,
      this.rating,
      this.reviewer,
      this.productId,
      this.timestamp,
      this.createdAt,
      this.images,
      this.imagesNames,
      this.userId});

  ProductReviewModel.fromSnapshot(DocumentSnapshot map) {
    reviewer = map['reviewer'];
    comment = map['comment'];
    rating = map['rating'];
    productId = map['productId'];
    createdAt = map['createdAt'];
    userId = map['userId'];
    if (auth.currentUser!.uid == map['userId']) {
      isOwner = true;
    } else {
      isOwner = false;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'reviewer': reviewer,
      'rating': rating,
      'comment': comment,
      'productId': productId,
      'createdAt': createdAt,
      'timestamp': timestamp,
      'images': images,
      'imagesNames': imagesNames,
      'userId': userId,
    };
    return json;
  }
}
