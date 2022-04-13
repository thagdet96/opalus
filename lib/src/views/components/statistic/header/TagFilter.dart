import 'package:badges/badges.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opalus/src/models/index.dart';
import 'package:opalus/src/services/tag.dart';
import 'package:opalus/src/utils/formats.dart';
import 'package:opalus/src/utils/myTheme.dart';

class TagFilter extends StatelessWidget {
  late final List<Tag> allTags;
  final List<Tag> selectedTags;
  final onChangeSelectedTags;

  TagFilter({required this.selectedTags, this.onChangeSelectedTags}) {
    getAllTags();
  }

  void getAllTags() async {
    allTags = await TagService().getAll();
  }

  void openFilterDialog(context) async {
    await FilterListDialog.display<Tag>(
      context,
      listData: allTags,
      selectedListData: selectedTags,
      choiceChipLabel: (tag) => tag!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (tag, query) {
        return tag.name.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        onChangeSelectedTags(list);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: TextButton(
              onPressed: () => openFilterDialog(context),
              style: ButtonStyle(alignment: Alignment.centerLeft),
              child: Text(
                'Filter By Tag:',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Wrap(
            children: selectedTags
                .map(
                  (tag) => Padding(
                    padding: EdgeInsets.only(left: 12, bottom: 8),
                    child: Badge(
                      toAnimate: false,
                      borderRadius: BorderRadius.circular(8),
                      padding: EdgeInsets.all(6),
                      shape: BadgeShape.square,
                      badgeColor: MyTheme.accentColor(),
                      badgeContent: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 48),
                        child: getName(
                          tag,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
