import 'package:opalus/src/mocks/group.dart';
import 'package:opalus/src/mocks/tag.dart';
import 'package:opalus/src/models/core/transaction.dart';

List<Transaction> mockTransactions = [
  Transaction(
    id: '1',
    type: 'income',
    amount: 10000000,
    title: 'lương tháng 5',
    time: DateTime(2022, 2, 20),
    // groups: [mockGroups[1]],
    tags: [mockTags[0]],
  ),
  Transaction(
    id: '2',
    type: 'outcome',
    amount: 300000,
    title: 'sushi',
    time: DateTime(2022, 3, 3),
    // groups: [mockGroups[0]],
    tags: [mockTags[2], mockTags[3]],
  ),
  Transaction(
    id: '3',
    type: 'outcome',
    amount: 50000,
    time: DateTime(2022, 2, 2),
    // groups: [mockGroups[1]],
    tags: [mockTags[1]],
  ),
  Transaction(
    id: '4',
    type: 'income',
    amount: 11000000,
    title: 'thưởng tháng 5',
    time: DateTime(2022, 2, 15),
    // groups: [mockGroups[1]],
    tags: [mockTags[0]],
  ),
  Transaction(
    id: '5',
    type: 'outcome',
    amount: 200000,
    time: DateTime(2022, 3, 15),
    // groups: [mockGroups[0]],
    tags: [mockTags[3]],
  ),
  Transaction(
    id: '6',
    type: 'outcome',
    amount: 150000,
    time: DateTime(2022, 3, 6),
    // groups: [mockGroups[0]],
    tags: [mockTags[3]],
  ),
  Transaction(
    id: '7',
    type: 'income',
    amount: 10000,
    time: DateTime(2022, 3, 7),
    // groups: [mockGroups[0]],
  ),
];
