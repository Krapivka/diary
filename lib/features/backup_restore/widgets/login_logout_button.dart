import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:diary/generated/l10n.dart';

class LoginLogoutButton extends StatelessWidget {
  const LoginLogoutButton({super.key, required this.isLogin, this.onTap});
  final bool isLogin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        margin: const EdgeInsets.fromLTRB(14, 5, 14, 5),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            !isLogin
                ? AutoSizeText(
                    maxLines: 1,
                    S.of(context).logInToGoogleDrive,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                : AutoSizeText(
                    maxLines: 1,
                    S.of(context).logOutOfGoogleDrive,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
            isLogin ? const Icon(Icons.login) : const Icon(Icons.logout),
          ],
        ),
      ),
    );
  }
}
