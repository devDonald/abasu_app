import 'package:abasu_app/core/constants/contants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_text.dart';
import '../../profile/pages/edit_profile.dart';
import '../model/app_users_model.dart';

class OverViewBioCard extends StatelessWidget {
  const OverViewBioCard({
    Key? key,
    required this.address,
    required this.email,
    required this.phone,
    required this.isOwner,
    required this.isArtisan,
    required this.specialization,
    required this.charge,
    required this.skills,
    required this.model,
  }) : super(key: key);
  final String address;
  final String email;
  final String phone, specialization, charge;
  final Widget skills;
  final bool isOwner, isArtisan;
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(
              0.0,
              4.0,
            ),
            color: ThemeColors.shadowColor,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Address',
                style: TextStyle(
                  color: ThemeColors.blackColor1,
                  fontWeight: JanguAskFontWeight.kBoldText,
                  fontSize: 18,
                ),
              ),
              isOwner
                  ? GestureDetector(
                      onTap: () {
                        Get.to(() => EditProfile(
                              user: model,
                            ));
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Edit Bio',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: JanguAskFontWeight.kBoldText,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 17,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            address,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          isArtisan
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Charge per Day',
                      style: TextStyle(
                        color: ThemeColors.blackColor1,
                        fontWeight: JanguAskFontWeight.kBoldText,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '₦${format.format(int.parse(charge))}',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ThemeColors.primaryGreyColor,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Specialization',
                      style: TextStyle(
                        color: ThemeColors.blackColor1,
                        fontWeight: JanguAskFontWeight.kBoldText,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      specialization,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ThemeColors.primaryGreyColor,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Skills Category',
                      style: TextStyle(
                        color: ThemeColors.blackColor1,
                        fontWeight: JanguAskFontWeight.kBoldText,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    (skills != null) ? skills : Container(),
                  ],
                )
              : Container(),
          const SizedBox(height: 15.0),
          GestureDetector(
            onTap: () {
              launch('tel:$phone');
            },
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: ThemeColors.blackColor1,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  phone,
                  style: const TextStyle(
                    color: ThemeColors.primaryGreyColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              const Icon(
                Icons.email,
                color: ThemeColors.blackColor1,
                size: 18,
              ),
              const SizedBox(width: 12),
              Text(
                email,
                style: const TextStyle(
                  color: ThemeColors.primaryGreyColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
