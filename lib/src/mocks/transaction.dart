import 'package:opalus/src/mocks/group.dart';
import 'package:opalus/src/mocks/tag.dart';
import 'package:opalus/src/models/core/transaction.dart';

List<Transaction> mockTransactions = [
  Transaction(
    id: '1',
    type: 'income',
    amount: 10000000,
    title: 'lương tháng 5',
    time: DateTime(2021, 5, 5),
    groups: [mockGroups[1]],
    tags: [mockTags[0]],
  ),
  Transaction(
    id: '2',
    type: 'outcome',
    amount: 300000,
    title: 'sushi',
    time: DateTime(2021, 5, 5),
    groups: [mockGroups[0]],
    tags: [mockTags[2], mockTags[3]],
  ),
  Transaction(
    id: '3',
    type: 'outcome',
    amount: 50000,
    time: DateTime(2021, 5, 6),
    groups: [mockGroups[1]],
    tags: [mockTags[1]],
  ),
];
