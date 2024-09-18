import 'package:flutter/material.dart';

import 'package:diary/core/utils/constants/Palette.dart';

// ignore: must_be_immutable
class ActionButton extends StatelessWidget {
  String text;

  ActionButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Palette.primaryAccent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: const TextStyle(color: Palette.primaryLight),
        ),
      ),
    );
  }
}
