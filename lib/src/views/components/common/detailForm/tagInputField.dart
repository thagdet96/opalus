import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/detailForm/detailFormBloc.dart';
import 'package:opalus/src/blocs/detailForm/detailFormEvent.dart';
import 'package:opalus/src/blocs/detailForm/detailFormState.dart';
import 'package:opalus/src/models/core/tag.dart';
import 'package:opalus/src/services/tag.dart';
import 'utils.dart';

class TagInputField extends StatefulWidget {
  final TextEditingController _controller;
  final Map<String, dynamic> model;
  final setOptionsContainerVisible;

  const TagInputField(this.model, this._controller, this.setOptionsContainerVisible, {Key? key}) : super(key: key);

  @override
  State<TagInputField> createState() => TagInputFieldState();
}

class TagInputFieldState extends State<TagInputField> {
  final _bloc = DetailFormBloc();

  @override
  void initState() {
    super.initState();

    if (widget.model['tags'] != null) {
      loadTagContainer();
    } else {
      _bloc.eventSink.add(null as DetailFormEvent);
    }
  }

  void loadTagContainer() async {
    List<Tag> tags = widget.model['tags'];
    String initValue = getSelectedName(tags);
    widget._controller.value = TextEditingValue(
      text: initValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: initValue.length),
      ),
    );

    List<Tag> allTags = await TagService().getAll();
    _bloc.eventSink.add(DetailFormInit<Tag>(allTags, widget._controller));

    Map<String, bool> tapped = {};
    tags.forEach((element) {
      tapped[element.id] = true;
    });
    _bloc.eventSink.add(DetailFormTap<Tag>(tapped));
  }

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
            widget.model['tags'] = getSelectedId<Tag>(state.tagsSelected, state.tags);
          },
          controller: widget._controller,
          showCursor: true,
          readOnly: true,
          onTap: () async {
            List<Tag> tags = state.tags == null ? await TagService().getAll() : state.tags!;
            _bloc.eventSink.add(DetailFormInit<Tag>(tags, widget._controller));
            widget.setOptionsContainerVisible(true);
          },
        );
      },
    );
  }
}
