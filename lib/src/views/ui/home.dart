import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/bottomBar/bottomBarBloc.dart';
import 'package:opalus/src/blocs/bottomBar/bottomBarState.dart';
import 'package:opalus/src/mocks/emptyPage.dart';
import 'package:opalus/src/views/ui/transactionScreen.dart';
import '../components/index.dart';

List<Widget> screens = [
  TranasctionScreen(),
  EmptyPage('1'),
  EmptyPage('2'),
  EmptyPage('3')
];

class MyHomePage extends StatelessWidget {
  final title;
  final _bloc = BottomBarBloc();

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        body: StreamBuilder(
          stream: _bloc.index,
          builder: (context, AsyncSnapshot<BottomBarState> snapshot) {
            BottomBarState state = snapshot.data ?? BottomBarState(0);
            int activatedIndex = state.index;

            return screens[activatedIndex];
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
