class Products {
  int? price, quantity;
  String? productName;

  Products({this.price, this.quantity, this.productName});

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    quantity = json['quantity'];
    price = json['price'];
  }
}
