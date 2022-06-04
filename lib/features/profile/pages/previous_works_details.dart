import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_text.dart';
import '../../../core/widgets/display_event.dart';

class PreviousWorksDetails extends StatelessWidget {
  final String title, description, category;
  final List<dynamic> images;
  const PreviousWorksDetails(
      {Key? key,
      required this.title,
      required this.description,
      required this.images,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 3.0,
        titleSpacing: -5.0,
        title: const Text(
          'Work Details',
          style: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.green, size: 35),
      ),
      body: Container(
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
                title,
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
                    description,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Image Preview',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(ViewAttachedImage(
                              image: CachedNetworkImageProvider(images[index]),
                              text: '',
                              url: images[index],
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        images[index]),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
