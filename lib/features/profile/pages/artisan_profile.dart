import 'package:abasu_app/features/artisans/hire_artisan.dart';
import 'package:abasu_app/features/profile/pages/my_previous_works.dart';
import 'package:abasu_app/features/profile/pages/user_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/flag_picker.dart';
import '../../../core/widgets/other_widgets.dart';
import '../../authentication/model/app_users_model.dart';
import '../../authentication/pages/overview_biocard.dart';

class HireArtisanProfile extends StatelessWidget {
  final UserModel user;
  final bool isAdmin;
  const HireArtisanProfile(
      {Key? key, required this.user, required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${user.name!} Profile',
          style: const TextStyle(color: Colors.green),
        ),
        actions: [
          isAdmin && user.isArtisan!
              ? ArtisanAdminPopUp(
                  makeTop: () async {
                    Get.defaultDialog(
                      title: user.isTop!
                          ? 'Remove Top Artisan'
                          : 'Make Top Artisan',
                      middleText: user.isTop!
                          ? 'Do you want to Remove Top Artisan?'
                          : 'Do you want to Make Top Artisan?',
                      barrierDismissible: true,
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
                            await usersRef
                                .doc(user.userId)
                                .update({"isTop": user.isTop! ? false : true});
                            successToastMessage(
                                msg: user.isTop!
                                    ? 'User Removed as Top Artisan'
                                    : 'User Made Top Artisan');
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm')),
                    );
                  },
                  isTop: user.isTop!,
                  isVerified: user.isVerified!,
                  verifyArtisanTap: () async {
                    Get.defaultDialog(
                      title: user.isVerified!
                          ? 'UnVerify Artisan'
                          : 'Verify Artisan',
                      middleText: user.isVerified!
                          ? 'Do you want to UnVerify this Artisan?'
                          : 'Do you want to Verify this Artisan?',
                      barrierDismissible: true,
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
                            await usersRef.doc(user.userId).update({
                              "isVerified": user.isVerified! ? false : true
                            });
                            successToastMessage(
                                msg: user.isVerified!
                                    ? 'User UnVerified'
                                    : 'User Verified');
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm')),
                    );
                  })
              : Container(),
        ],
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          UserProfileInfo(
            isFollowing: user.isOwner!,
            isOwner: user.isOwner!,
            profileImage: user.photo!,
            userId: user.userId!,
            country: user.country!,
            flag: FlagPicker(
              flagCode: user.code!,
            ),
            name: user.name!.toUpperCase(),
          ),
          const SizedBox(height: 10),
          user.isArtisan!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileTag(
                        onTap: () {
                          Get.to(() => MyPreviousWorks(
                              ownerId: user.userId!,
                              isOwner: false,
                              name: user.name!));
                        },
                        tag: 'Previous Works'),
                    ProfileTag(
                      onTap: () {
                        Get.to(() => HireArtisan(
                              artisanId: user.userId!,
                              number: user.phone!,
                              artisanName: user.name!,
                            ));
                      },
                      tag: 'Hire Artisan',
                    ),
                  ],
                )
              : Container(),
          OverViewBioCard(
            model: user,
            isArtisan: user.isArtisan!,
            charge: user.charge!,
            specialization: user.specialization!,
            skills: Wrap(
                spacing: 5.0,
                runSpacing: 8.5,
                direction: Axis.horizontal,
                children: user.isTagAdded! ? user.addedTags : [] //empty list,
                ),
            address: user.address!,
            email: isAdmin ? user.email! : '****************',
            phone: isAdmin
                ? "${user.dialCode}${user.phone}"
                : "${user.dialCode}**************",
            isOwner: user.isOwner!,
          )
        ],
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
