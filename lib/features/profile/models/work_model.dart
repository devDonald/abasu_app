import 'package:cloud_firestore/cloud_firestore.dart';

class WorkModel {
  String? workId, ownerId, category, workTitle, workDescription;
  List<dynamic>? images, imagesNames;

  WorkModel(
      {this.workId,
      this.ownerId,
      this.category,
      this.workTitle,
      this.workDescription,
      this.images,
      this.imagesNames});

  toJson() {
    return {
      'workId': workId,
      'ownerId': ownerId,
      'category': category,
      'workTitle': workTitle,
      'workDescription': workDescription,
      'images': images,
      'imagesNames': imagesNames
    };
  }

  WorkModel.fromSnapshot(DocumentSnapshot snap) {
    workId = snap['workId'];
    ownerId = snap['ownerId'];
    category = snap['category'];
    workTitle = snap['workTitle'];
    workDescription = snap['workDescription'];
    images = snap['images'];
    imagesNames = snap['imagesNames'];
  }
}
