import 'package:abasu_app/features/artisans/artisan_request_body.dart';
import 'package:abasu_app/features/profile/models/requests_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../../../core/constants/contants.dart';
import '../../../../../core/widgets/other_widgets.dart';

class AdminNewRequests extends StatelessWidget {
  const AdminNewRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        shrinkWrap: true,
        onEmpty: const Center(child: Text("No new Requests yet")),
        physics: const BouncingScrollPhysics(),
        itemsPerPage: 15,
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
                        isAdmin: true,
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
            .where('status', isEqualTo: 'New Request')
            .orderBy('timestamp', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
