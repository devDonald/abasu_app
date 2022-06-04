import 'package:abasu_app/features/artisans/artisan_request_body.dart';
import 'package:abasu_app/features/profile/models/requests_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/constants/contants.dart';
import '../../../core/widgets/other_widgets.dart';

class MyRequestedArtisans extends StatelessWidget {
  const MyRequestedArtisans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        shrinkWrap: true,
        onEmpty:
            const Center(child: Text("You have not Requested Any Artisan yet")),
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
            .where('ownerId', isEqualTo: auth.currentUser!.uid)
            .orderBy('timestamp', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
