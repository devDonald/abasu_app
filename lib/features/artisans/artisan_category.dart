import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/artisans/artisan_items_card.dart';
import 'package:abasu_app/features/artisans/artisans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtisanCategory extends StatefulWidget {
  @override
  _ArtisanCategoryState createState() => _ArtisanCategoryState();
}

class _ArtisanCategoryState extends State<ArtisanCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: artisanCategory.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return ArtisanItemsCard(
                item: artisanCategory[index],
                icon: Icons.group_work,
                onTap: () {
                  Get.to(() => Artisans(
                        specialization: artisanCategory[index],
                        isAdmin: false,
                      ));
                },
              );
            }));
  }
}
