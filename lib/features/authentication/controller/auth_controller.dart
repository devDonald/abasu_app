import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/constants/contants.dart';
import '../../../core/widgets/customFullScreenDialog.dart';
import '../../../core/widgets/custom_dialog.dart';
import '../../dashboard/dashboard.dart';
import '../model/app_users_model.dart';
import '../pages/login_screen.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  late Rx<User?> _firebaseUser;
  RxBool isLoggedIn = false.obs;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'email',
    "https://www.googleapis.com/auth/userinfo.profile",
  ]);

  final SignInWithApple appleSign = SignInWithApple();
  //User? _user;
  var isSignIn = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool admin = false.obs;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  User? get user => _firebaseUser.value;

  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  void onReady() {
    super.onReady();
    //_user = _auth.currentUser!;
    _firebaseUser = Rx<User?>(_auth.currentUser);
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = _auth.currentUser != null;
    _auth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });
  }

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      userModel.bindStream(listenToUser());
      Get.offAll(() => DashboardPage());
    } else {
      Get.offAll(() => LoginScreen(
            userType: 'Buyer',
          ));
    }
  }

  void signIn(String email, String password) async {
    try {
      CustomFullScreenDialog.showDialog();
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) {
        getUserLoginStatus();
        successToastMessage(msg: 'Login Successful');
        CustomFullScreenDialog.cancelDialog();
        Get.offAll(() => DashboardPage());
      }).onError((error, stackTrace) {
        CustomFullScreenDialog.cancelDialog();
        errorToastMessage(msg: error.toString());
      });
    } catch (e) {
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp(String email, String password, UserModel user) async {
    CustomFullScreenDialog.showDialog();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        user.userId = result.user!.uid;
        _addUserToFirestore(user);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('type', user.type!);
        getUserLoginStatus();
        successToastMessage(msg: 'Registration Successful');
        CustomFullScreenDialog.cancelDialog();
        Get.offAll(() => DashboardPage());
      }).onError((error, stackTrace) {
        CustomFullScreenDialog.cancelDialog();
        errorToastMessage(msg: 'An error occurred, please try again');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
    }
  }

  void signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    successToastMessage(msg: 'You are logged out');
  }

  _addUserToFirestore(UserModel user) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(user.userId)
        .set(user.toJson());
    // _user!.updatePhotoURL(user.photo);
    // _user!.updateDisplayName(user.name);
  }

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

  void googleLogin(String userType) async {
    googleSignIn.disconnect();
    CustomFullScreenDialog.showDialog();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      CustomFullScreenDialog.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      await _auth.signInWithCredential(oAuthCredential).then((result) async {
        await firebaseFirestore
            .collection(usersCollection)
            .doc(result.user!.uid)
            .get()
            .then((value) async {
          if (!value.exists) {
            UserModel model = UserModel(
                userId: result.user!.uid,
                name: result.user!.displayName,
                country: 'Nigeria',
                code: 'NG',
                dialCode: '+124',
                address: 'edit address',
                skills: [],
                charge: "0",
                phone: 'edit phone number',
                specialization: '',
                photo: result.user!.photoURL,
                email: result.user!.email,
                info: 0,
                previousWorks: {},
                isOnline: false,
                type: userType);
            _addUserToFirestore(model);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('type', userType);
          } else {
            successToastMessage(msg: 'Welcome back');
          }
        });
        successToastMessage(msg: 'Login Successful');
        CustomFullScreenDialog.cancelDialog();
        Get.offAll(() => DashboardPage());
      }).onError((error, stackTrace) {
        errorToastMessage(msg: error.toString());
      });
    }
  }

  void signInWithApple(String userType) async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);

      print(appleCredential.authorizationCode);
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
          idToken: appleCredential.identityToken, rawNonce: rawNonce);

      await _auth.signInWithCredential(credential).then((result) async {
        await firebaseFirestore
            .collection(usersCollection)
            .doc(result.user!.uid)
            .get()
            .then((value) async {
          if (!value.exists) {
            UserModel model = UserModel(
                userId: result.user!.uid,
                name: result.user!.displayName,
                country: 'Nigeria',
                code: 'NG',
                dialCode: '+124',
                address: 'edit address',
                skills: [],
                charge: "0",
                phone: 'edit phone number',
                specialization: '',
                info: 0,
                previousWorks: {},
                isOnline: false,
                photo: result.user!.photoURL,
                email: result.user!.email,
                type: userType);
            _addUserToFirestore(model);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('type', userType);
          } else {
            successToastMessage(msg: 'Welcome back');
          }
        });
        successToastMessage(msg: 'Login Successful');
        CustomFullScreenDialog.cancelDialog();
        Get.offAll(() => DashboardPage());
      }).onError((error, stackTrace) {
        errorToastMessage(msg: error.toString());
      });
    } catch (exception) {
      print(exception);
    }
  }

  updateUserData(Map<String, dynamic> data) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(_firebaseUser.value!.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(_firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));

  void resetPassword(String email, BuildContext context) async {
    await _auth.sendPasswordResetEmail(email: email).then((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDescriptionBox(
              title: 'Password Reset Link Generated',
              descriptions:
                  'Check your email $email for the link to reset your password',
            );
          });
    }).catchError((error) {});
  }
}
