import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/admin/places/places_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/post_title.dart';
import '../../../core/widgets/primary_button.dart';

class AddPlaces extends StatefulWidget {
  final bool isEdit;
  final PlacesModel? model;
  const AddPlaces({Key? key, required this.isEdit, this.model})
      : super(key: key);

  @override
  State<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  final _name = TextEditingController();
  final _price = TextEditingController();

  getEdit() {
    if (widget.isEdit) {
      _price.text = widget.model!.price!.toString();
      _name.text = widget.model!.name!;
    }
  }

  submitForm() async {
    DocumentReference docRef = placesRef.doc();

    if (widget.isEdit) {
      await placesRef
          .doc(widget.model!.id!)
          .update({'price': int.parse(_price.text), 'name': _name.text});
      Get.back();
      Navigator.of(context).pop();
    } else {
      PlacesModel model = PlacesModel(
        id: docRef.id,
        price: int.parse(_price.text),
        name: _name.text,
      );
      await docRef.set(model.toJson());
      Navigator.of(context).pop();
    }
  }

  @override
  initState() {
    getEdit();
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
          'Add Delivery Location',
          style: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
      ),
      body: Container(
        padding: const EdgeInsets.all(6),
        margin:
            const EdgeInsets.only(left: 10.0, top: 10, right: 10, bottom: 0.0),
        decoration: BoxDecoration(
          color: ThemeColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: ThemeColors.shadowColor,
              blurRadius: 5,
              offset: Offset(0, 1.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const PostLabel(label: 'Name of Location'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.words,
                autofocus: true,
                enableSuggestions: true,
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                decoration: const InputDecoration(
                  hintText: 'e.g Angwan Rukuba',
                ),
                minLines: 1,
                maxLines: 2, //fix
                controller: _name,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Price to Location'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: const TextInputType.numberWithOptions(),
                style: const TextStyle(color: Colors.black87, fontSize: 15.0),
                controller: _price,
                decoration: const InputDecoration(
                  hintText: 'e.g 10000',
                ),
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
                  buttonTitle: 'Submit',
                  onTap: () {
                    if (_name.text.isEmpty) {
                      errorToastMessage(
                          msg: 'name of location cannot be empty');
                      return;
                    } else if (_price.text.isEmpty) {
                      errorToastMessage(msg: 'Price cannot be empty');
                      return;
                    } else if (!_price.text.isNum) {
                      errorToastMessage(msg: 'Price must be a number');
                      return;
                    } else {
                      submitForm();
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
