import 'dart:io';

import 'package:abasu_app/features/products/model/cart_model.dart';
import 'package:abasu_app/features/products/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import '../../../core/constants/contants.dart';

class ProductsDB {
  static addProduct(Product todomodel) async {
    DocumentReference docRef = productsRef.doc();
    todomodel.productId = docRef.id;
    docRef.set(todomodel.toJson()).then((doc) async {
      successToastMessage(msg: 'Product Added Successfully');
    }).catchError((onError) async {
      errorToastMessage(msg: onError.toString());
    });
  }

  static Future addToCart(CartModel cartModel) async {
    DocumentReference docRef =
        cartRef.doc(auth.currentUser!.uid).collection('myCart').doc();
    cartModel.cartId = docRef.id;
    docRef.set(cartModel.toJson()).then((doc) async {
      await usersRef
          .doc(auth.currentUser!.uid)
          .update({"cart": FieldValue.increment(1)});
      successToastMessage(msg: 'Product Added to Cart Successfully');
    }).catchError((onError) async {
      errorToastMessage(msg: onError.toString());
    });
  }

  static Stream<List<CartModel>> cartStream() {
    return cartRef
        .doc(auth.currentUser!.uid)
        .collection('myCart')
        .snapshots()
        .map((QuerySnapshot query) {
      List<CartModel> allCart = [];
      for (var todo in query.docs) {
        final todoModel = CartModel.fromSnapshot(todo);
        allCart.add(todoModel);
      }
      return allCart;
    });
  }

  static Stream<int> cartPrice() {
    int price = 0;
    return cartRef
        .doc(auth.currentUser!.uid)
        .collection('myCart')
        .snapshots()
        .map((QuerySnapshot query) {
      for (var todo in query.docs) {
        int localprice = 0;
        final todoModel = CartModel.fromSnapshot(todo);
        localprice = localprice + todoModel.totalPrice!;
        price = localprice;
      }
      return price;
    });
  }

  static void deleteCart(String cartID) {
    cartRef
        .doc(auth.currentUser!.uid)
        .collection('myCart')
        .doc(cartID)
        .delete()
        .then((value) async {
      await usersRef
          .doc(auth.currentUser!.uid)
          .update({"cart": FieldValue.increment(-1)});
      successToastMessage(msg: 'Product removed from cart');
    });
  }

  Future<List<String>> uploadFile(List<File> file) async {
    List<String> urls = [];
    for (var i = 0; i < file.length; i++) {
      var storageReference = FirebaseStorage.instance
          .ref()
          .child("products")
          .child(Path.basename(file[i].path));
      await storageReference.putFile(file[i]);

      var url = await storageReference.getDownloadURL();

      urls.add(url);
    }
    return urls;
  }

  static void deleteFile(List<dynamic> images) async {
    for (var i = 0; i < images.length; i++) {
      String filePath = 'products/${images[i]}';
      var storageReference = FirebaseStorage.instance.ref();
      await storageReference.child(filePath).delete();
    }
  }
}
