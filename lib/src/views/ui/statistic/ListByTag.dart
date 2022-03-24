import 'package:flutter/material.dart';
import 'package:opalus/src/models/response/groupTransactionsByTag.dart';
import 'package:opalus/src/services/transaction.dart';
import '../../components/statistic/content/TotalBar.dart';
import '../../components/statistic/content/Row.dart';

class ListByTag extends StatefulWidget {
  final String type;

  const ListByTag(this.type, {Key? key}) : super(key: key);

  @override
  ListByTagState createState() => ListByTagState();
}

class ListByTagState extends State<ListByTag> {
  List<GroupTransactionByTag> groupTransactionByTag = [];
  int total = 0;

  @override
  initState() {
    super.initState();
    getListTransactionGroupByMonth();
  }

  getListTransactionGroupByMonth() async {
    DateTime date = DateTime.now();
    var startDate = DateTime(date.year, date.month, 1);
    var endDate = DateTime(date.year, date.month + 1, 0);

    var fetched = await TransactionService().getAndGroupByTag(startDate, endDate, type: widget.type);
    setState(() {
      groupTransactionByTag = fetched.groupTransactionByTag ?? [];
      total = fetched.total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TotalBar(total: total),
      body: ListView.separated(
        itemCount: groupTransactionByTag.length,
        itemBuilder: (context, i) {
          return RowTransactionsByTag(groupTransactionByTag[i]);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
