import 'package:flutter/material.dart';

class SharedContainerView extends StatelessWidget {
  static List<String> kee = [];
  FocusNode mainFoucsNode = FocusNode();
  FocusNode secoundFoucsNode = FocusNode();

  SharedContainerView(
      {Key? key, required this.mainFoucsNode, required this.secoundFoucsNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 75,
        height: 75,
        child: TextFormField(
          focusNode: mainFoucsNode,
          keyboardType: TextInputType.number,
          obscureText: false,
          maxLength: 1,
          onChanged: (text) {
            kee.add(text);

            if (text.length == 1) {
              mainFoucsNode.unfocus();
              secoundFoucsNode.requestFocus();
            }
          },
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            filled: true,
            hintText: '*',
            fillColor: Colors.black12,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ));
  }
}
