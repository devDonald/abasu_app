import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? productName, imageLink, productId, ownerId, cartId;
  int? unitPrice, totalPrice, quantity;

  CartModel(
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

  CartModel.fromSnapshot(DocumentSnapshot snap) {
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
