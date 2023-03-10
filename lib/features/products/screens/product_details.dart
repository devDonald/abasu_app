import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/products/helpers/product_database.dart';
import 'package:abasu_app/features/products/model/cart_model.dart';
import 'package:abasu_app/features/reviews/products/product_review_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/widgets/other_widgets.dart';
import '../../admin/products/edit_product.dart';
import '../../home/pages/view_event_image.dart';
import '../model/product.dart';

class ProductDetails extends StatefulWidget {
  final String? itemName, itemId;
  final String? itemSubCategory;
  final String? itemDescription;
  final int? itemPrice, formerPrice;
  final List<dynamic> imageUrl;
  final String? itemQuantity;
  final String? itemCategory;
  final double? itemRating;
  final bool isAdmin, isTop;
  final Product product;
  // bool isfavorited;

  const ProductDetails(
      {Key? key,
      this.itemName,
      this.itemSubCategory,
      this.itemDescription,
      this.itemPrice,
      this.itemQuantity,
      this.itemCategory,
      this.itemRating,
      this.itemId,
      required this.imageUrl,
      required this.isAdmin,
      required this.isTop,
      required this.formerPrice,
      required this.product})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailsState();
  }
}

class _ProductDetailsState extends State<ProductDetails> {
  int flag = 0;
  String favorite = "true";
  var response2;
  final Set<dynamic> _saved = Set<dynamic>();
  String accountName = "";
  int iquantity = 0, reviewCount = 0;
  String? getQuantity, imageLink;
  final quantity = TextEditingController();
  var carttCount;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool? alreadySaved;
  int totalPrice = 1;

  int? length;

  Future getcommentCount() async {
    try {
      QuerySnapshot snapshot = await productsRef
          .doc(widget.itemId)
          .collection('reviews')
          .orderBy('timestamp', descending: true)
          .get();
      setState(() {
        reviewCount = snapshot.docs.length;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    quantity.text = '1';
    totalPrice = widget.itemPrice!;
    //getcommentCount();
    super.initState();
    // appMethods.getCartCount().then((result){
    //   setState(() {
    //     carttCount = result;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    alreadySaved = _saved.contains(widget.itemName);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.itemName!,
          style: const TextStyle(color: Colors.green),
        ),
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
        actions: [
          widget.isAdmin
              ? ProductAdminPopUp(
                  topProduct: () async {
                    Get.defaultDialog(
                      title: widget.isTop
                          ? 'Remove Top Product'
                          : 'Make Top Product',
                      middleText: widget.isTop
                          ? 'Do you want to Remove Top Product?'
                          : 'Do you want to Make Top Product?',
                      barrierDismissible: true,
                      radius: 25,
                      cancel: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                          )),
                      confirm: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () async {
                            await productsRef
                                .doc(widget.itemId)
                                .update({"isTop": widget.isTop ? false : true});
                            successToastMessage(
                                msg: widget.isTop
                                    ? 'Product Removed as Top Product'
                                    : 'Product Made Top Product');
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm')),
                    );
                  },
                  isTop: widget.isTop,
                  deleteTap: () async {
                    Get.defaultDialog(
                      title: 'Delete Product',
                      middleText: 'Do you want to delete this product?',
                      barrierDismissible: false,
                      radius: 25,
                      cancel: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                          )),
                      confirm: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () async {
                            await productsRef
                                .doc(widget.itemId)
                                .delete()
                                .then((value) {
                              successToastMessage(
                                  msg: 'Product Deleted Successfully');
                            });
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm')),
                    );
                  },
                  editTap: () {
                    Get.to(() => EditProduct(
                        productName: widget.itemName!,
                        productId: widget.itemId!,
                        productCategory: widget.itemCategory!,
                        subCategory: widget.itemSubCategory!,
                        description: widget.itemDescription!,
                        formerPrice: widget.formerPrice!,
                        currentPrice: widget.itemPrice!));
                  },
                )
              : Container(),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(0.0),
            child: Column(children: <Widget>[
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: widget.imageUrl.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  imageLink = widget.imageUrl[index];
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(ViewAttachedImage(
                                      image: CachedNetworkImageProvider(
                                          widget.imageUrl[index]),
                                      text: '',
                                      url: widget.imageUrl[index],
                                    ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                widget.imageUrl[index]),
                                            fit: BoxFit.cover)),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Card(
                child: Container(
                  width: screenSize.width,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(widget.itemName!,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.itemSubCategory!,
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                widget.product.reviews! <= 0
                                    ? _reviewsStarWidget(0)
                                    : _reviewsStarWidget(
                                        widget.product.ratings! ~/
                                            widget.product.reviews!)
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(children: <Widget>[
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "₦${format.format(widget.itemPrice)}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              )
                            ]),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        )
                      ]),
                ),
              ),
              Card(
                  child: Container(
                      width: screenSize.width,
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text('Description',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(widget.itemDescription!,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ))),
              Card(
                child: Container(
                  width: screenSize.width,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Quantity Available:',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              )),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(widget.itemQuantity!),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: <Widget>[
                          const Text('Category:',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              )),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            widget.itemCategory!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                      widget.isAdmin
                          ? Container()
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                const Text('Quantity to Purchase',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    )),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    CircleAvatar(
                                      child: IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () => _decrementCounter(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.0,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: quantity,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () => _incrementCounter(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Text('Total Price:',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      "₦${format.format(totalPrice)}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 50.0,
                      )
                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: BottomAppBar(
          color: widget.isAdmin ? Colors.white : Colors.green,
          elevation: 0.0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: widget.isAdmin
              ? Container()
              : Container(
                  height: 70.0,
                  decoration: const BoxDecoration(
                      // color: Theme.of(context).primaryColor
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: (screenSize.width - 20) / 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          ),
                          child: Text('REVIEWS (${widget.product.reviews})', style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            Get.to(() =>
                                ProductReviewsPage(product: widget.product));
                          },
                        ),
                      ),
                      SizedBox(
                          width: (screenSize.width - 100) / 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            ),
                            child: const Text("Add to Cart",style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              if (quantity.text != '') {
                                Get.defaultDialog(
                                  title: 'Add to Cart',
                                  middleText:
                                      ' Do you want to Add ${widget.itemName} to your Cart',
                                  barrierDismissible: false,
                                  radius: 25,
                                  cancel: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {
                                        Get.back();
                                        // Get.to(() => const ViewAllProducts());
                                      },
                                      child: const Text(
                                        'Cancel',
                                      )),
                                  confirm: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                      onPressed: () {
                                        ProductsDB.addToCart(CartModel(
                                          productName: widget.itemName,
                                          imageLink: imageLink,
                                          productId: widget.itemId,
                                          unitPrice: widget.itemPrice,
                                          quantity: int.parse(quantity.text),
                                          totalPrice: totalPrice,
                                        ));
                                        Get.back();
                                      },
                                      child: const Text('Add to Cart')),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Enter quantity to purchase",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                          )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // List<File> images;
  //   String productID  = await appMethods.userCart();
  //   List<String> imageUrl = await appMethods.uploadProductImages(
  //       docID: productID, imageList:itemImages);
  void _incrementCounter() {
    setState(() {
      //iquantity++;
      getQuantity = quantity.text;
      quantity.text = (int.parse(getQuantity!) + 1).toString();
      computePrice();
    });
  }

  void _decrementCounter() {
    setState(() {
      //iquantity--;
      getQuantity = quantity.text;
      quantity.text = (int.parse(getQuantity!) - 1).toString();
      computePrice();
    });
  }

  void computePrice() {
    int price = widget.itemPrice!;
    int quant = int.parse(quantity.text);
    totalPrice = price * quant;
  }

  Future _ackAlert(BuildContext context, String message, String header) =>
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(header),
            content: Text(message),
            actions: <Widget>[
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  Widget _reviewsStarWidget(int rating) {
    var stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      Icon star = i < rating
          ? const Icon(Icons.star, color: Colors.orangeAccent, size: 12)
          : const Icon(Icons.star_border, color: Colors.grey, size: 12);
      stars.add(star);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
