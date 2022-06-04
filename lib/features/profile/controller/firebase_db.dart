import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/contants.dart';
import '../../authentication/model/app_users_model.dart';

class FirestoreUserDb {
  static Future<UserModel> user() async {
    DocumentSnapshot _doc = await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    UserModel user = UserModel.fromSnapshot(_doc);

    return user;
  }

  static updateProfile(UserModel user) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(user.updateUser())
        .then((value) {
      successToastMessage(msg: 'User Profile Updated Successfully');
    });
  }

  static deleteTodo(String documentId) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}
