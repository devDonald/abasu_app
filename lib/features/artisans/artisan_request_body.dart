import 'package:abasu_app/features/profile/helpers/profile_database.dart';
import 'package:abasu_app/features/profile/models/requests_model.dart';
import 'package:abasu_app/features/profile/pages/artisan_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_text.dart';
import '../../../core/widgets/display_event.dart';
import '../../core/constants/contants.dart';
import '../../core/widgets/delete_widget.dart';
import '../../core/widgets/profile_picture.dart';

class ArtisanRequestDetails extends StatefulWidget {
  final RequestModel? model;
  final List<dynamic>? images;
  final bool isAdmin;
  const ArtisanRequestDetails(
      {Key? key,
      required this.model,
      required this.images,
      required this.isAdmin})
      : super(key: key);

  @override
  State<ArtisanRequestDetails> createState() => _ArtisanRequestDetailsState();
}

class _ArtisanRequestDetailsState extends State<ArtisanRequestDetails> {
  Size? screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        actions: [
          widget.model!.isArtisan!
              ? RespondWidget(
                  delete: () {
                    Get.defaultDialog(
                      title: 'Delete Request',
                      middleText: 'Do you want to delete this Request?',
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
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).delete();
                            if (widget.images != null) {
                              WorkDB.deleteFile(widget.model!.imagesNames!);
                            }
                            successToastMessage(
                                msg: 'Request Successfully deleted');
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
              : RespondWidget(
                  delete: () {
                    Get.defaultDialog(
                      title: 'Delete Request',
                      middleText: 'Do you want to delete this Request?',
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
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).delete();
                            if (widget.images != null) {
                              WorkDB.deleteFile(widget.model!.imagesNames!);
                            }
                            successToastMessage(
                                msg: 'Request Successfully deleted');
                            Get.back();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm')),
                    );
                  },
                  onEdit: () {
                    _customerRespond(context);
                  },
                  editable: true)
        ],
        title: const Text(
          'Request Details',
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
                  widget.model!.workTitle!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: ThemeColors.whiteColor,
                    fontWeight: JanguAskFontWeight.kBoldText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 9,
                  right: 9,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.model!.workDescription!,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Location: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.model!.address}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Desired Duration:',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${widget.model!.duration}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Budget:',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '₦${format.format(widget.model!.budget)}',
                      style: const TextStyle(
                        color: ThemeColors.blackColor1,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Artisan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Customer',
                      style: TextStyle(
                        color: ThemeColors.blackColor1,
                        fontSize: 15.0,
                      ),
                    ),
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
                            user: widget.model!.artisan!,
                            isAdmin: widget.isAdmin));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ProfilePicture(
                          image: CachedNetworkImageProvider(
                            widget.model!.artisanPhoto!,
                          ),
                          width: 30.0,
                          height: 29.5,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          widget.model!.artisanName!,
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

                  //level
                ],
              ),
              const Divider(
                height: 20,
                color: ThemeColors.pinkishGreyColor,
              ),
              widget.images != null
                  ? const Text(
                      'View Photos for more details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              widget.images != null
                  ? Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: widget.images!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(ViewAttachedImage(
                                      image: CachedNetworkImageProvider(
                                          widget.images![index]),
                                      text: '',
                                      url: widget.images![index],
                                    ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                widget.images![index]),
                                            fit: BoxFit.cover)),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                  : Container(),
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
                          child: const Text("Accept Work"),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).update({
                              'status': 'Accepted',
                            }).then((value) {
                              successToastMessage(msg: 'Work status updated');
                              Navigator.of(context).pop();
                            });
                          },
                        )),
                    const SizedBox(height: 5),
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text("Reject Project"),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).update({
                              'status': 'Rejected',
                            }).then((value) {
                              successToastMessage(msg: 'Work status updated');
                              Navigator.of(context).pop();
                            });
                          },
                        )),
                    const SizedBox(height: 5),
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text("Request Bidding"),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).update({
                              'status': 'Requested Bidding',
                            }).then((value) {
                              successToastMessage(msg: 'Work status updated');
                              Navigator.of(context).pop();
                            });
                          },
                        )),
                    const SizedBox(height: 5),
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text("Ongoing Work"),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).update({
                              'status': 'Ongoing',
                            }).then((value) {
                              successToastMessage(msg: 'Work status updated');
                              Navigator.of(context).pop();
                            });
                          },
                        )),
                  ],
                ),
              ),
            ));
  }

  void _customerRespond(BuildContext ctx) {
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
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text("Abandoned Work"),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).update({
                              'status': 'Abandoned',
                            }).then((value) {
                              successToastMessage(msg: 'Work status updated');
                              Navigator.of(context).pop();
                            });
                          },
                        )),
                    const SizedBox(height: 5),
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text("Ongoing Work"),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).update({
                              'status': 'Ongoing',
                            }).then((value) {
                              successToastMessage(msg: 'Work status updated');
                              Navigator.of(context).pop();
                            });
                          },
                        )),
                    const SizedBox(height: 5),
                    SizedBox(
                        width: (screenSize!.width - 50) / 2,
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text("Completed Work"),
                          onPressed: () async {
                            await requestRef.doc(widget.model!.workId).update({
                              'status': 'Completed',
                            }).then((value) {
                              successToastMessage(msg: 'Work status updated');
                              Navigator.of(context).pop();
                            });
                          },
                        )),
                  ],
                ),
              ),
            ));
  }
}
