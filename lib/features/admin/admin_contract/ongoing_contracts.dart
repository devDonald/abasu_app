import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/constants/contants.dart';
import '../../../core/widgets/other_widgets.dart';
import '../../profile/models/requests_model.dart';
import 'admin_contract_details.dart';

class AdminOngoingContracts extends StatelessWidget {
  const AdminOngoingContracts({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        shrinkWrap: true,
        onEmpty: const Center(child: Text("You have no Ongoing Contracts Yet")),
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
                  Get.to(() => AdminContractDetails(
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
        query: contractsRef
            .where('status', isEqualTo: 'Ongoing')
            .orderBy('timestamp', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
