import 'package:flutter/material.dart';
import 'package:opalus/src/utils/myTheme.dart';
import 'package:opalus/src/views/ui/transaction/tabs/index.dart';

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
            height: 42,
            color: MyTheme.primaryColor(),
            child: new TabBar(
              indicatorColor: MyTheme.secondaryColor(),
              unselectedLabelColor: MyTheme.secondaryColorDark(),
              labelColor: MyTheme.secondaryColor(),
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
            Calendar(),
            DateScreen(),
            WeekScreen(),
            MonthScreen(),
          ],
        ),
      ),
    );
  }
}
