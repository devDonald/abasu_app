import 'package:abasu_app/core/widgets/profile_picture.dart';
import 'package:abasu_app/features/profile/models/requests_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/contants.dart';
import '../themes/theme_colors.dart';
import '../themes/theme_text.dart';

class FilesDropDownButton extends StatelessWidget {
  const FilesDropDownButton({
    Key? key,
    required this.hint,
    required this.onChanged,
    required this.items,
    required this.value,
    this.isBorder,
  }) : super(key: key);
  final Widget hint;
  final Function(String?) onChanged;
  final List<String> items;
  final String value;
  final bool? isBorder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: hint,
      value: value,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 25.0,
      elevation: 0,
      style: const TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        border: (isBorder != null)
            ? (isBorder!)
                ? const OutlineInputBorder()
                : const OutlineInputBorder(borderSide: BorderSide.none)
            : const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class UserSearchTile extends StatelessWidget {
  const UserSearchTile({
    Key? key,
    required this.onTap,
    required this.userName,
    required this.profileImage,
    required this.country,
  }) : super(key: key);
  final Function() onTap;
  final String userName;
  final String profileImage, country;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            onTap: onTap,
            leading: ProfilePicture(
              image: CachedNetworkImageProvider(
                profileImage,
              ),
              width: 40,
              height: 40,
            ),
            title: Text(userName,
                style: const TextStyle(
                  color: ThemeColors.blackColor1,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            subtitle: Text(
              country,
              style: const TextStyle(color: Colors.black54),
            )),
        const Divider(
          height: 1,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class ArtisanSearchHeader extends StatelessWidget {
  const ArtisanSearchHeader({
    Key? key,
    this.onTap,
    required this.userName,
    required this.skills,
    required this.profileImage,
    required this.charge,
    required this.specialization,
    required this.address,
    this.onFollow,
    required this.isAdmin,
  }) : super(key: key);
  final Function()? onTap, onFollow;
  final String? userName, address, specialization;
  final Widget skills;
  final String? profileImage, charge;
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(bottom: 15),
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
          mainAxisAlignment: MainAxisAlignment.start,
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
                userName ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  color: ThemeColors.whiteColor,
                  fontWeight: JanguAskFontWeight.kBoldText,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(
                top: 8,
                left: 9,
                right: 9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePicture(
                    width: 80,
                    height: 80,
                    image: CachedNetworkImageProvider(
                      profileImage ?? '',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(right: 7.5),
                    padding: const EdgeInsets.only(
                      top: 4.5,
                      bottom: 4.5,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        9.5,
                      ),
                      color: Colors.green,
                    ),
                    child: Text(specialization!,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: ThemeColors.whiteColor,
                          fontSize: 15,
                        )),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₦${format.format(int.parse(charge!))} per day',
                    style: const TextStyle(
                      color: ThemeColors.blackColor2,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      Text(
                        address ?? '',
                        style: const TextStyle(
                          color: ThemeColors.primaryGreyColor,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow
                            .ellipsis, //make sure textfeild fot this takes only 3 lines
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  (skills != null) ? skills : Container(),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtisanHomeWidget extends StatelessWidget {
  const ArtisanHomeWidget({
    Key? key,
    this.onTap,
    required this.userName,
    required this.skills,
    required this.profileImage,
    required this.charge,
    required this.specialization,
    required this.address,
    this.onFollow,
  }) : super(key: key);
  final Function()? onTap, onFollow;
  final String? userName, address, specialization;
  final Widget skills;
  final String? profileImage, charge;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        margin: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
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
          mainAxisAlignment: MainAxisAlignment.start,
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
                userName ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  color: ThemeColors.whiteColor,
                  fontWeight: JanguAskFontWeight.kBoldText,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(
                top: 8,
                left: 9,
                right: 9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePicture(
                    width: 50,
                    height: 50,
                    image: CachedNetworkImageProvider(
                      profileImage ?? '',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(right: 7.5),
                    padding: const EdgeInsets.only(
                      top: 4.5,
                      bottom: 4.5,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        9.5,
                      ),
                      color: Colors.green,
                    ),
                    child: Text(specialization!,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: ThemeColors.whiteColor,
                          fontSize: 15,
                        )),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₦${format.format(int.parse(charge!))} per day',
                    style: const TextStyle(
                      color: ThemeColors.blackColor2,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      Text(
                        address ?? '',
                        style: const TextStyle(
                          color: ThemeColors.primaryGreyColor,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow
                            .ellipsis, //make sure textfeild fot this takes only 3 lines
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  (skills != null) ? skills : Container(),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteEditPopUp extends StatelessWidget {
  const DeleteEditPopUp({
    Key? key,
    required this.delete,
    required this.respond,
    this.isEditable = false,
    this.isOwner = false,
    required this.isRespondable,
    required this.edit,
  }) : super(key: key);
  final Function() delete;
  final Function() respond, edit;
  final bool isEditable, isOwner, isRespondable;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        isOwner
            ? list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: delete,
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: ThemeColors.brownishGrey,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  value: 1,
                ),
              )
            : Container();
        (isEditable)
            ? list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.reply,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: respond,
                        child: const Text(
                          "Reply Request",
                          style: TextStyle(
                            color: ThemeColors.brownishGrey,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  value: 1,
                ),
              )
            : Container();
        return list;
      },
      icon: const Icon(
        Icons.more_horiz,
        size: 20,
        color: ThemeColors.primaryGreyColor,
      ),
    );
  }
}

class ProductAdminPopUp extends StatelessWidget {
  const ProductAdminPopUp({
    Key? key,
    required this.deleteTap,
    required this.editTap,
    required this.topProduct,
    required this.isTop,
  }) : super(key: key);
  final Function() deleteTap;
  final Function() editTap, topProduct;
  final bool isTop;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.delete,
                  size: 17,
                  color: ThemeColors.primaryGreyColor,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: deleteTap,
                  child: const Text(
                    "Delete Product",
                    style: TextStyle(
                      color: ThemeColors.brownishGrey,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
            value: 1,
          ),
        );

        list.add(
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.edit,
                  size: 17,
                  color: ThemeColors.primaryGreyColor,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: editTap,
                  child: const Text(
                    "Edit Product",
                    style: TextStyle(
                      color: ThemeColors.brownishGrey,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
            value: 1,
          ),
        );

        list.add(
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                  size: 17,
                  color: ThemeColors.primaryGreyColor,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: topProduct,
                  child: Text(
                    isTop ? "Remove Top Product" : "Make Top Product",
                    style: const TextStyle(
                      color: ThemeColors.brownishGrey,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
            value: 1,
          ),
        );
        return list;
      },
      icon: const Icon(
        Icons.more_vert,
        size: 20,
        color: ThemeColors.primaryGreyColor,
      ),
    );
  }
}

class ArtisanAdminPopUp extends StatelessWidget {
  const ArtisanAdminPopUp({
    Key? key,
    required this.makeTop,
    required this.verifyArtisanTap,
    this.isTop = false,
    this.isVerified = false,
  }) : super(key: key);
  final Function() makeTop, verifyArtisanTap;
  final bool isTop, isVerified;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.verified,
                  size: 17,
                  color: ThemeColors.primaryGreyColor,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: verifyArtisanTap,
                  child: Text(
                    isVerified ? "Unverify Artisan" : "Verify Artisan",
                    style: const TextStyle(
                      color: ThemeColors.brownishGrey,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
            value: 1,
          ),
        );

        list.add(
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                  size: 17,
                  color: ThemeColors.primaryGreyColor,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: makeTop,
                  child: Text(
                    isTop ? "Remove Top Artisan" : "Make Top Artisan",
                    style: const TextStyle(
                      color: ThemeColors.brownishGrey,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
            value: 1,
          ),
        );
        return list;
      },
      icon: const Icon(
        Icons.more_vert,
        size: 20,
        color: ThemeColors.primaryGreyColor,
      ),
    );
  }
}

class PreviousWorksHeader extends StatelessWidget {
  const PreviousWorksHeader({
    Key? key,
    this.onTap,
    required this.title,
    required this.description,
    this.category,
  }) : super(key: key);
  final Function()? onTap;
  final String? title, description;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
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
          mainAxisAlignment: MainAxisAlignment.start,
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
                title ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  color: ThemeColors.whiteColor,
                  fontWeight: JanguAskFontWeight.kBoldText,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
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
                    description ?? '',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow
                        .ellipsis, //make sure textfeild fot this takes only 3 lines
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Read More',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
              maxLines: 3,
              overflow: TextOverflow
                  .ellipsis, //make sure textfeild fot this takes only 3 lines
            ),
          ],
        ),
      ),
    );
  }
}

class WorksHeaderRequest extends StatelessWidget {
  const WorksHeaderRequest({Key? key, this.onTap, required this.model})
      : super(key: key);
  final Function()? onTap;
  final RequestModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // DeleteEditPopUp(
            //   delete: () async {
            //     Get.defaultDialog(
            //       title: 'Respond to Request',
            //       middleText: 'Accept request or Request for bidding',
            //       barrierDismissible: false,
            //       radius: 25,
            //       cancel: ElevatedButton(
            //           style: ElevatedButton.styleFrom(primary: Colors.red),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //           child: const Text(
            //             'Request for bidding',
            //           )),
            //       confirm: ElevatedButton(
            //           style: ElevatedButton.styleFrom(primary: Colors.green),
            //           onPressed: () async {},
            //           child: const Text('Accept request')),
            //     );
            //     //Navigator.of(context).pop();
            //   },
            //   isRespondable: true,
            //   isOwner: false, respond: () {},
            //   edit: () {}, // widget.isOwner,
            // ),
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
                model.workTitle!,
                style: const TextStyle(
                  fontSize: 15,
                  color: ThemeColors.whiteColor,
                  fontWeight: JanguAskFontWeight.kBoldText,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
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
                    model.workDescription!,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
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
                    '${model.status}',
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
                    '${model.duration}',
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
                    '₦${format.format(model.budget)}',
                    style: const TextStyle(
                      color: ThemeColors.blackColor1,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'See More',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ), //make sure textfeild fot this takes only 3 lines
              ),
            ),
          ],
        ),
      ),
    );
  }
}
