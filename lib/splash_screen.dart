import 'dart:async';

import 'package:abasu_app/features/authentication/pages/register_as.dart';
import 'package:abasu_app/features/onboarding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/contants.dart';
import 'features/authentication/pages/login_screen.dart';
import 'features/dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    startTime();
  }

//update firebase token for every user for push notification
  Future<bool> getUserLoginStatus() async {
    if (auth.currentUser != null) {
      _fcm.getToken().then((token) {
        // print("Firebase Messaging Token: $token\n");
        root
            .collection('users')
            .doc(auth.currentUser!.uid)
            .update({"token": token});
      });
      return true;
    } else {
      return false;
    }
  }

  void isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); //create an instance of shared preference class
    bool? isFirstTime = prefs.getBool('first_time');
    String? userType = prefs.getString('type');

    if (isFirstTime != null && !isFirstTime && userType != null) {
      prefs.setBool('first_time', false);
      Get.offAll(() => LoginScreen(
            userType: userType,
          ));
    } else if (isFirstTime != null && !isFirstTime && userType == null) {
      prefs.setBool('first_time', false);
      Get.offAll(() => const LogInAs());
    } else {
      prefs.setBool('first_time', false);
      Get.offAll(() => const OnBoardingPage());
    }
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    bool isLoggedIn = await getUserLoginStatus();
    isLoggedIn ? Get.offAll(() => DashboardPage()) : isFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    // initializePushNotification(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Hero(tag: 'logo', child: Image.asset('images/logo.png')),
              ),
            ],
          ),
        ));
  }
}
