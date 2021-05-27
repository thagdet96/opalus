import 'package:opalus/src/models/core/group.dart';
import 'package:opalus/src/services/base.dart';
import 'package:opalus/src/services/tag.dart';

class GroupService extends BaseService<Group> {
  @override
  final dbName = Group.dbName;
  final Map<String, BaseService> mappingFields = {
    'tags': TagService(),
  };

  @override
  Group fromMap(Map<String, dynamic> map) {
    return Group.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(Group model) {
    return model.toMap();
  }
}
