import 'dart:io';

import 'package:abasu_app/features/authentication/pages/register_screen.dart';
import 'package:abasu_app/features/authentication/pages/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_images.dart';
import '../../../core/widgets/flat_primary_button.dart';
import '../../../core/widgets/flat_secodary_button.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_title.dart';
import '../../../core/widgets/social_button.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  final String userType;

  const LoginScreen({super.key, required this.userType});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = AuthController.to;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              // key: _formKey,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 39.8),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/logo.png',
                            width: 220,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 31.1),
                    const ScreenTitleIndicator(
                      title: 'LOGIN',
                    ),
                    const SizedBox(height: 25.9),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: ThemeColors.whiteColor,
                        borderRadius: BorderRadius.circular(2.5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 7.5,
                            offset: Offset(0.0, 2.5),
                            color: ThemeColors.shadowColor,
                          )
                        ],
                      ),

                      width: double.infinity,
                      // width: double.infinity,
                      // height: 40.0,
                      child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          controller: _email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.newline,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: ThemeColors.whiteColor,
                        borderRadius: BorderRadius.circular(2.5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 7.5,
                            offset: Offset(0.0, 2.5),
                            color: ThemeColors.shadowColor,
                          )
                        ],
                      ),
                      width: double.infinity,
                      // height: 40.0,
                      child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          controller: _password,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.newline,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FlatSecondaryButton(
                        title: 'Forgot Password? Click Here!',
                        color: Colors.green,
                        onTap: () {
                          Get.to(() => const ResetPassword());
                        },
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    PrimaryButton(
                      width: double.infinity,
                      height: 45.0,
                      buttonTitle: 'Login',
                      color: ThemeColors.kellyGreen,
                      blurRadius: 7.0,
                      roundedEdge: 10,
                      onTap: () async {
                        if (validateLogin(_email.text, _password.text)) {
                          authController.signIn(_email.text, _password.text);
                        }
                      },
                    ),
                    const SizedBox(height: 25.0),
                    SocialButton(
                      platformName: 'Continue with Google',
                      platformIcon: JanguAskImages.googleLogo,
                      color: ThemeColors.redColor,
                      onTap: () async {
                        authController.googleLogin(widget.userType);
                      },
                    ),
                    const SizedBox(height: 25.0),
                    Platform.isIOS
                        ? SignInWithAppleButton(
                            style: SignInWithAppleButtonStyle.black,
                            iconAlignment: IconAlignment.left,
                            onPressed: () {
                              authController.signInWithApple(widget.userType);
                            })
                        : Container(),
                    const SizedBox(height: 15.0),
                    Center(
                      child: FlatPrimaryButton(
                        info: 'Don\'t Have an Account? ',
                        title: 'Register',
                        onTap: () {
                          Get.offAll(() => RegisterScreen(
                                userType: widget.userType,
                              ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 23.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
