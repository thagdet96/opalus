import 'package:opalus/src/models/core/tag.dart';
import 'package:uuid/uuid.dart';

List<Tag> mockTags = [
  Tag(id: Uuid().v4(), name: 'Tiền lương', loop: 'monthly'),
  Tag(id: Uuid().v4(), name: 'Đổ xăng'),
  Tag(id: Uuid().v4(), name: 'Ăn tối'),
  Tag(id: Uuid().v4(), name: 'Nhậu'),
];
