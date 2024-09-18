import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  const SettingTile(
      {super.key,
      required this.icon,
      required this.title,
      this.subtitle,
      required this.onTap});
  final Icon icon;
  final String title;
  final String? subtitle;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: onTap,
    );
  }
}
