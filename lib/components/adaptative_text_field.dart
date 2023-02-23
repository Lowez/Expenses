// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  final Function() onSubmited;
  final String label;

  const AdaptativeTextField({
    required this.controller,
    this.textInputType,
    required this.onSubmited,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: textInputType,
              onSubmitted: (_) => onSubmited(),
              placeholder: label,
              // ignore: prefer_const_constructors
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: textInputType,
            onSubmitted: (_) => onSubmited(),
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
