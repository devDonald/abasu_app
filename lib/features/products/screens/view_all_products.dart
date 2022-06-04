import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/artisans/artisan_items_card.dart';
import 'package:abasu_app/features/products/screens/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/themes/theme_colors.dart';

class ViewAllProducts extends StatelessWidget {
  const ViewAllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: const Text(
          'All Products',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red, size: 35),
      ),
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
