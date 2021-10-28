import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/detailForm/detailFormBloc.dart';
import 'package:opalus/src/blocs/detailForm/detailFormEvent.dart';
import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/views/components/common/detailForm/index.dart';
import './toggleType.dart';
import 'package:uuid/uuid.dart';

class TransactionDetailForm extends StatefulWidget {
  const TransactionDetailForm({Key? key}) : super(key: key);

  @override
  State<TransactionDetailForm> createState() => DetailFormState();
}

class DetailFormState extends State<TransactionDetailForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _bloc = DetailFormBloc();
  Map<String, dynamic> model = {};
  final TextEditingController groupsController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  void hideOptionsContainer() {
    _bloc.eventSink.add(null as DetailFormEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ToggleType(model),
          TimeInputField(model, hideOptionsContainer),
          TextFormField(
            controller: moneyController,
            decoration: InputDecoration(
              icon: Icon(Icons.attach_money),
              labelText: 'Amount',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return errorMessage;
              }
              return null;
            },
            onSaved: (String? value) {
              model['amount'] = moneyController.numberValue.toInt();
            },
            onTap: hideOptionsContainer,
            keyboardType: TextInputType.number,
          ),
          GroupInputField(model, groupsController),
          TagInputField(model, tagsController),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.edit_outlined),
              labelText: 'Title',
            ),
            onSaved: (String? value) {
              model['title'] = value ?? '';
            },
            onTap: hideOptionsContainer,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                var form = _formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();
                  form.reset();
                  groupsController.clear();
                  tagsController.clear();

                  String id = Uuid().v4();
                  model['id'] = id;
                  Transaction transaction = Transaction.fromRawMap(model);
                  await TransactionService().insert(transaction);
                  hideOptionsContainer();
                }
              },
              child: Text('Save'),
            ),
          ),
          SelectOptionsContainer(),
        ],
      ),
    );
  }
}
