import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/contants.dart';

class ProductHelper {
  Future<List<Map>> getCategory() async {
    List<Map> category = [];
    final docs = root.collection('ProductCategory');
    await docs
        .get(const GetOptions(source: Source.serverAndCache))
        .then((value) {
      for (var element in value.docs) {
        try {
          category.add({
            'name': element.data()['name'],
            'id': element.data()['id'],
            'sub': element.data()['sub'],
          });
        } catch (e) {
          print(e);
        }
      }
    });
    return category;
  }

  Future<List<Map>> getPlaces() async {
    List<Map> category = [];
    final docs = root.collection('places');
    await docs
        .get(const GetOptions(source: Source.serverAndCache))
        .then((value) {
      for (var element in value.docs) {
        try {
          category.add({
            'name': element.data()['name'],
            'id': element.data()['id'],
            'price': element.data()['price'],
          });
        } catch (e) {
          print(e);
        }
      }
    });
    return category;
  }
}
