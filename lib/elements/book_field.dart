import 'package:flutter/material.dart';

class BookField extends StatelessWidget {
  final label;
  final TextEditingController controller;
  BookField({this.controller,this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        labelText: '$label :',
        alignLabelWithHint: true,
      ),
      validator: (input) => input.contains('') ? '$label is not valid' : null,
      onChanged: (value) {
//                          title = value;
      },
//                      onSaved: (input) => _email = input,
    );
  }
}