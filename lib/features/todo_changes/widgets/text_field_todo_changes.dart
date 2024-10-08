import 'package:diary/core/utils/constants/Palette.dart';
import 'package:flutter/material.dart';

class TextFieldTaskChanges extends StatelessWidget {
  const TextFieldTaskChanges({
    super.key,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.icon,
    this.onTap,
    this.showCursor = true,
    this.controller,
    // ignore: unused_element
    this.readOnly = false,
    this.maxLines,
  });
  final void Function(String)? onChanged;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final Icon? icon;
  final void Function()? onTap;
  final TextEditingController? controller;
  final bool? showCursor;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        cursorColor: Palette.primaryAccent,
        readOnly: readOnly,
        showCursor: showCursor,
        enableInteractiveSelection: true,
        onChanged: onChanged,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: icon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          //labelText: labelText,
          hintText: hintText,
        ),
        onTap: onTap,
      ),
    );
  }
}
