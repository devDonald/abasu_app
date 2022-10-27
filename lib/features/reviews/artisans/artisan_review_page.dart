import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/authentication/model/app_users_model.dart';
import 'package:abasu_app/features/reviews/artisans/artisan_review_form.dart';
import 'package:abasu_app/features/reviews/artisans/user_review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/delete_widget.dart';

class ArtisanReviewsPage extends StatelessWidget {
  final UserModel? user;

  const ArtisanReviewsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${user!.name}', style: const TextStyle(color: Colors.green)),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
        backgroundColor: ThemeColors.whiteColor,
        elevation: 0.0,
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => ArtisanReviewForm(
                artisan: user!,
              ));
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: artisanReviewsRef
          .where('artisanId', isEqualTo: user!.userId)
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
    UserReviewModel review = UserReviewModel.fromSnapshot(data);
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
                            await artisanReviewsRef
                                .doc(data.id)
                                .delete()
                                .then((value) async {
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
