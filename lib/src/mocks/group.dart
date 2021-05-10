import 'package:opalus/src/mocks/tag.dart';
import 'package:opalus/src/models/core/group.dart';

List<Group> mockGroups = [
  Group(id: '1', name: 'Ăn uống', tags: [mockTags[2]]),
  Group(
    id: '2',
    name: 'Sinh hoạt',
    tags: [mockTags[2], mockTags[1]],
    budget: 2000000,
  ),
];
