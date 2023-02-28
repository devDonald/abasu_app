import 'package:cloud_firestore/cloud_firestore.dart';

class PlacesModel {
  String? name, id;
  int? price;

  PlacesModel({this.name, this.id, this.price});

  toJson() {
    return {'id': id, 'name': name, 'price': price};
  }

  PlacesModel.fromSnapshot(DocumentSnapshot snap) {
    id = snap['id'];
    name = snap['name'];
    price = snap['price'];
  }
}
