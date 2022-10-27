import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/core/widgets/delete_widget.dart';
import 'package:abasu_app/features/products/model/product.dart';
import 'package:abasu_app/features/reviews/products/product_review_form.dart';
import 'package:abasu_app/features/reviews/products/product_review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme_colors.dart';

class ProductReviewsPage extends StatelessWidget {
  final Product? product;

  const ProductReviewsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${product!.productName}',
            style: const TextStyle(color: Colors.green)),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
        backgroundColor: ThemeColors.whiteColor,
        elevation: 0.0,
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductReviewForm(
                      product: product!,
                    )),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: productReviewsRef
          .where('productId', isEqualTo: product!.productId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();

        return _buildReviewsList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildReviewsList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildReview(context, data)).toList(),
    );
  }

  Widget _buildReview(BuildContext context, DocumentSnapshot data) {
    ProductReviewModel review = ProductReviewModel.fromSnapshot(data);
    return ListTile(
      leading: CircleAvatar(
        child: Text(review.reviewer!.substring(0, 1).toUpperCase()),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(review.reviewer!),
          review.isOwner!
              ? DeleteWidget(
                  delete: () {
                    Get.defaultDialog(
                      title: 'Delete Review',
                      middleText:
                          'Do you want to delete this Review and Rating?',
                      barrierDismissible: false,
                      radius: 25,
                      cancel: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                          )),
                      confirm: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () async {
                            await productReviewsRef
                                .doc(data.id)
                                .delete()
                                .then((value) async {
                              productsRef.doc(product!.productId).update({
                                'ratings':
                                    FieldValue.increment(-(product!.ratings)!),
                                'reviews': FieldValue.increment(-1)
                              });
                              successToastMessage(
                                  msg: 'Review Deleted Successfully');
                            });
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm')),
                    );
                  },
                  editable: false,
                )
              : Container(),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _reviewsStarWidget(review.rating!),
              Text(getTimestamp(review.createdAt!)),
            ],
          ),
          Text(review.comment!),
        ],
      ),
    );
  }

  Widget _reviewsStarWidget(int rating) {
    var stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      Icon star = i < rating
          ? const Icon(Icons.star, color: Colors.orangeAccent, size: 12)
          : const Icon(Icons.star_border, color: Colors.grey, size: 12);
      stars.add(star);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
