import 'package:amazone_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBoardWidth = 5;

  List<Widget> pages = [
    const Center(
      child: Text('Posts page'),
    ),
    const Center(
      child: Text('Analytics page'),
    ),
    const Center(
      child: Text('Cart page'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print(_page);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  // color: GlobalVariable.primaryColor,
                  gradient: GlobalVariable.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    width: 120,
                    height: 45,
                    // color: Colors.white,
                  ),
                ),
                const Text(
                  "Admin",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )
              ],
            ),
          )),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariable.selectedNavBarColor,
        unselectedItemColor: GlobalVariable.unselectedNavBarColor,
        iconSize: 28,
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 0
                      ? GlobalVariable.selectedNavBarColor
                      : GlobalVariable.backgroundColor,
                  width: bottomBarBoardWidth,
                ))),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 1
                      ? GlobalVariable.selectedNavBarColor
                      : GlobalVariable.backgroundColor,
                  width: bottomBarBoardWidth,
                ))),
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 2
                      ? GlobalVariable.selectedNavBarColor
                      : GlobalVariable.backgroundColor,
                  width: bottomBarBoardWidth,
                ))),
                child: const Icon(Icons.all_inbox_outlined),
              ),
              label: ''),
        ],
      ),
    );
  }
}
