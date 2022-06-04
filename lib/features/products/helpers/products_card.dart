import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/contants.dart';
import '../screens/product_details.dart';
import 'buttons.dart';

class ProductCard extends StatelessWidget {
  final String? productName,
      productCategory,
      productId,
      subCategory,
      description;
  final int? price, formerPrice;
  final List<dynamic>? productImages;
  final bool isAdmin, isTop;

  const ProductCard(
      {Key? key,
      required this.productName,
      required this.productImages,
      required this.price,
      required this.description,
      required this.productCategory,
      required this.formerPrice,
      required this.productId,
      required this.subCategory,
      required this.isTop,
      required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 3.0,
        left: 3.0,
        right: 3.0,
        bottom: 3.0,
      ),
      padding: const EdgeInsets.only(
        left: 3.0,
        right: 3.0,
        top: 3.0,
        bottom: 3.0,
      ),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(
              0.0,
              2.5,
            ),
            blurRadius: 8.0,
            color: Colors.white60,
          )
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ProductDetails(
                formerPrice: formerPrice,
                isTop: isTop,
                itemDescription: description,
                imageUrl: productImages!,
                itemName: productName,
                itemPrice: price,
                itemQuantity: 'unlimited',
                itemSubCategory: subCategory,
                itemId: productId,
                itemCategory: productCategory,
                isAdmin: isAdmin,
              ));
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return AlbumStacks(
                            color: Colors.white,
                            image: productImages![index],
                          );
                        }),
                  ),
                ],
              ),
              // SizedBox(height: 5),
              TitleText(
                text: productName,
                fontSize: 18,
              ),
              Center(
                child: TitleText(
                  text: subCategory,
                  fontSize: 12,
                  color: Colors.green,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleText(
                    text: '₦${format.format(price)}',
                    fontSize: 16,
                  ),
                  const SizedBox(width: 3),
                  Text('₦${format.format(formerPrice)}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16)),
                ],
              ),
              const SizedBox(height: 5),
              const BuyButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const TitleText(
      {Key? key,
      this.text,
      this.fontSize = 18,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w800})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: GoogleFonts.mulish(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}

class AlbumStacks extends StatelessWidget {
  const AlbumStacks({
    Key? key,
    this.color,
    this.image,
  }) : super(key: key);
  final Color? color;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(
            20,
          ),
          bottomRight: Radius.circular(
            20.0,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(
            50.0,
          ),
          bottomRight: Radius.circular(
            50.0,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: image!,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
