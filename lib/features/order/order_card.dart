import 'package:abasu_app/features/payment/order_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants/contants.dart';
import '../../core/themes/theme_colors.dart';
import '../../core/themes/theme_text.dart';

class OrderHeaderCard extends StatelessWidget {
  const OrderHeaderCard({Key? key, this.onTap, required this.model})
      : super(key: key);
  final Function()? onTap;
  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
        decoration: BoxDecoration(
          color: ThemeColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              offset: Offset(
                0.0,
                2.5,
              ),
              color: ThemeColors.shadowColor,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 7,
                top: 7,
              ),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Text(
                model.orderId!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 15,
                  color: ThemeColors.whiteColor,
                  fontWeight: JanguAskFontWeight.kBoldText,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(
                top: 8,
                left: 9,
                right: 9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Products Purchased',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  model.products!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.products!.length,
                          itemBuilder: (context, index) {
                            int price = model.products![index].price!;
                            String productName =
                                model.products![index].productName!;
                            int quantity = model.products![index].quantity!;

                            return Container(
                              margin: const EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text('Quantity:  $quantity ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text('₦${format.format(price)}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                            );
                          })
                      : Container(),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Status:',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${model.status}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            model.withDelivery!
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          '${model.destination}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Total Price:',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '₦${format.format(model.price)}',
                    style: const TextStyle(
                      color: ThemeColors.blackColor1,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'See More',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ), //make sure textfeild fot this takes only 3 lines
              ),
            ),
          ],
        ),
      ),
    );
  }
}
