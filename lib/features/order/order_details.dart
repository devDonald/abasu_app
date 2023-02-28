import 'package:abasu_app/features/admin/drivers/driver_model.dart';
import 'package:abasu_app/features/admin/drivers/driver_profile.dart';
import 'package:abasu_app/features/notification/notification_type.dart';
import 'package:abasu_app/features/profile/pages/artisan_profile.dart';
import 'package:abasu_app/features/sms/sms_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_text.dart';
import '../../core/constants/contants.dart';
import '../../core/widgets/delete_widget.dart';
import '../../core/widgets/profile_picture.dart';
import '../notification/send_notification.dart';
import '../payment/order_model.dart';

class OrderDetails extends StatefulWidget {
  final OrderModel? model;
  final bool isAdmin;
  const OrderDetails({Key? key, required this.model, required this.isAdmin})
      : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Size? screenSize;
  DriverModel? drivers;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        actions: [
          RespondWidget(
              delete: () {
                Get.defaultDialog(
                  title: 'Delete Order',
                  middleText: 'Do you want to delete this Order?',
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
                        await ordersRef.doc(widget.model!.orderId).delete();
                        successToastMessage(msg: 'Order Successfully deleted');
                        Get.back();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirm')),
                );
              },
              onEdit: () {
                _artisanRespond(context);
              },
              editable: true)
        ],
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
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
                  widget.model!.orderId!.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    color: ThemeColors.whiteColor,
                    fontWeight: JanguAskFontWeight.kBoldText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
                    widget.model!.products!.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.model!.products!.length,
                            itemBuilder: (context, index) {
                              int price = widget.model!.products![index].price!;
                              String productName =
                                  widget.model!.products![index].productName!;
                              int quantity =
                                  widget.model!.products![index].quantity!;

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
                      '${widget.model!.status}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              widget.model!.withDelivery!
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
                            '${widget.model!.destination}',
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
                      '₦${format.format(widget.model!.price)}',
                      style: const TextStyle(
                        color: ThemeColors.blackColor1,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              widget.isAdmin && widget.model!.withDelivery!
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          child: const Text('Assign Driver'),
                          onPressed: () {
                            _selectDrivers(context);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Customer',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    widget.model!.driverId != ''
                        ? const Text(
                            'Driver',
                            style: TextStyle(
                              color: ThemeColors.blackColor1,
                              fontSize: 15.0,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                color: ThemeColors.pinkishGreyColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //subject
                  GestureDetector(
                    onTap: () {
                      if (widget.isAdmin) {
                        Get.to(() => HireArtisanProfile(
                            user: widget.model!.customer!,
                            isAdmin: widget.isAdmin));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ProfilePicture(
                          image: CachedNetworkImageProvider(
                            widget.model!.customerPhoto!,
                          ),
                          width: 30.0,
                          height: 29.5,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          widget.model!.customerName!,
                          // maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: ThemeColors.primaryGreyColor,
                            fontWeight: JanguAskFontWeight.kBoldText,
                            fontSize: 12.0,
                            fontFamily: JanguAskFontFamily.secondaryFontLato,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                      ],
                    ),
                  ),

                  widget.model!.driverId != ''
                      ? GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                DriverProfile(driver: widget.model!.driver!));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ProfilePicture(
                                image: CachedNetworkImageProvider(
                                  widget.model!.driverPhoto!,
                                ),
                                width: 30.0,
                                height: 29.5,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                widget.model!.driverName!,
                                // maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: ThemeColors.primaryGreyColor,
                                  fontWeight: JanguAskFontWeight.kBoldText,
                                  fontSize: 12.0,
                                  fontFamily:
                                      JanguAskFontFamily.secondaryFontLato,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                            ],
                          ),
                        )
                      : Container(),

                  //level
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _artisanRespond(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
              child: Container(
                height: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text("Order Received"),
                          onPressed: () async {
                            await ordersRef.doc(widget.model!.orderId).update({
                              'status': NotificationType.orderReceived,
                            }).then((value) {
                              SMSClass().sendSMS(adminSms1,
                                  "${widget.model!.customer!.name} updated the status of their Order to ORDER RECEIVED on the Abasu App");
                              successToastMessage(msg: 'Order status updated');
                              Navigator.of(context).pop();
                            });
                          },
                        )),
                    const SizedBox(height: 5),
                    widget.isAdmin
                        ? SizedBox(
                            width: (screenSize!.width - 50) / 2,
                            child: RaisedButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              child: const Text("Order Confirmed"),
                              onPressed: () async {
                                await ordersRef
                                    .doc(widget.model!.orderId)
                                    .update({
                                  'status': NotificationType.orderConfirmed,
                                }).then((value) {
                                  SMSClass().sendSMS(
                                      widget.model!.customer!.phone!,
                                      "Hello, ${widget.model!.customer!.name} Abasu Admin updated the status of your Order to ORDER CONFIRMED on the Abasu App");

                                  if (!widget.model!.withDelivery!) {
                                    SMSClass().sendSMS(
                                        widget.model!.customer!.phone!,
                                        "Hello, ${widget.model!.customer!.name} call Abasu Admin on 08036795246 to pick up your order as you didn't enabled delivery when ordering");
                                  }
                                  successToastMessage(
                                      msg: 'Order status updated');
                                  Navigator.of(context).pop();
                                });
                              },
                            ))
                        : Container(),
                    const SizedBox(height: 5),
                    widget.isAdmin
                        ? SizedBox(
                            width: (screenSize!.width - 50) / 2,
                            child: RaisedButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              child: const Text("Processing Order"),
                              onPressed: () async {
                                await ordersRef
                                    .doc(widget.model!.orderId)
                                    .update({
                                  'status': NotificationType.orderProcessing,
                                }).then((value) {
                                  SMSClass().sendSMS(
                                      widget.model!.customer!.phone!,
                                      "Hello, ${widget.model!.customer!.name} Abasu Admin updated the status of your Order to PROCESSING ORDER on the Abasu App, your order is being processed for ");

                                  successToastMessage(
                                      msg: 'Order status updated');
                                  Navigator.of(context).pop();
                                });
                              },
                            ))
                        : Container(),
                  ],
                ),
              ),
            ));
  }

  void _selectDrivers(BuildContext context) {
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
                height: 210,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: PaginateFirestore(
                    shrinkWrap: true,
                    onEmpty:
                        const Center(child: Text("No Registered Driver yet")),
                    physics: const BouncingScrollPhysics(),
                    itemsPerPage: 10,
                    itemBuilder: (context, snapshot, index) {
                      DriverModel driver =
                          DriverModel.fromSnapshot(snapshot[index]);
                      return GestureDetector(
                        onTap: () async {
                          await ordersRef.doc(widget.model!.orderId).update({
                            'driverId': driver.driverId,
                            'status': NotificationType.orderDriverAssigned,
                          }).then((value) {
                            SendNoti.sendDriver(
                                widget.model!.orderId!,
                                driver.driverId!,
                                'Abasu Admin',
                                NotificationType.orderDriverAssigned,
                                'New Order Delivery to ${widget.model!.customer!.name} residing at ${widget.model!.destination} was Assigned to you by Abasu Admin');
                            SMSClass().sendSMS(driver.phone!,
                                "Hi ${widget.model!.driverName!} a new Order Delivery has been assigned to you, kindly go to the Abasu Driver app and accept it");
                            successToastMessage(
                                msg: 'Driver Successfully assigned to Order');
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: driver.photo!,
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(driver.name!),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(driver.address!),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    query: driversRef
                        .where('isVerified', isEqualTo: true)
                        .orderBy('name', descending: false),
                    isLive: true,
                    itemBuilderType: PaginateBuilderType.listView,
                  ),
                ),
              ),
            ));
  }
}
