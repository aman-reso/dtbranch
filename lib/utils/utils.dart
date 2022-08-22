import 'package:dtlive/utils/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: bottomnavigationText,
        textColor: primary,
        fontSize: 14);
  }
}
