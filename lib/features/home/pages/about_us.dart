import 'package:abasu_app/features/home/pages/privacy_policy.dart';
import 'package:abasu_app/features/home/pages/terms_of_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/text_constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.green,
        title: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('About Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        titleSpacing: -5.0,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.5,
          bottom: 10.0,
        ),
        padding: const EdgeInsets.only(
          left: 10.5,
          right: 23.5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(color: Colors.blueGrey, offset: Offset(0.0, 2.5)),
          ],
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const SizedBox(
              height: 2.5,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                aboutUs,
                style: const TextStyle(color: Colors.black87, fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 10.5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const TermsOfService());
              },
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Our terms and Condition',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 10.5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const PrivacyAndPolicy());
              },
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Our Privacy Policy',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 10.5,
            ),
          ],
        ),
      ),
    );
  }
}
