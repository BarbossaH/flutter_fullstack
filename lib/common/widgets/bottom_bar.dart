import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/account/screen/account_screen.dart';
import 'package:amazone_clone/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBoardWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const Center(
      child: AccountScreen(),
    ),
    const Center(
      child: Text('Cart page'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: const Icon(Icons.person_outline_outlined),
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
                child: const badges.Badge(
                  badgeContent: Text('1'),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.all(6),
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
              ),
              label: ''),
        ],
      ),
    );
  }
}
