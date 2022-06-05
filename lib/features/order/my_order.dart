import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/order/order_card.dart';
import 'package:abasu_app/features/payment/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ProductOrders extends StatelessWidget {
  const ProductOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        shrinkWrap: true,
        onEmpty:
            const Center(child: Text("You have not Ordered any product yet")),
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
              if (snap.hasData) {}
              return OrderHeaderCard(
                onTap: () {},
                model: _work,
              );
            },
          );
        },
        query: ordersRef
            .where('customerId', isEqualTo: auth.currentUser!.uid)
            .orderBy('timestamp', descending: false),
        isLive: true,
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
