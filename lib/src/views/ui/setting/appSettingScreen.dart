import 'package:flutter/material.dart';
import 'package:opalus/src/views/components/setting/tagBudgetSetting.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class AppSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SettingsScreen(
      title: 'Settings',
      children: [
        TagBudgetSetting(),
      ],
    );
  }
}
