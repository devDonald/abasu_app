import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/artisans/artisan_items_card.dart';
import 'package:abasu_app/features/artisans/artisans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/themes/theme_colors.dart';

class AdminViewAllArtisans extends StatefulWidget {
  const AdminViewAllArtisans({Key? key}) : super(key: key);

  @override
  _AdminViewAllArtisansState createState() => _AdminViewAllArtisansState();
}

class _AdminViewAllArtisansState extends State<AdminViewAllArtisans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.whiteColor,
          elevation: 3.0,
          titleSpacing: -5.0,
          title: const Text(
            'All Artisans',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.red, size: 35),
        ),
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
                        isAdmin: true,
                      ));
                },
              );
            }));
  }
}
