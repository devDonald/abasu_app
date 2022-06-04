import 'package:abasu_app/features/artisans/view_all_artisan.dart';
import 'package:abasu_app/features/contracts/contracts_home.dart';
import 'package:abasu_app/features/products/screens/view_all_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/contants.dart';
import '../../core/widgets/home_view_widget.dart';
import '../../core/widgets/other_widgets.dart';
import '../../core/widgets/top_button.dart';
import '../authentication/model/app_users_model.dart';
import '../products/helpers/products_card.dart';
import '../products/model/product.dart';
import '../profile/pages/artisan_profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // void _checkVersion() async {
  //   final newVersion = NewVersion(
  //       androidId: "com.abidon.sisterhood_global",
  //       iOSId: "org.sisterhoodglobal.app");
  //   final status = await newVersion.getVersionStatus();
  //   newVersion.showUpdateDialog(
  //     context: context,
  //     versionStatus: status!,
  //     dialogTitle: "UPDATE AVAILABLE!!!",
  //     dismissButtonText: "Skip",
  //     allowDismissal: true,
  //     dialogText: "Please update the Sisterhood Global App from Version " +
  //         status.localVersion +
  //         " to Version " +
  //         status.storeVersion,
  //     dismissAction: () {
  //       SystemNavigator.pop();
  //     },
  //     updateButtonText: "UPDATE NOW",
  //   );
  // }
  @override
  void initState() {
    super.initState();
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          GridView(
            padding: const EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                childAspectRatio: 1.0,
                crossAxisCount: 2),
            children: [
              GestureDetector(
                onTap: () {},
                child: const HomeView(
                  category: 'Data Services',
                  image: 'images/data.jpg',
                  comingSoon: 'COMING SOON',
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const HomeView(
                  category: 'Hospitality',
                  image: 'images/hospitality.png',
                  comingSoon: 'COMING SOON',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ContractHome());
                },
                child: const HomeView(
                  category: "Contract Us",
                  image: 'images/contract.jpeg',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(top: 17.5, left: 7.0, right: 7.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: EventButton(
                icon: Icons.construction,
                title: 'Top Products',
                viewAll: 'View All Products',
                onTap: () {
                  Get.to(() => const ViewAllProducts());
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                top: 17.5, bottom: 5.0, left: 7.0, right: 7.0),
            //padding: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 2.5),
                  blurRadius: 10.5,
                ),
              ],
            ),
            child: SizedBox(
              height: 180,
              child: StreamBuilder(
                  stream: root
                      .collection('products')
                      .where('isTop', isEqualTo: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Product product =
                              Product.fromSnapshot(snapshot.data!.docs[index]);
                          return ProductCard(
                            isTop: product.isTop!,
                            isAdmin: false,
                            subCategory: product.subCategory,
                            productName: product.productName,
                            price: product.unitPrice,
                            formerPrice: product.formerPrice,
                            productCategory: product.category,
                            productImages: product.imageUrls,
                            description: product.description,
                            productId: product.productId,
                          );
                        });
                  }),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(top: 17.5, left: 7.0, right: 7.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: EventButton(
                icon: Icons.precision_manufacturing_outlined,
                title: 'Top Artisans',
                viewAll: 'View All Artisans',
                onTap: () {
                  Get.to(() => const ViewAllArtisans());
                },
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                  top: 17.5, bottom: 5.0, left: 7.0, right: 7.0),
              //padding: EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 2.5),
                    blurRadius: 10.5,
                  ),
                ],
              ),
              child: SizedBox(
                height: 300,
                child: StreamBuilder(
                    stream: root
                        .collection('users')
                        .where('type', isEqualTo: 'Artisan')
                        .where('isTop', isEqualTo: true)
                        .orderBy('name', descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            UserModel _users = UserModel.fromSnapshot(
                                snapshot.data!.docs[index]);
                            return ArtisanHomeWidget(
                              userName: _users.name!.toUpperCase(),
                              profileImage: _users.photo,
                              specialization: _users.specialization,
                              charge: _users.charge,
                              skills: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 8.5,
                                  direction: Axis.horizontal,
                                  children: _users.isTagAdded!
                                      ? _users.addedTags
                                      : [] //empty list,
                                  ),
                              address: _users.address,
                              onTap: () {
                                Get.to(() => HireArtisanProfile(
                                      isAdmin: false,
                                      user: _users,
                                    ));
                              },
                              onFollow: () {},
                            );
                          });
                    }),
              )),
        ],
      ),
    );
  }
}
