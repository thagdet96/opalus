import 'package:flutter/material.dart';
import 'package:opalus/src/utils/constants.dart';

class ToggleType extends StatefulWidget {
  final Map<String, dynamic> model;

  const ToggleType(this.model, {Key? key}) : super(key: key);

  @override
  State<ToggleType> createState() => _ToggleType();
}

class _ToggleType extends State<ToggleType> {
  final double width = 150;
  bool isOutcome = true;

  @override
  void initState() {
    super.initState();
    widget.model['type'] = TRANSACTION_TYPE.OUTCOME;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ToggleButton(
            isSelected: isOutcome,
            text: TRANSACTION_TYPE.OUTCOME,
            onPressed: () {
              widget.model['type'] = TRANSACTION_TYPE.OUTCOME;

              setState(() {
                isOutcome = true;
              });
            },
          ),
        ),
        Expanded(
          child: ToggleButton(
            isSelected: !isOutcome,
            text: TRANSACTION_TYPE.INCOME,
            onPressed: () {
              widget.model['type'] = TRANSACTION_TYPE.INCOME;

              setState(() {
                isOutcome = false;
              });
            },
          ),
        ),
      ],
    );
  }
}

class ToggleButton extends StatelessWidget {
  final isSelected, text, onPressed;

  ToggleButton({this.isSelected, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? ElevatedButton(child: Text(text), onPressed: onPressed)
        : OutlinedButton(child: Text(text), onPressed: onPressed);
  }
}
