import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/bottomBar/bottomBarBloc.dart';
import 'package:opalus/src/blocs/bottomBar/bottomBarEvent.dart';
import 'package:opalus/src/blocs/bottomBar/bottomBarState.dart';
import 'bottomIcon.dart';

class BottomBar extends StatelessWidget {
  final _bloc = BottomBarBloc();

  void onTapHandler(int index) {
    _bloc.eventSink.add(BottomBarEvent(index));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.index,
      builder: (BuildContext context, AsyncSnapshot<BottomBarState> snapshot) {
        BottomBarState state = snapshot.data ?? BottomBarState(0);
        int activatedIndex = state.index;

        return BottomNavigationBar(
          currentIndex: activatedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
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
      },
    );
  }
}
