import 'package:flutter/material.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/services/tag.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class TagBudgetSetting extends StatelessWidget {
  final TagService tagService = TagService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: tagService.getAll(),
      builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
        return snapshot.data != null
            ? SimpleSettingsTile(
                title: 'Budget',
                subtitle: 'Set budget for tags',
                screen: SettingsScreen(
                  title: 'Budget',
                  children: snapshot.data!
                      .map((tag) => TextFieldModalSettingsTile(
                            settingKey: tag.name + '-setting',
                            title: 'Budget for ' + tag.name,
                            keyboardType: TextInputType.number,
                          ))
                      .toList(),
                ),
              )
            : Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
