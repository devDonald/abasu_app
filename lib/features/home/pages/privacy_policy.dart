import 'package:flutter/material.dart';

import '../../../core/constants/text_constants.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.green,
        title: const Text('Privacy Policy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
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
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                privacyAndPolicy,
                style: TextStyle(color: Colors.black87, fontSize: 16.0),
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
