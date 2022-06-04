import 'package:flutter/material.dart';

import '../../../core/themes/theme_colors.dart';
import '../artisans/my_artisan_request.dart';

class OrdersHome extends StatefulWidget {
  static const String id = 'OrdersHome';
  const OrdersHome({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrdersHomeState();
  }
}

class _OrdersHomeState extends State<OrdersHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'Products'),
    Tab(text: 'Requested Artisans'),
  ];
  @override
  initState() {
    _tabController = TabController(
      length: commTabs.length,
      initialIndex: 0,
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Orders', style: TextStyle(color: Colors.green)),
          iconTheme: const IconThemeData(color: Colors.green, size: 35),
          backgroundColor: ThemeColors.whiteColor,
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.green,
            unselectedLabelColor: ThemeColors.kellyGreen,
            tabs: commTabs,
          )),
      body: TabBarView(
        controller: _tabController,
        children: [Container(), const MyRequestedArtisans()],
      ),
    );
  }
}
//TODO if we have to use tabs
