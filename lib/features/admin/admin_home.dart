import 'package:abasu_app/features/admin/admin_contract/admin_contracts_home.dart';
import 'package:abasu_app/features/admin/admin_contract/admin_previous_contracts.dart';
import 'package:abasu_app/features/admin/products/admin_top_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';

import '../../../../core/constants/device_util.dart';
import '../../../../core/themes/theme_colors.dart';
import 'artisans/admin_request_home.dart';
import 'artisans/admin_top_artisan.dart';
import 'artisans/admin_view_all_artisan.dart';
import 'products/manage_products.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool isAdmin = false, isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  late String _uid;

  @override
  void initState() {
    super.initState();
    //checkInGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title:
            const Text('Admin Section', style: TextStyle(color: Colors.green)),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
        backgroundColor: ThemeColors.whiteColor,
        titleSpacing: 15.0,
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
            childAspectRatio: 1.0,
            crossAxisCount: 2),
        children: [
          HomeCard(
            icon: Icons.post_add,
            title: 'Manage Products',
            onTap: () async {
              Get.to(() => const AdminProducts());
            },
          ),
          HomeCard(
            icon: Icons.construction,
            title: 'Top Products',
            onTap: () async {
              Get.to(() => const AdminTopProducts());
            },
          ),
          HomeCard(
            icon: Icons.group_work,
            title: 'Manage Artisans',
            onTap: () async {
              Get.to(() => const AdminViewAllArtisans());
            },
          ),
          HomeCard(
            icon: Icons.group_work,
            title: 'Top Artisans',
            onTap: () async {
              Get.to(() => const AdminTopArtisans());
            },
          ),
          HomeCard(
            icon: Icons.car_rental,
            title: 'Manage Drivers',
            onTap: () async {
              Get.to(() => const AdminProducts());
            },
          ),
          HomeCard(
            icon: Icons.shopping_bag,
            title: 'Manage Orders',
            onTap: () async {
              Get.to(() => const AdminProducts());
            },
          ),
          HomeCard(
            icon: Icons.group_work,
            title: 'Manage Requests',
            onTap: () async {
              Get.to(() => const AdminRequestHome());
            },
          ),
          HomeCard(
            icon: Icons.report,
            title: 'Manage Reports',
            onTap: () async {
              Get.to(() => const AdminProducts());
            },
          ),
          HomeCard(
            icon: Icons.construction,
            title: 'Manage Contracts',
            onTap: () async {
              Get.to(() => const AdminContractHome());
            },
          ),
          HomeCard(
            icon: Icons.work_history,
            title: 'Previous Contracts',
            onTap: () async {
              Get.to(() => const AdminPreviousContract(isAdmin: true));
            },
          ),
        ],
      ),
    );
  }
}

class ButtonWithICon2 extends StatelessWidget {
  const ButtonWithICon2({
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
    return Container(
      width: 149,
      height: 40.0,
      margin: const EdgeInsets.only(
        top: 8.5,
        bottom: 8.5,
      ),
      padding: const EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: ThemeColors.shadowColor,
            offset: Offset(0.0, 2.5),
            blurRadius: 7.5,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: ThemeColors.whiteColor,
            ),
            const SizedBox(width: 9.2),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                title,
                style: const TextStyle(
                  color: ThemeColors.whiteColor,
                  fontSize: 15.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.height * 0.15,
          margin: const EdgeInsets.only(
              top: 10.0, bottom: 5.0, left: 15.0, right: 7.0),
          //padding: EdgeInsets.only(left: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.red,
                offset: Offset(0.0, 2.5),
                blurRadius: 3,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: ThemeColors.kellyGreen,
                  size: 35.0,
                ),
              ],
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class HomeCard1 extends StatelessWidget {
  const HomeCard1({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: width * 0.38,
          height: height * 0.16,
          margin: const EdgeInsets.only(
              top: 17.5, bottom: 5.0, left: 20.0, right: 20.0),
          //padding: EdgeInsets.only(left: 15.0),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: ThemeColors.whiteColor,
                offset: Offset(0.0, 2.5),
                blurRadius: 10.5,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: ThemeColors.whiteColor,
                  size: DeviceUtil.isTablet ? 60 : 35,
                ),
              ],
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
