// ignore_for_file: use_key_in_widget_constructors, empty_constructor_bodies

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const AdaptativeButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            color: Theme.of(context).colorScheme.primary,
            // ignore: prefer_const_constructors
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(label),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              primary: Theme.of(context).textTheme.button?.color,
            ),
            child: Text(label),
          );
  }
}
