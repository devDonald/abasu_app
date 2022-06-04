import 'package:get/get.dart';

import '../../features/authentication/pages/login_screen.dart';
import '../../features/authentication/pages/register_screen.dart';
import '../../features/authentication/pages/reset_password.dart';
import '../../features/bottom_navigation/home_screen.dart';
import '../../splash_screen.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => const LoginScreen(userType: "Buyer")),
    GetPage(
        name: '/signup',
        page: () => const RegisterScreen(
              userType: 'Buyer',
            )),
    GetPage(name: '/home', page: () => const Home()),
    //GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => const ResetPassword()),
    //GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}
