import 'package:abasu_app/features/authentication/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInAs extends StatefulWidget {
  static const String id = 'LogInAs';
  const LogInAs({Key? key}) : super(key: key);

  @override
  _LogInAsState createState() => _LogInAsState();
}

class _LogInAsState extends State<LogInAs> {
  //pass value to use

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 40.4,
                    ),
                    Container(
                      child: Image.asset(
                        'images/logo.png',
                        width: 130,
                        height: 130,
                      ),
                    ),
                    const SizedBox(
                      height: 30.5,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'How do you want to use',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('Abasu',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(
                                  '?',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    LogInAsButton(
                      title: 'As a Customer',
                      color: Colors.green,
                      onTap: () {
                        Get.offAll(() => const RegisterScreen(
                              userType: "Buyer",
                            ));
                      },
                    ),
                    LogInAsButton(
                      color: Colors.red,
                      title: 'As an Artisan',
                      onTap: () {
                        Get.offAll(() => const RegisterScreen(
                              userType: "Artisan",
                            ));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LogInAsButton extends StatelessWidget {
  const LogInAsButton({
    Key? key,
    this.title,
    this.onTap,
    required this.color,
  }) : super(key: key);
  final String? title;
  final Function()? onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80.4,
        margin: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          bottom: 16.0,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 5.0),
              blurRadius: 15.0,
              color: Colors.white70,
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
