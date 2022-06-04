import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? productName, imageLink, productId, ownerId, cartId;
  int? unitPrice, totalPrice, quantity;

  OrderModel(
      {this.productName,
      this.imageLink,
      this.productId,
      this.ownerId,
      this.cartId,
      this.unitPrice,
      this.quantity,
      this.totalPrice});

  toJson() {
    return {
      'productName': productName,
      'imageLing': imageLink,
      'productId': productId,
      'ownerId': ownerId,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'quantity': quantity,
      'cartId': cartId,
    };
  }

  OrderModel.fromSnapshot(DocumentSnapshot snap) {
    productId = snap['productId'];
    imageLink = snap['imageLing'];
    productName = snap['productName'];
    ownerId = snap['ownerId'];
    quantity = snap['quantity'];
    unitPrice = snap['unitPrice'];
    totalPrice = snap['totalPrice'];
    cartId = snap['cartId'];
  }
}
