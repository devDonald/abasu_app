import 'package:flutter/material.dart';

import '../../../../../core/themes/theme_colors.dart';
import 'admin_new_request.dart';
import 'admin_ongoing_request.dart';

class AdminRequestHome extends StatefulWidget {
  static const String id = 'OrdersHome';
  const AdminRequestHome({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminRequestHomeState();
  }
}

class _AdminRequestHomeState extends State<AdminRequestHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'New Requests'),
    Tab(text: 'Ongoing Requests'),
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
          title: const Text('All Artisan Requests',
              style: TextStyle(color: Colors.green)),
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
        children: const [AdminNewRequests(), AdminOngoingRequests()],
      ),
    );
  }
}
//TODO if we have to use tabs
