import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/products/model/product.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/themes/theme_colors.dart';
import '../helpers/products_card.dart';

class Products extends StatefulWidget {
  final String category;
  final bool isAdmin;
  const Products({Key? key, required this.category, required this.isAdmin})
      : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: Text(
          widget.category,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red, size: 35),
      ),
      body: Container(
        width: double.infinity,
        margin:
            const EdgeInsets.only(left: 10.0, top: 10, right: 10, bottom: 0.0),
        decoration: BoxDecoration(
          color: ThemeColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: ThemeColors.shadowColor,
              blurRadius: 5,
              offset: Offset(0, 1.0),
            ),
          ],
        ),
        child: RefreshIndicator(
          child: PaginateFirestore(
            shrinkWrap: true,
            onEmpty: noDataFound(),
            physics: const BouncingScrollPhysics(),
            itemsPerPage: 15,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                childAspectRatio: 3 / 3.55,
                crossAxisCount: 2),
            itemBuilder: (context, snapshot, index) {
              Product product = Product.fromSnapshot(snapshot[index]);
              return ProductCard(
                product: product,
                isTop: product.isTop!,
                isAdmin: widget.isAdmin,
                subCategory: product.subCategory,
                productName: product.productName,
                price: product.unitPrice,
                formerPrice: product.formerPrice,
                productCategory: product.category,
                productImages: product.imageUrls,
                description: product.description,
                productId: product.productId,
              );
            },
            query: productsRef
                .where('category', isEqualTo: widget.category)
                .orderBy('productName', descending: false),
            isLive: true,
            listeners: [
              refreshChangeListener,
            ],
            itemBuilderType: PaginateBuilderType.gridView,
          ),
          onRefresh: () async {
            refreshChangeListener.refreshed = true;
          },
        ),
      ),
    );
  }
}

Widget noDataFound() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(Icons.find_in_page, color: Colors.black38, size: 80.0),
        Text("No Products available yet",
            style: TextStyle(color: Colors.black45, fontSize: 20.0)),
        Text("Please check back later",
            style: TextStyle(color: Colors.red, fontSize: 14.0))
      ],
    ),
  );
}
