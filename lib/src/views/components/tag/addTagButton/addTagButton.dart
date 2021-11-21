import 'package:flutter/material.dart';
import 'package:opalus/src/utils/myTheme.dart';
import '../tagDetail/tagDetail.dart';

class AddTagButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: InkWell(
        child: Icon(Icons.add),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Wrap(
                    children: [
                      AppBar(
                        leading: IconButton(
                            icon: Icon(
                              Icons.navigate_before,
                              color: MyTheme.secondaryColor(),
                              size: kToolbarHeight * 0.8,
                            ),
                            onPressed: () => Navigator.pop(context)),
                      ),
                      Padding(padding: EdgeInsets.all(12), child: TagDetail()),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
