import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/authentication/model/app_users_model.dart';
import 'package:abasu_app/features/reviews/artisans/user_review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme_colors.dart';
import '../smooth_rating_bar.dart';

class ArtisanReviewForm extends StatefulWidget {
  final UserModel artisan;

  const ArtisanReviewForm({Key? key, required this.artisan}) : super(key: key);

  @override
  _ArtisanReviewFormState createState() => _ArtisanReviewFormState();
}

class _ArtisanReviewFormState extends State<ArtisanReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _reviewerController = TextEditingController();
  final _commentController = TextEditingController();
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review ${widget.artisan.name}',
            style: const TextStyle(color: Colors.green)),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
        backgroundColor: ThemeColors.whiteColor,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: _form(context),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          // Reviewer form field
          SmoothStarRating(
            color: Colors.green,
            borderColor: Colors.grey,
            rating: rating,
            size: 50,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: false,
            spacing: 2.0,
            onRatingChanged: (value) {
              setState(() {
                rating = value;
                print('Rating: $rating');
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              controller: _reviewerController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (reviewer) {
                if (reviewer!.isEmpty) {
                  return 'Reviewers name field cannot be empty';
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextFormField(
              controller: _commentController,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  labelText: 'Review',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              maxLines: 5,
              validator: (comment) {
                if (comment!.isEmpty) return 'Review field cannot be empty';
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (rating.isEqual(0.0)) {
                    errorToastMessage(msg: 'please rate this product');
                  } else {
                    final review = UserReviewModel(
                      reviewer: _reviewerController.text,
                      rating: rating.toInt(),
                      comment: _commentController.text,
                      artisanId: widget.artisan.userId,
                      createdAt: createdAt,
                      timestamp: timestamp,
                      images: {},
                      imagesNames: {},
                      userId: auth.currentUser!.uid,
                    );
                    await artisanReviewsRef.add(review.toJson());

                    Navigator.pop(context);
                  }
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('Submit'),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
