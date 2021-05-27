import 'package:flutter/material.dart';
import 'package:opalus/src/models/reponse/groupTransactions.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/views/components/transaction/byDate/transactionsPerDate.dart';

class DateScreen extends StatefulWidget {
  @override
  DateScreenState createState() => DateScreenState();
}

class DateScreenState extends State<DateScreen> {
  List<GroupTransaction> listTransactions = [];

  @override
  initState() {
    super.initState();
    getListTransactionGroupByDate();
  }

  getListTransactionGroupByDate() async {
    var fetched = await TransactionService().getAndGroupByDate(
      DateTime.now(),
      true,
    );
    setState(() {
      listTransactions = fetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listTransactions.length,
        itemBuilder: (context, index) {
          return TransactionsPerDate(listTransactions[index]);
        });
  }
}
