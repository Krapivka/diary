import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:diary/core/utils/components/base_widget.dart';
import 'package:diary/core/utils/constants/Palette.dart';
import 'package:diary/features/secret_entry_code/bloc/password_bloc.dart';
import 'package:diary/features/secret_entry_code/bloc/password_event.dart';
import 'package:diary/features/secret_entry_code/bloc/password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecretCodeTile extends StatelessWidget {
  const SecretCodeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Row(
              children: [
                Icon(Icons.security),
                SizedBox(
                  width: 16,
                ),
                AutoSizeText(
                  "Установить секретный код",
                  minFontSize: 12,
                  maxFontSize: 16,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                )
              ],
            ),
            BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
                return Switch(
                    // This bool value toggles the switch.
                    value: state.isPasswordSet,
                    activeColor: Palette.primaryAccent,
                    onChanged: (bool value) {
                      if (value) {
                        context.read<PasswordBloc>().add(SetSecretCodeEvent());
                        AutoRouter.of(context).pushNamed("/");
                      } else {
                        BlocProvider.of<PasswordBloc>(context)
                            .add(const RemovePasswordEvent());
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
