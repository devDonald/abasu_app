import 'package:abasu_app/core/widgets/other_widgets.dart';
import 'package:abasu_app/features/profile/models/work_model.dart';
import 'package:abasu_app/features/profile/pages/add_previous_works.dart';
import 'package:abasu_app/features/profile/pages/previous_works_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';

class MyPreviousWorks extends StatelessWidget {
  final bool isOwner;
  final String name, ownerId;
  const MyPreviousWorks(
      {Key? key,
      required this.isOwner,
      required this.name,
      required this.ownerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: Text(
          '$name Works',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
      ),
      body: PaginateFirestore(
        shrinkWrap: true,
        onEmpty: const Center(child: Text("No Previous Works Added Yet")),
        physics: const BouncingScrollPhysics(),
        itemsPerPage: 10,
        itemBuilder: (context, snapshot, index) {
          WorkModel _work = WorkModel.fromSnapshot(snapshot[index]);
          return PreviousWorksHeader(
              onTap: () {
                Get.to(() => PreviousWorksDetails(
                    category: _work.category!,
                    title: _work.workTitle!,
                    description: _work.workDescription!,
                    images: _work.images!));
              },
              title: _work.workTitle,
              description: _work.workDescription);
        },
        query: usersRef
            .doc(ownerId)
            .collection('previousWorks')
            .orderBy('workTitle', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
      floatingActionButton: isOwner
          ? FloatingActionButton(
              backgroundColor: ThemeColors.blackColor1,
              child: const Icon(
                Icons.add,
                color: ThemeColors.whiteColor,
              ),
              onPressed: () {
                Get.to(() => const AddPreviousWorks());
              },
            )
          : Container(),
    );
  }
}
