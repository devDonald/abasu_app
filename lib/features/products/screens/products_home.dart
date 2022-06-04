import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/artisans/artisan_items_card.dart';
import 'package:abasu_app/features/products/screens/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ProductsHome extends StatelessWidget {
  const ProductsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        shrinkWrap: true,
        onEmpty: noDataFound(),
        physics: const BouncingScrollPhysics(),
        itemsPerPage: 15,
        itemBuilder: (context, snapshot, index) {
          DocumentSnapshot snap = snapshot[index];
          return ArtisanItemsCard(
            item: snap['name'],
            icon: Icons.construction,
            onTap: () {
              Get.to(() => Products(
                    category: snap['name'],
                    isAdmin: false,
                  ));
            },
          );
        },
        query: productCategoryRef.orderBy('name', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
