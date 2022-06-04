import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/profile/pages/artisan_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../core/themes/theme_colors.dart';
import '../../core/widgets/other_widgets.dart';
import '../authentication/model/app_users_model.dart';

class Artisans extends StatefulWidget {
  final bool isAdmin;
  final String specialization;

  const Artisans(
      {Key? key, required this.specialization, required this.isAdmin})
      : super(key: key);

  @override
  State<Artisans> createState() => _ArtisansState();
}

class _ArtisansState extends State<Artisans> {
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
          widget.specialization,
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
            onEmpty: const Center(
                child: Text("No Artisan within this Specialization yet")),
            physics: const BouncingScrollPhysics(),
            itemsPerPage: 15,
            itemBuilder: (context, snapshot, index) {
              UserModel _users = UserModel.fromSnapshot(snapshot[index]);
              return ArtisanSearchHeader(
                isAdmin: widget.isAdmin,
                userName: _users.name!.toUpperCase(),
                profileImage: _users.photo,
                specialization: _users.specialization,
                charge: _users.charge,
                skills: Wrap(
                    spacing: 5.0,
                    runSpacing: 8.5,
                    direction: Axis.horizontal,
                    children:
                        _users.isTagAdded! ? _users.addedTags : [] //empty list,
                    ),
                address: _users.address,
                onTap: () {
                  Get.to(() => HireArtisanProfile(
                        isAdmin: widget.isAdmin,
                        user: _users,
                      ));
                },
                onFollow: () {},
              );
            },
            query: usersRef
                .where('type', isEqualTo: 'Artisan')
                .where("skills", arrayContains: widget.specialization)
                .orderBy('name', descending: false),
            isLive: true,
            listeners: [
              refreshChangeListener,
            ],
            itemBuilderType: PaginateBuilderType.listView,
          ),
          onRefresh: () async {
            refreshChangeListener.refreshed = true;
          },
        ),
      ),
    );
  }
}
