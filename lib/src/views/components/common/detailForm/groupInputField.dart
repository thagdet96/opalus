import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/detailForm/detailFormBloc.dart';
import 'package:opalus/src/blocs/detailForm/detailFormEvent.dart';
import 'package:opalus/src/blocs/detailForm/detailFormState.dart';
import 'package:opalus/src/models/core/group.dart';
import 'package:opalus/src/services/group.dart';
import 'utils.dart';
import 'package:opalus/src/utils/constants.dart';

class GroupInputField extends StatelessWidget {
  final _bloc = DetailFormBloc();
  final TextEditingController _controller;
  final Map<String, dynamic> model;
  final setOptionsContainerVisible;

  GroupInputField(this.model, this._controller, this.setOptionsContainerVisible);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.state,
      builder: (context, AsyncSnapshot<DetailFormState> snapshot) {
        DetailFormState state = snapshot.data ?? DetailFormState();

        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.auto_awesome_motion),
            labelText: 'Groups',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return CONSTANT_TEXT.ERROR_REQUIRED_FIELD;
            }
            return null;
          },
          onSaved: (String? value) {
            model['groups'] = getSelectedId<Group>(state.groupsSelected, state.groups);
          },
          controller: _controller,
          showCursor: true,
          readOnly: true,
          onTap: () async {
            List<Group> groups = state.groups == null ? await GroupService().getAll() : state.groups!;
            _bloc.eventSink.add(DetailFormInit<Group>(groups, _controller));
            setOptionsContainerVisible(true);
          },
        );
      },
    );
  }
}
