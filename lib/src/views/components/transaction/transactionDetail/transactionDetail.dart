import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:opalus/src/blocs/detailForm/detailFormBloc.dart';
import 'package:opalus/src/blocs/detailForm/detailFormEvent.dart';
import 'package:opalus/src/models/core/transaction.dart';
import 'package:opalus/src/views/components/common/detailForm/index.dart';
import './saveButton.dart';
import 'package:opalus/src/utils/constants.dart';
import './toggleType.dart';

class TransactionDetail extends StatefulWidget {
  final Transaction? transaction;

  const TransactionDetail({this.transaction, Key? key}) : super(key: key);

  @override
  State<TransactionDetail> createState() => TransactionDetailState();
}

class TransactionDetailState extends State<TransactionDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _bloc = DetailFormBloc();
  Map<String, dynamic> model = {};
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final moneyController = MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: '',
  );

  bool optionsContainerVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.transaction is Transaction) {
      model = widget.transaction!.toRawMap();

      moneyController.updateValue(model['amount'].toDouble());
      titleController.text = model['title'];
    }
  }

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
                return CONSTANT_TEXT.ERROR_REQUIRED_FIELD;
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
          SaveButton(model, formKey: _formKey, actionAfterSave: () {
            model['id'] = null;
            moneyController.updateValue(0);
            clearController([tagsController, titleController]);
            setOptionsContainerVisible(false);
            FocusScope.of(context).unfocus();
            _bloc.eventSink.add(null as DetailFormEvent);
          }),
          SelectOptionsContainer(optionsContainerVisible),
        ],
      ),
    );
  }
}
