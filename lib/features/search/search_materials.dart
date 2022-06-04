import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../core/constants/contants.dart';
import '../../core/themes/theme_colors.dart';
import '../products/helpers/products_card.dart';
import '../products/model/product.dart';

class SearchMaterials extends StatefulWidget {
  final TextEditingController? searchController;

  const SearchMaterials({
    Key? key,
    this.searchController,
  }) : super(key: key);

  @override
  _SearchMaterialsState createState() => _SearchMaterialsState();
}

class _SearchMaterialsState extends State<SearchMaterials> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  String filter = '';
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  bool searchBar = false;

  @override
  initState() {
    searchFocus.requestFocus();
    widget.searchController!.addListener(() {
      if (mounted) {
        setState(() {
          filter = widget.searchController!.text;
        });
      }
      print('Filter: $filter');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ThemeColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: ThemeColors.shadowColor,
              blurRadius: 5,
              offset: Offset(0, 2.5),
            ),
          ],
        ),
        child: RefreshIndicator(
          child: PaginateFirestore(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemsPerPage: 15,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                childAspectRatio: 3 / 3.55,
                crossAxisCount: 2),
            itemBuilder: (context, snapshot, index) {
              Product product = Product.fromSnapshot(snapshot[index]);
              return filter == ""
                  ? ProductCard(
                      isAdmin: false,
                      isTop: product.isTop!,
                      subCategory: product.subCategory,
                      productName: product.productName,
                      price: product.unitPrice,
                      formerPrice: product.formerPrice,
                      productCategory: product.category,
                      productImages: product.imageUrls,
                      description: product.description,
                      productId: product.productId,
                    )
                  : '${product.productName}'
                          .toLowerCase()
                          .contains(filter.toLowerCase())
                      ? ProductCard(
                          isTop: product.isTop!,
                          isAdmin: false,
                          subCategory: product.subCategory,
                          productName: product.productName,
                          price: product.unitPrice,
                          formerPrice: product.formerPrice,
                          productCategory: product.category,
                          productImages: product.imageUrls,
                          description: product.description,
                          productId: product.productId,
                        )
                      : Container();
            },
            query: productsRef.orderBy('productName', descending: false),
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
