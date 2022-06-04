import 'package:abasu_app/features/cart_notification_controlloer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/contants.dart';
import '../helpers/product_database.dart';

class OrderPage extends GetView<CartNoteController> {
  final int count;
  const OrderPage({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetX<CartNoteController>(builder: (CartNoteController cart) {
        return ListView.builder(
            itemCount: cart.allCart.length,
            itemBuilder: (BuildContext context, int index) {
              final product = cart.allCart[index];
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  color: Colors.white70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: const Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image:
                                CachedNetworkImageProvider(product.imageLink!),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.productName!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 19)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Quantity: ${product.quantity!}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('Price: ₦${format.format(product.totalPrice)}',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Delete Product From Cart',
                                middleText:
                                    'Do you want to delete ${product.productName} from Cart',
                                barrierDismissible: false,
                                radius: 25,
                                cancel: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'No',
                                    )),
                                confirm: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () async {
                                      ProductsDB.deleteCart(product.cartId!);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes')),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.blueGrey,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
