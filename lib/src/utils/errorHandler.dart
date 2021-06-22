import 'package:fluttertoast/fluttertoast.dart';

void toastError(err) {
  Fluttertoast.showToast(
    //Currently leave this as err message to see which error shows here in real case
    msg: err.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
  );
}
