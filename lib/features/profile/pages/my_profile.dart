import 'package:abasu_app/features/profile/pages/my_previous_works.dart';
import 'package:abasu_app/features/profile/pages/my_requests.dart';
import 'package:abasu_app/features/profile/pages/user_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/flag_picker.dart';
import '../../authentication/model/app_users_model.dart';
import '../../authentication/pages/overview_biocard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.green),
        ),
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        child: PaginateFirestore(
          physics: const BouncingScrollPhysics(),
          itemsPerPage: 1,
          itemBuilder: (context, snapshot, index) {
            UserModel _user = UserModel.fromSnapshot(snapshot[index]);
            return Column(
              children: [
                UserProfileInfo(
                  isFollowing: _user.isOwner!,
                  isOwner: _user.isOwner!,
                  profileImage: _user.photo!,
                  userId: _user.userId!,
                  country: _user.country!,
                  flag: FlagPicker(
                    flagCode: _user.code!,
                  ),
                  name: _user.name!.toUpperCase(),
                ),
                const SizedBox(height: 10),
                _user.isArtisan!
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProfileTag(
                              onTap: () {
                                Get.to(() => MyPreviousWorks(
                                    ownerId: _user.userId!,
                                    isOwner: true,
                                    name: _user.name!));
                              },
                              tag: 'My Previous Works'),
                          ProfileTag(
                            onTap: () {
                              Get.to(() => MyRequests());
                            },
                            tag: 'My Requests',
                          ),
                        ],
                      )
                    : Container(),
                OverViewBioCard(
                  isArtisan: _user.isArtisan!,
                  charge: _user.charge!,
                  model: _user,
                  specialization: _user.specialization!,
                  skills: Wrap(
                      spacing: 5.0,
                      runSpacing: 8.5,
                      direction: Axis.horizontal,
                      children:
                          _user.isTagAdded! ? _user.addedTags : [] //empty list,
                      ),
                  address: _user.address!,
                  email: _user.email!,
                  phone: "${_user.dialCode}${_user.phone}",
                  isOwner: _user.isOwner!,
                )
              ],
            );
          },
          // orderBy is compulsary to enable pagination
          query: usersRef.where('userId', isEqualTo: auth.currentUser!.uid),
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
    );
  }
}

class ProfileTag extends StatelessWidget {
  const ProfileTag({
    Key? key,
    this.tag,
    this.onTap,
  }) : super(key: key);

  final String? tag;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    //limited box
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 7.5),
        padding: const EdgeInsets.only(
          top: 4.5,
          bottom: 4.5,
          left: 10.5,
          right: 10.5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            9.5,
          ),
          color: ThemeColors.redColor,
        ),
        child: Text(
          tag!,
          maxLines: 1,
          style: const TextStyle(
              fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
