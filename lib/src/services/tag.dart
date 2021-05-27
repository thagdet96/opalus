import 'package:opalus/src/models/core/tag.dart';
import 'package:opalus/src/services/base.dart';

class TagService extends BaseService<Tag> {
  @override
  final dbName = Tag.dbName;

  @override
  Tag fromMap(Map<String, dynamic> map) {
    return Tag.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(Tag model) {
    return model.toMap();
  }
}
