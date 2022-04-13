import 'package:opalus/src/mocks/group.dart';
import 'package:opalus/src/mocks/tag.dart';
import 'package:opalus/src/models/core/transaction.dart';
import 'package:uuid/uuid.dart';

List<Transaction> mockTransactions = [
  Transaction(
    id: Uuid().v4(),
    type: 'income',
    amount: 10000000,
    title: 'lương tháng 5',
    time: DateTime(2022, 4, 20),
    // groups: [mockGroups[1]],
    tags: [mockTags[0]],
  ),
  Transaction(
    id: Uuid().v4(),
    type: 'outcome',
    amount: 300000,
    title: 'sushi',
    time: DateTime(2022, 4, 3),
    // groups: [mockGroups[0]],
    tags: [mockTags[2], mockTags[3]],
  ),
  Transaction(
    id: Uuid().v4(),
    type: 'outcome',
    amount: 50000,
    time: DateTime(2022, 3, 2),
    // groups: [mockGroups[1]],
    tags: [mockTags[1]],
  ),
  Transaction(
    id: Uuid().v4(),
    type: 'income',
    amount: 11000000,
    title: 'thưởng tháng 5',
    time: DateTime(2022, 3, 15),
    // groups: [mockGroups[1]],
    tags: [mockTags[0]],
  ),
  Transaction(
    id: Uuid().v4(),
    type: 'outcome',
    amount: 200000,
    time: DateTime(2022, 4, 15),
    // groups: [mockGroups[0]],
    tags: [mockTags[3]],
  ),
  Transaction(
    id: Uuid().v4(),
    type: 'outcome',
    amount: 150000,
    time: DateTime(2022, 4, 6),
    // groups: [mockGroups[0]],
    tags: [mockTags[3]],
  ),
  Transaction(
    id: Uuid().v4(),
    type: 'income',
    amount: 10000,
    time: DateTime(2022, 4, 7),
    // groups: [mockGroups[0]],
  ),
];
