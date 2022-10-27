import 'package:abasu_app/features/admin/drivers/driver_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_text.dart';
import '../../../core/widgets/profile_picture.dart';

class DriverHeaderWidget extends StatelessWidget {
  const DriverHeaderWidget({
    Key? key,
    this.onTap,
    required this.model,
  }) : super(key: key);
  final Function()? onTap;
  final DriverModel model;
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
                model.name ?? '',
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
                      model.photo ?? '',
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
                    child: Text("${model.experience!} Experience",
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: ThemeColors.whiteColor,
                          fontSize: 15,
                        )),
                  ),
                  const SizedBox(height: 5),
                  model.isVerified!
                      ? const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 30,
                        )
                      : const Icon(
                          Icons.cancel,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                  const SizedBox(height: 5),
                  Text(
                    model.status!,
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
                        model.address ?? '',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
