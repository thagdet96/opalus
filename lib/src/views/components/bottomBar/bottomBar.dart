import 'package:flutter/material.dart';
import 'bottomIcon.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int activatedIndex = 0;

  void onTapHandler(int index) {
    this.setState(() {
      activatedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activatedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.green,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.blueGrey[100],
      items: [
        BottomNavigationBarItem(
            icon: BottomBarIcon(
              'assets/icons/transaction.svg',
              active: activatedIndex == 0,
            ),
            label: 'Transactions'),
        BottomNavigationBarItem(
            icon: BottomBarIcon(
              'assets/icons/statistic.svg',
              active: activatedIndex == 1,
            ),
            label: 'Statistics'),
        BottomNavigationBarItem(
            icon: BottomBarIcon(
              'assets/icons/budget.svg',
              active: activatedIndex == 2,
            ),
            label: 'Budget'),
        BottomNavigationBarItem(
            icon: BottomBarIcon(
              'assets/icons/setting.svg',
              active: activatedIndex == 3,
            ),
            label: 'Settings'),
      ],
      onTap: onTapHandler,
    );
  }
}
