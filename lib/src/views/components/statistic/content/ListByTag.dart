import 'package:flutter/material.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/models/response/groupTransactionsByTag.dart';
import 'package:opalus/src/services/transaction.dart';
import '../header/DateFilter.dart';
import '../header/TagFilter.dart';
import '../header/TotalBar.dart';
import 'Row.dart';

class ListByTag extends StatefulWidget {
  final String type;

  const ListByTag(this.type, {Key? key}) : super(key: key);

  @override
  ListByTagState createState() => ListByTagState();
}

class ListByTagState extends State<ListByTag> {
  final transactionService = TransactionService();
  late List<Tag> selectedTags;
  late DateTime startDate;
  late DateTime endDate;
  List<GroupTransactionByTag> groupTransactionByTag = [];
  int total = 0;

  @override
  initState() {
    super.initState();
    selectedTags = [];
    DateTime date = DateTime.now();
    startDate = DateTime(date.year, date.month, 1);
    endDate = DateTime(date.year, date.month + 1, 0);

    getListTransactionGroupByMonth();
  }

  void onChangeDate(start, end) {
    setState(() {
      startDate = start;
      endDate = end;
    });

    getListTransactionGroupByMonth();
  }

  void onChangeSelectedTags(tags) {
    setState(() {
      selectedTags = List.from(tags!);
    });

    getListTransactionGroupByMonth();
  }

  void getListTransactionGroupByMonth() async {
    var listTagIds = selectedTags.length == 0
        ? null
        : selectedTags.map((tag) => tag.id).toList();

    print(listTagIds);
    print(startDate);
    print(endDate);
    var fetched = await transactionService.getAndGroupByTag(
      startDate,
      endDate,
      type: widget.type,
      tagIds: listTagIds,
    );

    setState(() {
      groupTransactionByTag = fetched.groupTransactionByTag ?? [];
      total = fetched.total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TotalBar(total: total),
      body: Column(
        children: [
          TagFilter(
            selectedTags: selectedTags,
            onChangeSelectedTags: onChangeSelectedTags,
          ),
          DateFilter(
            startDate: startDate,
            endDate: endDate,
            onChangeDate: onChangeDate,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: groupTransactionByTag.length,
              itemBuilder: (context, i) {
                return RowTransactionsByTag(groupTransactionByTag[i]);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          )
        ],
      ),
    );
  }
}
