import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:opalus/src/models/response/summarizeTag.dart';
import 'package:opalus/src/services/tag.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/views/components/budget/BudgetBar.dart';
import 'package:opalus/src/views/components/budget/rowTagBudget.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class BudgetScreen extends StatefulWidget {
  @override
  State<BudgetScreen> createState() => BudgetScreenState();
}

class BudgetScreenState extends State<BudgetScreen> {
  final transactionService = TransactionService();
  final tagService = TagService();
  DateTime date = DateTime.now();
  late final List<SummarizeTag> budgetTags;
  int totalAmount = 0;
  int totalBudget = 0;
  List<SummarizeTag> summarizeTags = [];

  @override
  initState() {
    super.initState();
    onMounted();
  }

  onMounted() async {
    var allTags = await tagService.getAll();
    int allBudget = 0;
    budgetTags = await allTags.fold([], (previousValue, tag) async {
      int budget = int.parse(
        await Settings().getString(tag.name + '-setting', '0'),
      );

      if (budget == 0) return previousValue;

      (await previousValue)
          .add(SummarizeTag(tag: tag, budget: budget, amount: 0));
      allBudget += budget;

      return previousValue;
    });

    setState(() {
      totalBudget = allBudget;
    });

    summarizeBudgetTag();
  }

  void openMonthPicker() async {
    final DateTime? monthPicker = await showMonthYearPicker(
      context: context,
      firstDate: DateTime(date.year - 1),
      lastDate: DateTime(date.year + 1),
      initialDate: date,
    );

    if (monthPicker == null) return;

    setState(() {
      date = monthPicker;
    });

    summarizeBudgetTag();
  }

  void summarizeBudgetTag() async {
    var fetched = await transactionService.summarizeBudgetTag(
      DateTime(date.year, date.month, 1),
      DateTime(date.year, date.month + 1, 0),
      budgetTags,
    );

    setState(() {
      totalAmount = fetched.total;
      summarizeTags = fetched.summarizeTags;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: TextButton(
                    onPressed: openMonthPicker,
                    style: ButtonStyle(alignment: Alignment.centerLeft),
                    child: Text(
                      "Month: ${date.month}/${date.year}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          BudgetBar(amount: totalAmount, budget: totalBudget),
          Expanded(
            child: ListView.separated(
              itemCount: summarizeTags.length,
              itemBuilder: (context, i) => RowTagBudget(summarizeTags[i]),
              separatorBuilder: (context, index) => Divider(),
            ),
          )
        ],
      ),
    );
  }
}
