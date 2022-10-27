import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/core/widgets/delete_widget.dart';
import 'package:abasu_app/features/admin/places/add_places.dart';
import 'package:abasu_app/features/admin/places/places_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/themes/theme_colors.dart';

class PlacesHome extends StatelessWidget {
  const PlacesHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.whiteColor,
          elevation: 3.0,
          titleSpacing: -5.0,
          title: const Text(
            'Delivery Places',
            style: TextStyle(
              color: Colors.green,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.green, size: 35),
        ),
        body: PaginateFirestore(
          shrinkWrap: true,
          onEmpty: const Center(child: Text("No Places Added Yet")),
          physics: const BouncingScrollPhysics(),
          itemsPerPage: 10,
          itemBuilder: (context, snapshot, index) {
            PlacesModel _model = PlacesModel.fromSnapshot(snapshot[index]);
            return PlacesHeader(
              model: _model,
              onDelete: () {
                Get.defaultDialog(
                  title: 'Delete Delivery Location',
                  middleText:
                      'Do you want to delete this Delete Delivery Location?',
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
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () async {
                        await placesRef.doc(_model.id).delete();
                        successToastMessage(
                            msg: 'Location Successfully deleted');
                        Get.back();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirm')),
                );
              },
              onEdit: () {
                Get.to(() => AddPlaces(
                      isEdit: true,
                      model: _model,
                    ));
              },
            );
          },
          query: placesRef.orderBy('name', descending: false),
          isLive: true,
          itemBuilderType: PaginateBuilderType.listView,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ThemeColors.blackColor1,
          child: const Icon(
            Icons.add,
            color: ThemeColors.whiteColor,
          ),
          onPressed: () {
            Get.to(() => const AddPlaces(isEdit: false));
          },
        ));
  }
}

class PlacesHeader extends StatelessWidget {
  final PlacesModel model;
  final Function()? onEdit, onDelete;
  const PlacesHeader(
      {Key? key, required this.model, this.onEdit, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.name!,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 17,
                ),
              ),
              DeleteWidget(delete: onDelete!, onEdit: onEdit!, editable: true)
            ],
          ),
          Text(
            '₦${format.format(model.price)}',
            style: const TextStyle(
              color: ThemeColors.blackColor1,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
