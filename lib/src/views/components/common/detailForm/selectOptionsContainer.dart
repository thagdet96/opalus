import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/detailForm/detailFormBloc.dart';
import 'package:opalus/src/blocs/detailForm/detailFormEvent.dart';
import 'package:opalus/src/blocs/detailForm/detailFormState.dart';
import 'package:opalus/src/models/core/group.dart';
import 'package:opalus/src/models/core/tag.dart';
import 'package:opalus/src/utils/myTheme.dart';

class SelectOptionsContainer extends StatelessWidget {
  final _bloc = DetailFormBloc();
  final bool visible;

  SelectOptionsContainer(this.visible);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.state,
      builder: (context, AsyncSnapshot<DetailFormState> snapshot) {
        DetailFormState state = snapshot.data ?? DetailFormState();
        var models = state.models;
        var controller = state.controller;
        bool isGroup = state.models is List<Group>;
        var tapped =
            isGroup ? Map.of(state.groupsSelected) : Map.of(state.tagsSelected);

        return Visibility(
          visible: visible,
          child: Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.5,
              ),
              itemCount: models.length,
              itemBuilder: (BuildContext context, int index) {
                var model = models[index];

                return Card(
                  margin: EdgeInsets.all(0),
                  color: tapped[model.id] == true
                      ? MyTheme.primaryColorLight()
                      : Colors.white,
                  child: InkWell(
                    onTap: () {
                      bool isSelected = tapped[model.id] == true;

                      String newName = model.name;
                      String curValue = controller!.text;
                      String newValue = isSelected
                          ? curValue
                              .replaceAll(", $newName", '')
                              .replaceAll("$newName, ", '')
                              .replaceAll(newName, '')
                          : curValue != ''
                              ? "$curValue, $newName"
                              : newName;

                      controller.value = TextEditingValue(
                        text: newValue,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: newValue.length),
                        ),
                      );

                      tapped[model.id] = !isSelected;
                      DetailFormEvent event = isGroup
                          ? DetailFormTap<Group>(tapped)
                          : DetailFormTap<Tag>(tapped);
                      _bloc.eventSink.add(event);
                    },
                    child: Center(child: Text(model.name)),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
