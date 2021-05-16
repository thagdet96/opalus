import 'package:flutter/material.dart';
import 'package:opalus/src/views/ui/transaction/tabs/dateScreen.dart';

class TranasctionScreen extends StatefulWidget {
  @override
  TranasctionScreenState createState() => TranasctionScreenState();
}

class TranasctionScreenState extends State<TranasctionScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 36,
            color: Colors.green,
            child: new TabBar(
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.blueGrey[100],
              labelColor: Colors.white,
              tabs: [
                Tab(
                  text: "Calendar",
                ),
                Tab(
                  text: "Day",
                ),
                Tab(
                  text: "Week",
                ),
                Tab(
                  text: "Month",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Text("TAB ONE CONTENT"),
            DateScreen(),
            Text("TAB THREE CONTENT"),
            Text("TAB THREE CONTENT"),
          ],
        ),
      ),
    );
  }
}
