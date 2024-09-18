import 'package:diary/core/utils/components/action_button.dart';
import 'package:diary/core/utils/components/base_widget.dart';
import 'package:diary/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:diary/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackupRestoreTile extends StatelessWidget {
  const BackupRestoreTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<SettingsBloc>(context).add(GoogleDriveLogin());
      },
      child: BaseWidget(
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Transform.translate(
                offset: const Offset(220, -30),
                child: Transform.rotate(
                    angle: 50,
                    child: Image.asset('assets/images/Google_Drive_Logo.png')),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        S.of(context).backupOnGoogleDrive,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(S.of(context).doNotLoseDataWhenChangingYourDevice),
                  const SizedBox(
                    height: 17,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ActionButton(text: S.of(context).createABackup),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
