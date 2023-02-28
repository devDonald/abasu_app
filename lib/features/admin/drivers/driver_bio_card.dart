import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_text.dart';
import '../../../core/widgets/customFullScreenDialog.dart';
import '../../../core/widgets/display_event.dart';
import 'driver_model.dart';

class DriverInfoBioCard extends StatelessWidget {
  const DriverInfoBioCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final DriverModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(
              0.0,
              4.0,
            ),
            color: ThemeColors.shadowColor,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Address',
                style: TextStyle(
                  color: ThemeColors.blackColor1,
                  fontWeight: JanguAskFontWeight.kBoldText,
                  fontSize: 18,
                ),
              ),
              // model.isOwner!
              //     ? GestureDetector(
              //         onTap: () {},
              //         child: Row(
              //           children: const [
              //             Text(
              //               'Edit Personal Details',
              //               style: TextStyle(
              //                 color: Colors.green,
              //                 fontWeight: JanguAskFontWeight.kBoldText,
              //                 fontSize: 15,
              //               ),
              //             ),
              //             SizedBox(width: 5),
              //             Icon(
              //               Icons.edit,
              //               color: Colors.green,
              //               size: 17,
              //             ),
              //           ],
              //         ),
              //       )
              //     : Container(),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            model.address!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Gender',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.gender!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Marital Status',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.marital!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Years of Experience',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.experience!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          GestureDetector(
            onTap: () {
              launch('tel:${model.phone}');
            },
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: ThemeColors.blackColor1,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  model.phone!,
                  style: const TextStyle(
                    color: ThemeColors.primaryGreyColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              const Icon(
                Icons.email,
                color: ThemeColors.blackColor1,
                size: 18,
              ),
              const SizedBox(width: 12),
              Text(
                model.email!,
                style: const TextStyle(
                  color: ThemeColors.primaryGreyColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DriverAccountBioCard extends StatelessWidget {
  const DriverAccountBioCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final DriverModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(
              0.0,
              4.0,
            ),
            color: ThemeColors.shadowColor,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Bank Name',
                style: TextStyle(
                  color: ThemeColors.blackColor1,
                  fontWeight: JanguAskFontWeight.kBoldText,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            model.bankName!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Account Name',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.accountName!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Account Number',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.accountNo!,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class DriverVehicleBioCard extends StatelessWidget {
  const DriverVehicleBioCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final DriverModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(
              0.0,
              4.0,
            ),
            color: ThemeColors.shadowColor,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Vehicle Manufacturer',
                style: TextStyle(
                  color: ThemeColors.blackColor1,
                  fontWeight: JanguAskFontWeight.kBoldText,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            model.vehicleManufacturer!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Vehicle Model',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.vehicleModel!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Plate No',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.plateNo!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Vehicle Colour',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.vehicleColour!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Licence Number',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.licenceNo!,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class DriverProfileInfo extends StatefulWidget {
  const DriverProfileInfo({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.country,
    required this.flag,
    required this.driverId,
    required this.isOwner,
    required this.wallet,
    required this.isVerified,
  }) : super(key: key);
  final String name, profileImage, country, driverId;
  final Widget flag;
  final bool isOwner, isVerified;
  final int wallet;

  @override
  State<DriverProfileInfo> createState() => _DriverProfileInfoState();
}

class _DriverProfileInfoState extends State<DriverProfileInfo> {
  late File pickedImage;

  late String _uploadedImageURL;

  final _picker = ImagePicker();
  ImageCropper? imageCropper;

  getImageFile(ImageSource source) async {
    //Clicking or Picking from Gallery

    var image = await _picker.getImage(source: source);

    //Cropping the image

    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      pickedImage = croppedFile!;
      print(pickedImage.lengthSync());
    });
  }

  Future<void> sendImage() async {
    try {
      User? _currentUser = await FirebaseAuth.instance.currentUser;
      String uid = _currentUser!.uid;
      if (pickedImage != null) {
        CustomFullScreenDialog.showDialog();
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile/$uid/${Path.basename(pickedImage.path)}}');
        UploadTask uploadTask = storageReference.putFile(pickedImage);
        await uploadTask;
        print('profile pics Uploaded');
        storageReference.getDownloadURL().then((fileURL) async {
          _uploadedImageURL = fileURL;
          DocumentReference _docRef = driversRef.doc(uid);
          await _docRef.update({
            'photo': _uploadedImageURL,
          }).then((doc) async {
            CustomFullScreenDialog.cancelDialog();
            Fluttertoast.showToast(
                msg: "photo successfully updated",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          }).catchError((onError) async {
            CustomFullScreenDialog.cancelDialog();
            Fluttertoast.showToast(
                msg: onError.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Stack(fit: StackFit.loose, children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Get.to(ViewAttachedImage(
                          image:
                              CachedNetworkImageProvider(widget.profileImage),
                          text: widget.name,
                          url: widget.profileImage,
                        ));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  widget.profileImage),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                  ],
                ),
                widget.isOwner
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 100.0, right: 100.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                await getImageFile(ImageSource.gallery);
                                sendImage();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 30.0,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ))
                    : Container(),
              ]),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: JanguAskFontWeight.kBoldText,
                    fontSize: 23,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: widget.flag,
                  ),
                  Text(
                    widget.country,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff333333),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.isVerified
                        ? "Account Verified"
                        : "Account Not Verified",
                    style: TextStyle(
                        fontSize: 13,
                        color: widget.isVerified ? Colors.green : Colors.red,
                        fontStyle: FontStyle.italic),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: MediaQuery.of(context).size.width - 50,
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
                color: Colors.redAccent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Wallet Balance:",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '₦${format.format(widget.wallet)}',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
