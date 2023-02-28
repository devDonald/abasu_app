import 'package:abasu_app/features/notification/notification_type.dart';
import 'package:abasu_app/features/notification/send_notification.dart';
import 'package:abasu_app/features/payment/order_model.dart';
import 'package:abasu_app/features/sms/sms_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../dashboard/dashboard.dart';
import '../../order/sub_order_model.dart';

class CardSupport extends StatefulWidget {
  final int totalPrice;
  final List<Products> items;
  final bool withDelivery;
  final String destination;
  const CardSupport(
      {Key? key,
      required this.totalPrice,
      required this.items,
      required this.withDelivery,
      required this.destination})
      : super(key: key);

  @override
  State<CardSupport> createState() => _CardSupportState();
}

class _CardSupportState extends State<CardSupport> {
  static const _encriptionKey = 'FLWSECK_TEST2718d0d33f19';
  static const _publicKey = 'FLWPUBK_TEST-61a398cb94c72c5fad04903ee5db661f-X';

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";

  bool isDebug = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details',
            style: TextStyle(color: Colors.red, fontSize: 25)),
        iconTheme: const IconThemeData(color: Colors.red, size: 35),
        backgroundColor: ThemeColors.whiteColor,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(hintText: "Name"),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Name is required",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(hintText: "Email"),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Name is required",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Phone Number is required",
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: RaisedButton(
                  onPressed: _onPressed,
                  color: Colors.red,
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (formKey.currentState!.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    DocumentReference docRef = ordersRef.doc();
    final style = FlutterwaveStyle(
      appBarText: "Card Payment",
      buttonColor: Colors.red,
      buttonTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      appBarColor: Colors.white,
      dialogCancelTextStyle: const TextStyle(
        color: Colors.red,
        fontSize: 18,
      ),
      dialogContinueTextStyle: const TextStyle(
        color: Colors.green,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.white,
      mainTextStyle:
          const TextStyle(color: Colors.black, fontSize: 19, letterSpacing: 2),
      dialogBackgroundColor: Colors.white,
      appBarIcon: const Icon(Icons.arrow_back, color: Colors.red),
      buttonText: "Pay NGN${widget.totalPrice.toString()}",
      appBarTitleTextStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text);

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: _publicKey,
        currency: "NGN",
        txRef: docRef.id,
        amount: widget.totalPrice.toString(),
        customer: customer,
        paymentOptions: "card, payattitude",
        customization: Customization(title: "Abasu Product Order Payment"),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      print('status: ${response.status}');
      if (response.status == 'success') {
        OrderModel model = OrderModel(
          orderId: docRef.id,
          driverId: '',
          customerId: auth.currentUser!.uid,
          destination: widget.destination,
          distance: '',
          price: widget.totalPrice,
          status: 'Payment Successful',
          timestamp: timestamp,
          createdAt: createdAt,
          lat: 0.0,
          long: 0.0,
          withDelivery: widget.withDelivery,
          products: widget.items,
          customerName: nameController.text,
          phone: phoneNumberController.text,
          email: emailController.text,
        );
        docRef.set(model.toJson()).then((value) async {
          await usersRef.doc(auth.currentUser!.uid).update({
            'cart': 0,
            'info': FieldValue.increment(1),
          });
          await cartRef
              .doc(auth.currentUser!.uid)
              .collection('myCart')
              .get()
              .then((snapshot) {
            for (DocumentSnapshot ds in snapshot.docs) {
              ds.reference.delete();
            }
            ;
          });

          SendNoti.sendNow(docRef.id, admin1, nameController.text,
              NotificationType.newOrder, 'New Order by ${nameController.text}');
          SendNoti.sendAdmin(docRef.id, admin1, nameController.text,
              NotificationType.newOrder, 'New Order by ${nameController.text}');
          SMSClass().sendSMS(adminSms1,
              'A new Order has been placed by ${nameController.text}, kindly go to Abasu app and process the order');
          Get.offAll(() => DashboardPage());
          successToastMessage(msg: "order payment successful");
        });
      } else {
        showLoading(response.status!);
      }
    } else {
      showLoading("No Response!");
    }
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
