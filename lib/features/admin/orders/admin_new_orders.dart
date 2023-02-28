import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/order/order_card.dart';
import 'package:abasu_app/features/order/order_details.dart';
import 'package:abasu_app/features/payment/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class AdminNewOrders extends StatelessWidget {
  const AdminNewOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        shrinkWrap: true,
        onEmpty: const Center(child: Text("No product ordered yet")),
        physics: const BouncingScrollPhysics(),
        itemsPerPage: 10,
        itemBuilder: (context, snapshot, index) {
          OrderModel _work = OrderModel.fromSnapshot(snapshot[index]);
          Future<OrderModel> _load() async {
            await _work.loadCustomer();
            return _load();
          }

          return FutureBuilder(
            future: _load(),
            builder: (BuildContext context, AsyncSnapshot<OrderModel> snap) {
              return OrderHeaderCard(
                onTap: () {
                  Get.to(() => OrderDetails(model: _work, isAdmin: true));
                },
                model: _work,
              );
            },
          );
        },
        query: ordersRef
            .where('status', isEqualTo: 'Payment Successful')
            .orderBy('timestamp', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
