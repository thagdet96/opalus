import 'package:flutter/material.dart';
import 'package:opalus/src/blocs/detailForm/detailFormBloc.dart';
import 'package:opalus/src/blocs/detailForm/detailFormEvent.dart';
import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/services/transaction.dart';
import 'package:opalus/src/views/components/common/detailForm/index.dart';
import 'package:opalus/src/utils/notiHandler.dart';
import './toggleType.dart';
import 'package:uuid/uuid.dart';

class TransactionDetail extends StatefulWidget {
  const TransactionDetail({Key? key}) : super(key: key);

  @override
  State<TransactionDetail> createState() => TransactionDetailState();
}

class TransactionDetailState extends State<TransactionDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _bloc = DetailFormBloc();
  Map<String, dynamic> model = {};
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  bool optionsContainerVisible = false;

  void setOptionsContainerVisible(bool val) {
    setState(() {
      optionsContainerVisible = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ToggleType(model),
          TimeInputField(model, () => setOptionsContainerVisible(false)),
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
            onTap: () => setOptionsContainerVisible(false),
            keyboardType: TextInputType.number,
          ),
          TagInputField(model, tagsController, setOptionsContainerVisible),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              icon: Icon(Icons.edit_outlined),
              labelText: 'Title',
            ),
            onSaved: (String? value) {
              model['title'] = value ?? '';
            },
            onTap: () => setOptionsContainerVisible(false),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                var form = _formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();

                  String id = Uuid().v4();
                  model['id'] = id;
                  Transaction transaction = Transaction.fromRawMap(model);
                  await TransactionService().insert(transaction);

                  moneyController.updateValue(0);
                  clearController([tagsController, titleController]);
                  setOptionsContainerVisible(false);
                  FocusScope.of(context).unfocus();
                  _bloc.eventSink.add(null as DetailFormEvent);
                  toastSuccess('Transaction created');
                }
              },
              child: Text('Save'),
            ),
          ),
          SelectOptionsContainer(optionsContainerVisible),
        ],
      ),
    );
  }
}
