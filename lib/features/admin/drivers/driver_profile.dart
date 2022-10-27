import 'package:abasu_app/core/constants/contants.dart';
import 'package:abasu_app/features/notification/notification_type.dart';
import 'package:abasu_app/features/notification/send_notification.dart';
import 'package:abasu_app/features/sms/sms_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/flag_picker.dart';
import '../../../core/widgets/post_title.dart';
import 'driver_bio_card.dart';
import 'driver_model.dart';

class DriverProfile extends StatefulWidget {
  final DriverModel driver;
  const DriverProfile({Key? key, required this.driver}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final _message = TextEditingController();
  final _wallet = TextEditingController();

  Size? screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.driver.name!,
          style: const TextStyle(color: Colors.green),
        ),
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            DriverProfileInfo(
              isVerified: widget.driver.isVerified!,
              wallet: widget.driver.wallet!,
              isOwner: widget.driver.isOwner!,
              profileImage: widget.driver.photo!,
              driverId: widget.driver.driverId!,
              country: widget.driver.country!,
              flag: FlagPicker(
                flagCode: widget.driver.code!,
              ),
              name: widget.driver.name!.toUpperCase(),
            ),
            const SizedBox(height: 10),
            ProfileTag(
              tag: 'Update Driver',
              onTap: () {
                _updateDriver(context);
              },
            ),
            DriverInfoBioCard(
              model: widget.driver,
            ),
            DriverVehicleBioCard(model: widget.driver),
            DriverAccountBioCard(model: widget.driver),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _updateDriver(BuildContext ctx) {
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
              child: SizedBox(
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: ElevatedButton(
                          child: const Text('Update Wallet'),
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Update Wallet',
                              middleText:
                                  'How Do you want to Update Driver Wallet',
                              barrierDismissible: false,
                              radius: 25,
                              cancel: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue),
                                  onPressed: () {
                                    _updateWallet(context, true);
                                  },
                                  child: const Text(
                                    'Deduct Wallet',
                                  )),
                              confirm: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  onPressed: () async {
                                    _updateWallet(context, false);
                                  },
                                  child: const Text('Fund Wallet')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              textStyle: const TextStyle(color: Colors.white)),
                        )),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: ElevatedButton(
                          child: Text(widget.driver.isVerified!
                              ? 'Unverify Driver'
                              : "Verify Driver"),
                          onPressed: () {
                            Get.defaultDialog(
                              title: widget.driver.isVerified!
                                  ? 'Unverify Driver'
                                  : "Verify Driver",
                              middleText: 'Do you want to Continue?',
                              barrierDismissible: false,
                              radius: 25,
                              cancel: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                  onPressed: () {
                                    Get.back();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Cancel',
                                  )),
                              confirm: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  onPressed: () async {
                                    await driversRef
                                        .doc(widget.driver.driverId)
                                        .update({
                                      'isVerified': widget.driver.isVerified!
                                          ? false
                                          : true,
                                      'status': widget.driver.isVerified!
                                          ? 'Not Verified'
                                          : 'Verified',
                                    }).then((value) {
                                      SendNoti.sendDriver(
                                          widget.driver.driverId!,
                                          widget.driver.driverId!,
                                          "Abasu Admin",
                                          NotificationType.driverInvitation,
                                          "Hello ${widget.driver.name} Your account on Abasu App has been verified, you can now be assigned to delivery orders");
                                    });
                                    successToastMessage(
                                        msg: 'Driver Updated Successfully');
                                    Get.back();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Yes')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              textStyle: const TextStyle(color: Colors.white)),
                        )),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: (screenSize!.width) / 2,
                        child: ElevatedButton(
                          child: const Text('Invite For Verification'),
                          onPressed: () {
                            _inviteDriver(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              textStyle: const TextStyle(color: Colors.white)),
                        ))
                  ],
                ),
              ),
            ));
  }

  void _inviteDriver(BuildContext context) {
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
              child: SizedBox(
                height: screenSize!.height / 2.5,
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const PostLabel(label: 'Invitation Message'),
                      const SizedBox(height: 9.5),
                      TextField(
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: true,
                        enableSuggestions: true,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 15.0),
                        decoration: const InputDecoration(
                          hintText: 'type message here',
                        ),
                        minLines: 1,
                        maxLines: 6, //fix
                        controller: _message,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          child: const Text('Send Invitation'),
                          onPressed: () {
                            if (_message.text != '') {
                              SendNoti.sendDriver(
                                  widget.driver.driverId!,
                                  widget.driver.driverId!,
                                  "Abasu Admin",
                                  NotificationType.driverVerification,
                                  _message.text);
                              SMSClass()
                                  .sendSMS(widget.driver.phone!, _message.text);
                              successToastMessage(
                                  msg: 'Invitation Message Sent');
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } else {
                              errorToastMessage(
                                  msg: 'invitation message cannot be empty');
                              return;
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  void _updateWallet(BuildContext context, bool isDeduct) {
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
              child: SizedBox(
                height: screenSize!.height / 2.5,
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      PostLabel(
                          label:
                              isDeduct ? 'Amount to Deduct' : 'Amount to Fund'),
                      const SizedBox(height: 9.5),
                      TextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.numberWithOptions(),
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: true,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 15.0),
                        decoration: const InputDecoration(
                          hintText: 'type amount',
                        ),
                        controller: _wallet,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            if (_wallet.text.isNum) {
                              driversRef.doc(widget.driver.driverId!).update({
                                'wallet': isDeduct
                                    ? FieldValue.increment(
                                        -(int.parse(_wallet.text)))
                                    : FieldValue.increment(
                                        int.parse(_wallet.text)),
                                'info': FieldValue.increment(1),
                              }).then((value) {
                                SendNoti.sendDriver(
                                    widget.driver.driverId!,
                                    widget.driver.driverId!,
                                    "Abasu Admin",
                                    NotificationType.walletUp,
                                    isDeduct
                                        ? "${format.format(int.parse(_wallet.text))} NGN was deducted from your wallet"
                                        : "${format.format(int.parse(_wallet.text))} NGN was added to your wallet");
                                SMSClass().sendSMS(
                                    widget.driver.phone!,
                                    isDeduct
                                        ? "${format.format(int.parse(_wallet.text))} NGN was deducted from your wallet"
                                        : "${format.format(int.parse(_wallet.text))} NGN was added to your wallet");
                                successToastMessage(
                                    msg: 'Wallet Successfully Updated');
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });
                            } else {
                              errorToastMessage(
                                  msg: 'amount must be a be a number');
                              return;
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class ProfileTag extends StatelessWidget {
  const ProfileTag({
    Key? key,
    this.tag,
    this.onTap,
  }) : super(key: key);

  final String? tag;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    //limited box
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 7.5),
        padding: const EdgeInsets.only(
          top: 4.5,
          bottom: 4.5,
          left: 10.5,
          right: 10.5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            9.5,
          ),
          color: ThemeColors.redColor,
        ),
        child: Text(
          tag!,
          maxLines: 1,
          style: const TextStyle(
              fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
