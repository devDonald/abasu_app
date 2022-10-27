import 'dart:io';

import 'package:abasu_app/core/widgets/post_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_images.dart';
import '../../../core/widgets/country_code_button.dart';
import '../../../core/widgets/flat_primary_button.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/screen_title.dart';
import '../../../core/widgets/social_button.dart';
import '../controller/auth_controller.dart';
import '../model/app_users_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String userType;
  const RegisterScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = AuthController.to;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _address = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _charge = TextEditingController();

  String _dialCode = '+234', _country = 'Nigeria', _code = 'NG';

  String? userType, _specialization;
  List<String> _skills = [];

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
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
                        const SizedBox(height: 22.1),
                        const ScreenTitleIndicator(
                          title: 'Register',
                        ),
                        const SizedBox(
                          height: 20.9,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 9.5),
                              const PostLabel(label: 'Full Name'),
                              const SizedBox(height: 9.5),
                              TextFormField(
                                  style: const TextStyle(fontSize: 20),
                                  controller: _fullName,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  maxLength: null,
                                  decoration: InputDecoration(
                                    hintText: 'e.g Dafon John',
                                    prefixIcon: const Icon(Icons.person),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        //email
                        Container(
                          padding: EdgeInsets.all(10),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 9.5),
                              const PostLabel(label: 'Email Address'),
                              const SizedBox(height: 9.5),
                              TextFormField(
                                style: const TextStyle(fontSize: 20),
                                controller: _email,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  hintText: 'dafon@gmail.com',
                                  prefixIcon: const Icon(Icons.email),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        Container(
                          padding: EdgeInsets.all(10),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 9.5),
                              const PostLabel(label: 'Home Address'),
                              const SizedBox(height: 9.5),
                              TextFormField(
                                  style: const TextStyle(fontSize: 20),
                                  controller: _address,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.streetAddress,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  maxLength: null,
                                  decoration: InputDecoration(
                                    hintText: 'No 3 Dadin Kowa last Gate, Jos',
                                    prefixIcon: const Icon(Icons.person),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        //Type of User
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: ThemeColors.whiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 7.5,
                                offset: Offset(0.0, 2.5),
                                color: ThemeColors.shadowColor,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 9.5),
                              const PostLabel(label: 'Type of User'),
                              const SizedBox(height: 9.5),
                              DropDown(
                                dropDownType: DropDownType.Button,
                                items: UserType,
                                hint: const Text("Select Type of User"),
                                icon: const Icon(
                                  Icons.expand_more,
                                  color: Colors.pink,
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    userType = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),

                        userType == "Artisan"
                            ? Container(
                                padding: EdgeInsets.all(10),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                        color: ThemeColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 7.5,
                                            offset: Offset(0.0, 2.5),
                                            color: ThemeColors.shadowColor,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 9.5),
                                          const PostLabel(
                                              label: 'Skill Category'),
                                          const SizedBox(height: 9.5),
                                          DropDownMultiSelect(
                                            onChanged: (List<String> x) {
                                              setState(() {
                                                _skills = x;
                                              });
                                              print(
                                                  'specialization: ${_skills.toString()}');
                                            },
                                            options: artisanCategory,
                                            selectedValues: _skills,
                                            whenEmpty:
                                                'Select Several Categories',
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                        color: ThemeColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 7.5,
                                            offset: Offset(0.0, 2.5),
                                            color: ThemeColors.shadowColor,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 9.5),
                                          const PostLabel(
                                              label: 'Skill Specialization'),
                                          const SizedBox(height: 9.5),
                                          DropDown(
                                            dropDownType: DropDownType.Button,
                                            items: artisanCategory1,
                                            hint: const Text(
                                                "Select Skill Specialization"),
                                            icon: const Icon(
                                              Icons.expand_more,
                                              color: Colors.pink,
                                            ),
                                            onChanged: (String? value) {
                                              _specialization = value!;
                                              print(
                                                  'specialization: $_specialization');
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const PostLabel(label: 'Charge Per Day(₦)'),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ThemeColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 7.5,
                                            offset: Offset(0.0, 2.5),
                                            color: ThemeColors.shadowColor,
                                          )
                                        ],
                                      ),
                                      child: TextFormField(
                                          style: const TextStyle(fontSize: 20),
                                          controller: _charge,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textInputAction:
                                              TextInputAction.newline,
                                          keyboardType: TextInputType.number,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          maxLength: null,
                                          decoration: InputDecoration(
                                            hintText: '2,000',
                                            prefixIcon: const Icon(Icons.money),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    20, 15, 20, 15),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        //password
                        const SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.all(10),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 9.5),
                              const PostLabel(label: 'Password'),
                              const SizedBox(height: 9.5),
                              TextFormField(
                                style: const TextStyle(fontSize: 20),
                                controller: _password,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.newline,
                                obscureText: _obscureText,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.none,
                                maxLength: null,
                                decoration: InputDecoration(
                                  hintText: 'xxxxxxx',
                                  prefixIcon: const Icon(Icons.lock),
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
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        Container(
                          padding: EdgeInsets.all(10),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 9.5),
                              const PostLabel(label: 'Retype Password'),
                              const SizedBox(height: 9.5),
                              TextFormField(
                                style: const TextStyle(fontSize: 20),
                                controller: _confirmPassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.newline,
                                obscureText: _obscureText,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.none,
                                maxLength: null,
                                decoration: InputDecoration(
                                  hintText: 'xxxxxxx',
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        //phone
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: CountryCodeButton(
                                      height: 65,
                                      onSelectCode: (String dialCode,
                                          String flagUri, String country) {
                                        _dialCode = dialCode;
                                        _country = country;
                                        _code = flagUri;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    flex: 2,
                                    child: SizedBox(
                                      child: Container(
                                        // padding: EdgeInsets.symmetric(horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: ThemeColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(2.5),
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
                                          style: const TextStyle(fontSize: 16),
                                          controller: _phoneNumber,
                                          maxLength: 11,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.phone,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          decoration: InputDecoration(
                                            hintText: '08056452333',
                                            prefixIcon: const Icon(Icons.phone),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    20, 15, 20, 15),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        PrimaryButton(
                          height: 45.0,
                          width: double.infinity,
                          color: ThemeColors.primaryColor,
                          buttonTitle: 'Create an account',
                          blurRadius: 7.0,
                          roundedEdge: 2.5,
                          onTap: () async {
                            if (validateForm(
                                _email.text,
                                _fullName.text,
                                _password.text,
                                _country,
                                _dialCode,
                                _code,
                                _phoneNumber.text,
                                _confirmPassword.text)) {
                              UserModel model = UserModel(
                                name: _fullName.text,
                                country: _country,
                                photo: profilePHOTO,
                                email: _email.text,
                                phone: _phoneNumber.text,
                                dialCode: _dialCode,
                                code: _code,
                                info: 0,
                                previousWorks: {},
                                isOnline: false,
                                skills: _skills,
                                specialization: _specialization,
                                cart: 0,
                                address: _address.text,
                                type: userType,
                                charge: _charge.text,
                              );
                              authController.signUp(
                                  _email.text, _password.text, model);
                            }
                          },
                        ),
                        const SizedBox(height: 25.0),

                        SocialButton(
                          platformName: 'Sign up with Google',
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
                                  authController
                                      .signInWithApple(widget.userType);
                                })
                            : Container(),
                        //
                        const SizedBox(height: 15.0),
                        Center(
                          child: FlatPrimaryButton(
                            info: 'Have an Account? ',
                            title: 'Login',
                            onTap: () {
                              Get.offAll(() => LoginScreen(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
