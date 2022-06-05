import 'package:flutter/material.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({Key? key}) : super(key: key);

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications',
            style: TextStyle(color: Colors.red, fontSize: 25)),
        iconTheme: const IconThemeData(color: Colors.red, size: 35),
        backgroundColor: Colors.white,
      ),
      body: Container(),
    );
  }
}
