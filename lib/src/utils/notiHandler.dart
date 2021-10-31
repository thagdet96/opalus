import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastError(msg) {
  Fluttertoast.showToast(
    //Currently leave this as err message to see which error shows here in real case
    msg: msg.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.red[400],
  );
}

void toastInfo(msg) {
  Fluttertoast.showToast(
    //Currently leave this as err message to see which error shows here in real case
    msg: msg.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.blue[300],
  );
}

void toastSuccess(msg) {
  Fluttertoast.showToast(
    //Currently leave this as err message to see which error shows here in real case
    msg: msg.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.green[300],
  );
}
