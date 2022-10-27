import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/contants.dart';

class UserReviewModel {
  String? comment, reviewer, userId, artisanId;
  String? createdAt;
  Timestamp? timestamp;
  dynamic images, imagesNames;
  int? rating;
  bool? isOwner = false;

  UserReviewModel(
      {this.comment,
      this.rating,
      this.reviewer,
      this.userId,
      this.timestamp,
      this.createdAt,
      this.images,
      this.artisanId,
      this.imagesNames});

  UserReviewModel.fromSnapshot(DocumentSnapshot map) {
    reviewer = map['reviewer'];
    comment = map['comment'];
    rating = map['rating'];
    createdAt = map['createdAt'];
    artisanId = map['artisanId'];
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
      'userId': userId,
      'createdAt': createdAt,
      'timestamp': timestamp,
      'images': images,
      'imagesNames': imagesNames,
      'artisanId': artisanId,
    };
    return json;
  }
}
