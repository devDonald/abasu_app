import 'dart:convert';

import 'package:abasu_app/features/products/helpers/product_category_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../../core/constants/contants.dart';
import '../../../../../core/themes/theme_colors.dart';
import '../../../../../core/widgets/customFullScreenDialog.dart';
import '../../../../../core/widgets/primary_button.dart';

class EditProduct extends StatefulWidget {
  final String productName,
      productId,
      productCategory,
      subCategory,
      description;
  final int formerPrice, currentPrice;
  static const String id = 'CreateProduct';
  const EditProduct(
      {Key? key,
      required this.productName,
      required this.productId,
      required this.productCategory,
      required this.subCategory,
      required this.description,
      required this.formerPrice,
      required this.currentPrice})
      : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String error = '';
  String subCategoryOption = "";
  bool isPhotoAdded = false;
  bool uploading = false;
  final _description = TextEditingController();
  final _category = TextEditingController();
  final _productName = TextEditingController();
  final _currentPrice = TextEditingController();
  final _formerPrice = TextEditingController();

  final FocusNode focusNode = FocusNode();

  void _uploadProduct() async {
    try {
      CustomFullScreenDialog.showDialog();
      productsRef.doc(widget.productId).update({
        'productName': _productName.text,
        'subCategory': subCategoryOption,
        'unitPrice': int.parse(_currentPrice.text),
        'formerPrice': int.parse(_formerPrice.text),
        'description': _description.text,
        'category': _category.text,
      }).then((value) {
        successToastMessage(msg: 'Product Updated Successfully');
        CustomFullScreenDialog.cancelDialog();
        Navigator.of(context).pop();
      });
    } catch (e) {}
    //bodyValue.clear();
  }

  List<Map> csearch = <Map>[];
  List<dynamic> subCategory = [];
  final ProductHelper helper = ProductHelper();

  Future displayCategory() async {
    csearch = await helper.getCategory();
  }

  @override
  void initState() {
    _productName.text = widget.productName;
    _category.text = widget.productCategory;
    subCategoryOption = widget.subCategory;
    _description.text = widget.description;
    _formerPrice.text = widget.formerPrice.toString();
    _currentPrice.text = widget.currentPrice.toString();
    displayCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red, size: 35),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: Offset(0.0, 2.5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const PostLabel(label: 'Product Name'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.words,
                autofocus: true,
                enableSuggestions: true,
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                minLines: 1,
                maxLines: 2, //fix
                controller: _productName,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Product Description'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                enableSuggestions: true,
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                minLines: 1,
                maxLines: 8, //fix
                controller: _description,
              ),
              const SizedBox(height: 16.5),
              PostLabel(
                label: 'Product Category',
              ),
              SizedBox(height: 9.5),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    controller: _category,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                    decoration: InputDecoration(hintText: 'Category'),
                  ),
                  suggestionsCallback: (pattern) async {
                    // Here you can call http call
                    return csearch.where(
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
                    _category.text = '${suggestion['name']}';
                    setState(() {
                      subCategory = suggestion['sub'];
                      print('subcat $subCategory');
                    });
                  },
                ),
              ),
              PostLabel(
                label: 'Product Sub Category',
              ),
              SizedBox(height: 9.5),
              Row(
                children: [
                  const SizedBox(width: 8),
                  DropDown(
                    showUnderline: true,
                    items: subCategory,
                    hint: const Text("Select Sub Category"),
                    icon: const Icon(
                      Icons.expand_more,
                      color: Colors.pink,
                    ),
                    onChanged: (dynamic value) {
                      subCategoryOption = value!;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Current Price'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.number,
                autofocus: true,
                enableSuggestions: true,
                style: const TextStyle(
                    color: Colors.black87, fontSize: 15.0), //fix
                controller: _currentPrice,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Former Price'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.number,
                autofocus: true,
                enableSuggestions: true,
                style: const TextStyle(
                    color: Colors.black87, fontSize: 15.0), //fix
                controller: _formerPrice,
              ),
              const SizedBox(height: 16.5),
              Align(
                alignment: Alignment.bottomRight,
                child: PrimaryButton(
                  width: 150,
                  height: 36.5,
                  blurRadius: 3.0,
                  roundedEdge: 5.0,
                  color: ThemeColors.primaryColor,
                  buttonTitle: 'Update Product',
                  onTap: () {
                    if (validateProduct(
                        _productName.text,
                        _description.text,
                        _category.text,
                        subCategoryOption,
                        _currentPrice.text,
                        _formerPrice.text)) {
                      _uploadProduct();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostTextFeild extends StatelessWidget {
  const PostTextFeild(
      {Key? key,
      required this.hint,
      required this.height,
      required this.maxLines,
      required this.textController,
      required bool isBorder,
      required this.capitalization})
      : super(key: key);
  final String hint;
  final double height;
  final int maxLines;
  final TextEditingController textController;
  final TextCapitalization capitalization;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        maxLines: maxLines,
        textCapitalization: capitalization,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        controller: textController,
      ),
    );
  }
}

class PostLabel extends StatelessWidget {
  const PostLabel({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
