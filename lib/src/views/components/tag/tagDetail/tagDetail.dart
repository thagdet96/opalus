import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/detailForm/detailFormBloc.dart';
import 'package:opalus/src/blocs/detailForm/detailFormEvent.dart';
import 'package:opalus/src/blocs/detailForm/detailFormState.dart';
import 'package:opalus/src/models/core/tag.dart';
import 'package:opalus/src/services/tag.dart';
import 'package:opalus/src/utils/notiHandler.dart';
import 'package:opalus/src/views/components/common/detailForm/index.dart';
import 'package:uuid/uuid.dart';

class TagDetail extends StatefulWidget {
  const TagDetail({Key? key}) : super(key: key);

  @override
  State<TagDetail> createState() => TagDetailState();
}

class TagDetailState extends State<TagDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> model = {};
  final _bloc = DetailFormBloc();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.edit_outlined),
              labelText: 'Name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return errorMessage;
              }
              return null;
            },
            onSaved: (String? value) {
              model['name'] = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.loop),
              labelText: 'Loop',
            ),
            onSaved: (String? value) {
              model['loop'] = value;
            },
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                var form = _formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();
                  form.reset();

                  String id = Uuid().v4();
                  model['id'] = id;
                  Tag tag = Tag.fromMap(model);
                  await TagService().insert(tag);

                  FocusScope.of(context).unfocus();
                  toastSuccess('Tag created');

                  List<Tag> tags = await TagService().getAll();
                  _bloc.eventSink.add(DetailFormInit<Tag>(tags));

                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
