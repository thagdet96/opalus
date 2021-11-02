import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/detailForm/detailFormBloc.dart';
import 'package:opalus/src/blocs/detailForm/detailFormEvent.dart';
import 'package:opalus/src/blocs/detailForm/detailFormState.dart';
import 'package:opalus/src/models/core/tag.dart';
import 'package:opalus/src/services/tag.dart';
import 'utils.dart';

class TagInputField extends StatelessWidget {
  final _bloc = DetailFormBloc();
  final TextEditingController _controller;
  final Map<String, dynamic> model;
  final setOptionsContainerVisible;

  TagInputField(this.model, this._controller, this.setOptionsContainerVisible);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.state,
      builder: (context, AsyncSnapshot<DetailFormState> snapshot) {
        DetailFormState state = snapshot.data ?? DetailFormState();

        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.bookmarks),
            labelText: 'Tags',
          ),
          onSaved: (String? value) {
            model['tags'] = getSelectedId<Tag>(state.tagsSelected, state.tags);
          },
          controller: _controller,
          showCursor: true,
          readOnly: true,
          onTap: () async {
            List<Tag> tags = state.tags == null ? await TagService().getAll() : state.tags!;
            _bloc.eventSink.add(DetailFormInit<Tag>(tags, _controller));
            setOptionsContainerVisible(true);
          },
        );
      },
    );
  }
}
