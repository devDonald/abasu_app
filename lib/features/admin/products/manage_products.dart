import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../../../core/constants/contants.dart';
import '../../../../../core/themes/theme_colors.dart';
import '../../artisans/artisan_items_card.dart';
import '../../products/screens/products.dart';
import 'create_product.dart';

class AdminProducts extends StatefulWidget {
  static const String id = 'AdminProducts';

  const AdminProducts({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminProductsState();
  }
}

class _AdminProductsState extends State<AdminProducts>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'New Posts'),
    Tab(text: 'Pinned'),
  ];
  @override
  initState() {
    _tabController = TabController(
      length: commTabs.length,
      initialIndex: 0,
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                    isAdmin: true,
                  ));
            },
          );
        },
        query: productCategoryRef.orderBy('name', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.blackColor1,
        child: const Icon(
          Icons.add,
          color: ThemeColors.whiteColor,
        ),
        onPressed: () {
          Get.to(() => const CreateProduct());
        },
      ),
    );
  }
}
