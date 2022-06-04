import 'package:abasu_app/features/contracts/contracts.dart';
import 'package:abasu_app/features/contracts/my_contracts.dart';
import 'package:abasu_app/features/contracts/submit_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/themes/theme_colors.dart';

class ContractHome extends StatefulWidget {
  static const String id = 'ContractHome';
  const ContractHome({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContractHomeState();
  }
}

class _ContractHomeState extends State<ContractHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'Abasu Contracts'),
    Tab(text: 'My Contracts'),
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
        children: const [Contracts(), MyContracts()],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.blackColor1,
        child: const Icon(
          Icons.add,
          color: ThemeColors.whiteColor,
        ),
        onPressed: () {
          Get.to(() => const SubmitContract());
        },
      ),
    );
  }
}
//TODO if we have to use tabs
