import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../core/constants/contants.dart';
import '../../core/themes/theme_colors.dart';
import '../../core/widgets/other_widgets.dart';
import '../authentication/model/app_users_model.dart';
import '../profile/pages/artisan_profile.dart';

class SearchPeople extends StatefulWidget {
  final TextEditingController? searchController;

  const SearchPeople({
    Key? key,
    this.searchController,
  }) : super(key: key);

  @override
  _SearchPeopleState createState() => _SearchPeopleState();
}

class _SearchPeopleState extends State<SearchPeople> {
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
            itemBuilder: (context, snapshot, index) {
              UserModel _users = UserModel.fromSnapshot(snapshot[index]);
              if (!_users.isOwner!) {
                return filter == ""
                    ? ArtisanSearchHeader(
                        isAdmin: false,
                        userName: _users.name!.toUpperCase(),
                        profileImage: _users.photo,
                        specialization: _users.specialization,
                        charge: _users.charge,
                        skills: Wrap(
                            spacing: 5.0,
                            runSpacing: 8.5,
                            direction: Axis.horizontal,
                            children: _users.isTagAdded!
                                ? _users.addedTags
                                : [] //empty list,
                            ),
                        address: _users.address,
                        onTap: () {
                          Get.to(() => HireArtisanProfile(
                                isAdmin: false,
                                user: _users,
                              ));
                        },
                        onFollow: () {},
                      )
                    : '${_users.specialization}'
                            .toLowerCase()
                            .contains(filter.toLowerCase())
                        ? ArtisanSearchHeader(
                            isAdmin: false,
                            userName: _users.name!.toUpperCase(),
                            profileImage: _users.photo,
                            specialization: _users.specialization,
                            charge: _users.charge,
                            skills: Wrap(
                                spacing: 5.0,
                                runSpacing: 8.5,
                                direction: Axis.horizontal,
                                children: _users.isTagAdded!
                                    ? _users.addedTags
                                    : [] //empty list,
                                ),
                            address: _users.address,
                            onTap: () {
                              Get.to(() => HireArtisanProfile(
                                    isAdmin: false,
                                    user: _users,
                                  ));
                            },
                            onFollow: () {},
                          )
                        : Container();
              } else {
                return Container();
              }
            },
            query: usersRef
                .where('type', isEqualTo: 'Artisan')
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
