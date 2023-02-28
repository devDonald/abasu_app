import 'package:abasu_app/features/admin/drivers/driver_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import 'driver_header_widget.dart';
import 'driver_model.dart';

class VerifiedDrivers extends StatelessWidget {
  const VerifiedDrivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: PaginateFirestore(
          shrinkWrap: true,
          onEmpty: const Center(child: Text("No verified Drivers Yet")),
          physics: const BouncingScrollPhysics(),
          itemsPerPage: 15,
          itemBuilder: (context, snapshot, index) {
            DriverModel _driver = DriverModel.fromSnapshot(snapshot[index]);
            return DriverHeaderWidget(
              model: _driver,
              onTap: () {
                Get.to(() => DriverProfile(
                      driver: _driver,
                    ));
              },
            );
          },
          query: driversRef
              .where('isVerified', isEqualTo: true)
              .orderBy('name', descending: false),
          isLive: true,
          itemBuilderType: PaginateBuilderType.listView,
        ),
      ),
    );
  }
}
