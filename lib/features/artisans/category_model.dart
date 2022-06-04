import 'package:cloud_firestore/cloud_firestore.dart';

class ArtisanCategoryModel {
  String? name;

  ArtisanCategoryModel({
    this.name,
  });

  ArtisanCategoryModel.fromSnapshot(DocumentSnapshot snap) {
    name = snap['name'];
  }
}
