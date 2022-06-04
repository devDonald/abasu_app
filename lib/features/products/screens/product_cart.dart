import 'dart:convert';

import 'package:abasu_app/features/cart_notification_controlloer.dart';
import 'package:abasu_app/features/products/screens/product_order_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/post_title.dart';
import '../helpers/product_category_helper.dart';
import '../helpers/product_database.dart';

class CartPage extends StatefulWidget {
  final int count;
  const CartPage({Key? key, required this.count}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool agree = false, proceed = false;
  final CartNoteController controller = Get.put(CartNoteController());

  final ProductHelper helper = ProductHelper();
  List<Map> places = <Map>[];
  final deliveryPrice = TextEditingController();
  final destination = TextEditingController();

  Future displayCategory() async {
    places = await helper.getPlaces();
  }

  @override
  void initState() {
    displayCategory();
    super.initState();
  }

  Size? screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    controller.totalPrice.value = getPrice();
    return Scaffold(
      bottomNavigationBar: widget.count == 0
          ? Container()
          : Container(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            _adminRespond(context);
                          },
                          child: Text(
                            'Proceed to Payment',
                            style: GoogleFonts.montserrat(),
                          )),
                    ),
                  ],
                ),
              ),
            ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: const Text(
          'My Shopping Cart',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red, size: 35),
      ),
      body: Column(
        children: [
          GetX<CartNoteController>(builder: (CartNoteController cart) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.allCart.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = cart.allCart[index];

                      return Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
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
                                    image: CachedNetworkImageProvider(
                                        product.imageLink!),
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
                                    Text(
                                        'Price: ₦${format.format(product.totalPrice)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
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
                                              ProductsDB.deleteCart(
                                                  product.cartId!);
                                              controller.totalPrice.value =
                                                  getPrice();
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
                    }),
              ],
            );
          }),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CheckboxListTile(
                    title: const Text("Add delivery cost"),
                    value: agree,
                    onChanged: (newValue) {
                      setState(() {
                        agree = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                agree
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 9.5),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                autofocus: false,
                                controller: destination,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                                decoration: const InputDecoration(
                                    hintText: 'Select Destination'),
                              ),
                              suggestionsCallback: (pattern) async {
                                // Here you can call http call
                                return places.where(
                                  (doc) => jsonEncode(doc)
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()),
                                );
                              },
                              itemBuilder: (context, dynamic suggestion) {
                                return ListTile(
                                  title: Text(suggestion['name']),
                                );
                              },
                              onSuggestionSelected: (dynamic suggestion) {
                                // This when someone click the items
                                deliveryPrice.text = '${suggestion['price']}';
                                destination.text = '${suggestion['name']}';
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  int getPrice() {
    int price = 0;
    controller.allCart.forEach((x) {
      price += x.totalPrice!;
    });
    return price;
  }

  List<Map> getAllItems() {
    List<Map> items = [];
    controller.allCart.forEach((x) {
      items.add({
        'productName': x.productName,
        'quantity': x.quantity,
        'price': x.totalPrice,
      });
    });
    return items;
  }

  void _adminRespond(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
              child: Container(
                height: 250,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5, top: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Product Total Price',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ),
                            Text('₦${format.format(getPrice())}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Delivery Cost',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ),
                            Text(
                                '₦${format.format(int.parse(deliveryPrice.text))}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Total Price',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ),
                            Text(
                                '₦${format.format((getPrice() + int.parse(deliveryPrice.text)))}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: (screenSize!.width - 50) / 2,
                          child: RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: const Text("Continue"),
                            onPressed: () async {
                              Get.to(()=> CardSupport(totalPrice: (getPrice() + int.parse(deliveryPrice.text)),
                                  items: getAllItems(),
                                  withDelivery: agree));
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ));
  }
}
