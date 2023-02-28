import 'package:abasu_app/features/admin/orders/admin_new_orders.dart';
import 'package:abasu_app/features/admin/orders/admin_processing_orders.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themes/theme_colors.dart';

class AdminOrderHome extends StatefulWidget {
  static const String id = 'AdminOrderHome';
  const AdminOrderHome({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminOrderHomeState();
  }
}

class _AdminOrderHomeState extends State<AdminOrderHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'New'),
    Tab(text: 'Processing/Completed'),
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
          title:
              const Text('All Orders', style: TextStyle(color: Colors.green)),
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
        children: const [AdminNewOrders(), AdminProcessingOrders()],
      ),
    );
  }
}
//TODO if we have to use tabs
