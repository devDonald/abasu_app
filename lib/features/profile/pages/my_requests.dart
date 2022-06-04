import 'package:abasu_app/features/artisans/artisan_request_body.dart';
import 'package:abasu_app/features/profile/models/requests_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/other_widgets.dart';

class MyRequests extends StatelessWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: const Text(
          'My Requests',
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
        onEmpty: const Center(child: Text("You have no work requests Yet")),
        physics: const BouncingScrollPhysics(),
        itemsPerPage: 10,
        itemBuilder: (context, snapshot, index) {
          RequestModel _work = RequestModel.fromSnapshot(snapshot[index]);
          Future<RequestModel> _load() async {
            await _work.loadCustomer();
            return _load();
          }

          return FutureBuilder(
            future: _load(),
            builder: (BuildContext context, AsyncSnapshot<RequestModel> snap) {
              if (snap.hasData) {}
              return WorksHeaderRequest(
                onTap: () {
                  Get.to(() => ArtisanRequestDetails(
                        isAdmin: false,
                        images: _work.images,
                        model: _work,
                      ));
                },
                model: _work,
              );
            },
          );
        },
        query: requestRef
            .where('artisanId', isEqualTo: auth.currentUser!.uid)
            .orderBy('timestamp', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
