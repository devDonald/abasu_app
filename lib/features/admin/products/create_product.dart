import 'dart:convert';
import 'dart:io';

import 'package:abasu_app/features/products/helpers/product_category_helper.dart';
import 'package:abasu_app/features/products/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/contants.dart';
import '../../../../../core/themes/theme_colors.dart';
import '../../../../../core/widgets/add_photo_buttons.dart';
import '../../../../../core/widgets/customFullScreenDialog.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../products/helpers/product_database.dart';

class CreateProduct extends StatefulWidget {
  static const String id = 'CreateProduct';
  const CreateProduct({Key? key}) : super(key: key);

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
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
  final _picker = ImagePicker();
  List<File> _image = [];
  List<String> _imageNames = [];

  clearPhoto() {
    setState(() {
      isPhotoAdded = false;
    });
  }

  chooseImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
      _imageNames.add(File(pickedFile.path).path.split('/').last);
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  void _uploadProduct() async {
    try {
      User? _currentUser = FirebaseAuth.instance.currentUser;
      String uid = _currentUser!.uid;

      if (_image.isNotEmpty) {
        CustomFullScreenDialog.showDialog();
        List<String> url = await ProductsDB().uploadFile(_image);
        final Product model = Product(
          description: _description.text.trim(),
          subCategory: subCategoryOption,
          category: _category.text,
          productName: _productName.text,
          adminId: uid,
          imageUrls: url,
          imageNames: _imageNames,
          reviews: {},
          likes: {},
          isTop: false,
          longitude: longitude,
          latitude: latitude,
          availableUnits: 1000,
          unitPrice: int.parse(_currentPrice.text),
          formerPrice: int.parse(_formerPrice.text),
          ratings: {},
          approved: true,
        );
        await ProductsDB.addProduct(model);
        CustomFullScreenDialog.cancelDialog();
      } else {}

      Navigator.of(context).pop();
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
              const PostLabel(
                label: 'Product Category',
              ),
              const SizedBox(height: 9.5),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    controller: _category,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(hintText: 'Category'),
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
              const PostLabel(
                label: 'Product Sub Category',
              ),
              const SizedBox(height: 9.5),
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
              const PostLabel(label: 'Attach Images'),
              const SizedBox(height: 16.5),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: _image.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Center(
                                      child: IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () => !uploading
                                              ? chooseImage()
                                              : null),
                                    )
                                  : AddPhotoWidget(
                                      onClearTap: () {
                                        setState(() {
                                          print("index $index");
                                          _image.removeAt(index - 1);
                                        });
                                      },
                                      isPhotoAdded: true,
                                      fileImage: Container(
                                        margin: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(
                                                    _image[index - 1]),
                                                fit: BoxFit.cover)),
                                      ));
                            }),
                      ),
                    ],
                  )),
              const SizedBox(height: 16.5),
              Align(
                alignment: Alignment.bottomRight,
                child: PrimaryButton(
                  width: 150,
                  height: 36.5,
                  blurRadius: 3.0,
                  roundedEdge: 5.0,
                  color: ThemeColors.primaryColor,
                  buttonTitle: 'Post Product',
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
