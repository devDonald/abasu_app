import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/products/helpers/product_database.dart';
import 'package:abasu_app/features/products/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'authentication/model/app_users_model.dart';

class CartNoteController extends GetxController {
  static CartNoteController to = Get.find();
  RxInt cartCount = 0.obs;
  RxInt notificationCount = 0.obs;
  RxInt totalPrice = 0.obs;

  Rx<List<CartModel>> cartList = Rx<List<CartModel>>([]);
  List<CartModel> get allCart => cartList.value;

  _getCount() {
    usersRef
        .doc(auth.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      UserModel model = UserModel.fromSnapshot(documentSnapshot);
      cartCount.value = model.cart!;
      notificationCount.value = model.info!;
    }).onError((e) => print(e));
  }

  @override
  void onReady() {
    super.onReady();
    _getCount();
    cartList.bindStream(ProductsDB.cartStream());
  }
}
