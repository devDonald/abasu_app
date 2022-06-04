import 'package:abasu_app/features/admin/admin_contract/admin_add_previous_works.dart';
import 'package:abasu_app/features/admin/admin_contract/completed_contracts.dart';
import 'package:abasu_app/features/admin/admin_contract/new_contracts.dart';
import 'package:abasu_app/features/admin/admin_contract/ongoing_contracts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/themes/theme_colors.dart';

class AdminContractHome extends StatefulWidget {
  static const String id = 'AdminContractHome';
  const AdminContractHome({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminContractHomeState();
  }
}

class _AdminContractHomeState extends State<AdminContractHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'New'),
    Tab(text: 'Ongoing'),
    Tab(text: 'Completed'),
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
          title: const Text('Abasu Contracts',
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
        children: const [
          AdminNewContracts(),
          AdminOngoingContracts(),
          AdminCompletedContracts()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.blackColor1,
        child: const Icon(
          Icons.add,
          color: ThemeColors.whiteColor,
        ),
        onPressed: () {
          Get.to(() => const AdminAddPreviousWorks());
        },
      ),
    );
  }
}
//TODO if we have to use tabs
