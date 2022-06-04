import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/theme_colors.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    super.initState();
    //checkInGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(color: Colors.red)),
        iconTheme: const IconThemeData(color: Colors.red, size: 35),
        backgroundColor: ThemeColors.whiteColor,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          ContactButtonWithICon(
              icon: Icons.call,
              title: '+2348148707999',
              onTap: () {
                launch("tel: +2348148707999");
              },
              description: 'Our call center is open to you 24/7'),
          ContactButtonWithICon(
              icon: Icons.email,
              title: 'support@abasukonsult.com.ng',
              onTap: () {
                launch(
                    "mailto:support@abasukonsult.com.ng?subject=Feedback and Enquiry=New%20plugin");
              },
              description: 'email us for any feedback'),
          ContactButtonWithICon(
              icon: Icons.web,
              title: 'https://abasukonsult.com.ng',
              onTap: () {
                launch("https://abasukonsult.com.ng");
              },
              description: 'Check our website'),
        ],
      ),
    );
  }
}

class ContactButtonWithICon extends StatelessWidget {
  const ContactButtonWithICon({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.description,
  }) : super(key: key);
  final IconData icon;
  final String title, description;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height * 0.0900,
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: ThemeColors.pinkishGreyColor,
            offset: Offset(0.0, 2.5),
            blurRadius: 7.5,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: ThemeColors.primaryColor,
              ),
              SizedBox(width: 9.2),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Text(
                    title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: ThemeColors.blackColor3,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 5.2),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      color: ThemeColors.blackColor1,
                      fontSize: 14.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
