import 'package:abasu_app/features/search/search_materials.dart';
import 'package:abasu_app/features/search/search_people.dart';
import 'package:flutter/material.dart';

import '../../core/themes/theme_colors.dart';

class Search extends StatefulWidget {
  static const String id = 'Search';

  final int? index;
  const Search({Key? key, @required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  TabController? _tabController;
  String? filter;
  List<Widget> searchTabs = [
    const SearchMaterials(),
    const SearchPeople(),
  ];
  @override
  initState() {
    _tabController = TabController(
      length: searchTabs.length,
      initialIndex: widget.index!,
      vsync: this,
    );
    searchFocus.requestFocus();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    searchFocus.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: ThemeColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.shadowColor,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })),
                    const SizedBox(width: 15),
                    Flexible(
                      flex: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ThemeColors.whiteColor, //5
                        ),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          textCapitalization: TextCapitalization.sentences,
                          focusNode: searchFocus,
                          controller: searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: ThemeColors.primaryGreyColor,
                              size: 30,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchController.clear();
                              },
                              child: const Icon(Icons.close,
                                  color: ThemeColors.primaryGreyColor),
                            ),
                            border: InputBorder.none,
                            hintText: 'Search',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  child: TabBar(
                    controller: _tabController,
                    labelStyle: const TextStyle(fontSize: 10),
                    indicatorColor: ThemeColors.primaryGreyColor,
                    tabs: const [
                      Tab(
                        child: Text('Products'),
                      ),
                      Tab(
                        child: Text('Artisans'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(140),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SearchMaterials(searchController: searchController),
          SearchPeople(searchController: searchController),
        ],
      ),
    );
  }
}
