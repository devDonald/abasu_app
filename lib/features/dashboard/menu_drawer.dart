import 'dart:io';

import 'package:abasu_app/features/home/pages/terms_of_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_extend/share_extend.dart';

import '../../core/constants/contants.dart';
import '../../core/themes/theme_colors.dart';
import '../admin/admin_home.dart';
import '../authentication/pages/login_screen.dart';
import '../home/controller/drawer_controller.dart';
import '../home/pages/about_us.dart';
import '../home/pages/contact_us.dart';
import '../profile/pages/my_profile.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final CusDrawerController _auth = Get.put(CusDrawerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 10.2,
                  bottom: 20.5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    auth.currentUser!.email == 'donaldebuga@gmail.com' ||
                            auth.currentUser!.email == 'abasuteam@gmail.com' ||
                            auth.currentUser!.email ==
                                'fwangkatdaburak@gmail.com'
                        ? ButtonWithIcon(
                            icon: Icons.person,
                            title: 'Admin Section',
                            onTap: () {
                              Get.to(() => AdminHome());
                            },
                          )
                        : Container(),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.info,
                      title: 'About Us',
                      onTap: () {
                        Get.to(() => AboutUs());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.person,
                      title: 'My Profile',
                      onTap: () {
                        Get.to(() => ProfilePage());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.contact_mail,
                      title: 'Contact Us',
                      onTap: () {
                        Get.to(() => const ContactUs());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.book,
                      title: 'Terms and Conditions',
                      onTap: () {
                        Get.to(() => const TermsOfService());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: (Icons.share),
                      title: ('Invite Friends'),
                      onTap: () {
                        if (Platform.isAndroid) {
                          ShareExtend.share(
                            'Hey download the Abasu mobile app https://play.google.com/store/apps/details?id=com.abasukonsult.abasu_app',
                            'text',
                          );
                        }
                        if (Platform.isIOS) {
                          ShareExtend.share(
                            'Hey download the Abasu mobile app https://apps.apple.com/app/abasu-app/id1613981664',
                            'text',
                          );
                        }
                      },
                    ),
                    const Divider(
                      height: 15.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.exit_to_app,
                      title: 'Log Out',
                      onTap: () async {
                        Get.defaultDialog(
                          title: 'Logout of Account',
                          middleText:
                              'Are you sure you want to logout of your account? ',
                          barrierDismissible: false,
                          radius: 25,
                          cancel: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                //Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                              )),
                          confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                _auth.logout();
                                Get.offAll(() => LoginScreen(
                                      userType: 'Buyer',
                                    ));
                              },
                              child: const Text('Confirm')),
                        );
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 22.6,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                color: ThemeColors.blackColor1,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
