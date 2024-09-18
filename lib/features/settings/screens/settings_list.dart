import 'package:auto_route/auto_route.dart';
import 'package:diary/features/backup_restore/bloc/google_drive_bloc.dart';
import 'package:diary/core/services/google_drive/google_drive_service.dart';

import 'package:diary/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:diary/features/settings/widgets/backup_restore_tile.dart';
import 'package:diary/features/settings/widgets/secret_code_tile.dart';

import 'package:diary/features/settings/widgets/settings_list_widget.dart';
import 'package:diary/generated/l10n.dart';
import 'package:diary/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleDriveBloc(context.read<GoogleDriveService>()),
      child: const SettingsPageView(),
    );
  }
}

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
      if (state.status == SettingsStatus.login) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('You have successfully logged in')),
        // );
        AutoRouter.of(context).push(const BackupRestoreRoute());
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).settings),
          centerTitle: true,
        ),
        body: const Column(
          children: [
            BackupRestoreTile(),
            SettingsList(),
            SecretCodeTile(),
          ],
        ),
      );
    });
  }
}
