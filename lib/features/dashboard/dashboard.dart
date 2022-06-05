import 'package:abasu_app/core/widgets/extentions.dart';
import 'package:abasu_app/features/artisans/artisan_category.dart';
import 'package:abasu_app/features/bottom_navigation/home_screen.dart';
import 'package:abasu_app/features/bottom_navigation/orders_home.dart';
import 'package:abasu_app/features/cart_notification_controlloer.dart';
import 'package:abasu_app/features/dashboard/menu_drawer.dart';
import 'package:abasu_app/features/products/screens/product_cart.dart';
import 'package:abasu_app/features/products/screens/products_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/theme.dart';
import '../../core/widgets/badge_widget.dart';
import '../../core/widgets/exit_popup_widget.dart';
import '../notification/notification_center.dart';
import '../profile/pages/my_profile.dart';
import '../search/search.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<CartNoteController> {
  DashboardPage({Key? key}) : super(key: key);

  bool isHomePageSelected = true;

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Get.to(() => const Search(
                      index: 0,
                    ));
              },
              child: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              )),
          Obx(() => Badge(
                iconData: Icons.shopping_cart,
                notificationCount: controller.cartCount.value,
                onTap: () {
                  Get.to(() => const CartPage());
                },
              )),
          Obx(() => Badge(
                iconData: Icons.notifications,
                notificationCount: controller.notificationCount.value,
                onTap: () {
                  Get.to(() => const NotificationCenter());
                },
              )),
          GestureDetector(
              onTap: () {
                Get.to(() => ProfilePage());
              },
              child: const Icon(
                Icons.person,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
    );
  }

  void onBottomIconPressed(int index) {
    if (index == 0) {
      isHomePageSelected = true;
    } else {
      isHomePageSelected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () => showExitPopup(context),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Color(0xfff8f8f8),
                          blurRadius: 10,
                          spreadRadius: 10),
                    ],
                  ),
                  child: Image.asset(
                    "images/logo2.png",
                    height: 50,
                    width: 100,
                  ),
                ),
              ).ripple(() {},
                  borderRadius: const BorderRadius.all(Radius.circular(13))),
              actions: [_appBar()],
            ),
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: [
                  const Home(),
                  ArtisanCategory(),
                  const ProductsHome(),
                  const OrdersHome(),
                  const MenuDrawer(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.black87,
              selectedItemColor: Colors.green,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.shifting,
              backgroundColor: Colors.white,
              elevation: 0,
              items: [
                _bottomNavigationBarItem(
                  icon: Icons.home_filled,
                  label: 'Home',
                ),
                _bottomNavigationBarItem(
                  icon: Icons.group_work,
                  label: 'Artisans',
                ),
                _bottomNavigationBarItem(
                  icon: Icons.construction,
                  label: 'Products',
                ),
                _bottomNavigationBarItem(
                  icon: Icons.shopping_bag,
                  label: 'Orders',
                ),
                _bottomNavigationBarItem(
                  icon: Icons.menu,
                  label: 'More',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
