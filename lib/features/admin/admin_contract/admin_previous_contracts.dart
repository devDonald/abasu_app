import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/admin/admin_contract/admin_add_previous_works.dart';
import 'package:abasu_app/features/admin/admin_contract/previous_contracts_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/other_widgets.dart';
import '../../profile/models/work_model.dart';

class AdminPreviousContract extends StatelessWidget {
  final bool isAdmin;

  const AdminPreviousContract({
    Key? key,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: const Text(
          'Abasu Konsult Previous Contracts',
          style: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
      ),
      body: PaginateFirestore(
        shrinkWrap: true,
        onEmpty: const Center(child: Text("No Previous Contracts Added Yet")),
        physics: const BouncingScrollPhysics(),
        itemsPerPage: 10,
        itemBuilder: (context, snapshot, index) {
          WorkModel _work = WorkModel.fromSnapshot(snapshot[index]);
          return PreviousWorksHeader(
              onTap: () {
                Get.to(() => PreviousContractsDetails(
                    isAdmin: isAdmin, model: _work, images: _work.images!));
              },
              title: _work.workTitle,
              description: _work.workDescription);
        },
        query: previousContractsRef.orderBy('workTitle', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: ThemeColors.blackColor1,
              child: const Icon(
                Icons.add,
                color: ThemeColors.whiteColor,
              ),
              onPressed: () {
                Get.to(() => const AdminAddPreviousWorks());
              },
            )
          : Container(),
    );
  }
}
