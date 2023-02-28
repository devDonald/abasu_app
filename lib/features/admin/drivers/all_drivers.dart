import 'package:abasu_app/features/admin/drivers/unverified_drivers.dart';
import 'package:abasu_app/features/admin/drivers/verified_drivers.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themes/theme_colors.dart';

class AbasuDrivers extends StatefulWidget {
  static const String id = 'AbasuDrivers';
  const AbasuDrivers({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AbasuDriversState();
  }
}

class _AbasuDriversState extends State<AbasuDrivers>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'Unverified'),
    Tab(text: 'Verified'),
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
              const Text('All Drivers', style: TextStyle(color: Colors.green)),
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
        children: const [UnVerifiedDrivers(), VerifiedDrivers()],
      ),
    );
  }
}
//TODO if we have to use tabs
