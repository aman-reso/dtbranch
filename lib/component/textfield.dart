import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

// ignore: must_be_immutable
class TextFieldUI extends StatefulWidget {
  String text;
  TextFieldUI(this.text, {Key? key}) : super(key: key);

  @override
  State<TextFieldUI> createState() => _TextFieldUIState();
}

class _TextFieldUIState extends State<TextFieldUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 08),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.07,
        child: TextField(
            style: const TextStyle(color: textColor),
            obscureText: true,
            decoration: InputDecoration(
              hintText: widget.text,
              hintStyle: TextStyle(
                color: blueGrey500,
                fontSize: 15,
              ),
              prefixIcon: const Icon(
                Icons.lock,
                color: greyColor,
              ),
              suffixIcon: const Icon(
                Icons.remove_red_eye_outlined,
                color: greyColor,
              ),
              filled: true,
              fillColor: transParentColor,
              disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(07),
                  ),
                  borderSide: BorderSide(color: yellowColor, width: 2)),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(07.0)),
                borderSide: BorderSide(color: greyColor, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(07)),
                borderSide: BorderSide(color: greyColor, width: 1),
              ),
            )),
      ),
    );
  }
}
