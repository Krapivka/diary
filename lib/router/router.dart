import 'package:auto_route/auto_route.dart';
import 'package:diary/features/secret_entry_code/screens/secret_code.dart';
import 'package:flutter/material.dart';
import 'package:diary/core/data/models/task.dart';
import 'package:diary/core/domain/enteties/note_entity.dart';
import 'package:diary/features/backup_restore/backup_restore.dart';
import 'package:diary/features/home/home.dart';
import 'package:diary/features/note/note.dart';
import 'package:diary/features/settings/screens/data_format_selection.dart';
import 'package:diary/features/settings/screens/info.dart';
import 'package:diary/features/settings/screens/language_selection.dart';
import 'package:diary/features/settings/screens/notification.dart';
import 'package:diary/features/settings/screens/settings_list.dart';
import 'package:diary/features/settings/screens/theme_selection.dart';
import 'package:diary/features/todo_changes/adding_task/adding_task.dart';
import 'package:diary/features/todo_changes/update_task/update_task.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/home', page: HomeRoute.page),
        AutoRoute(path: '/detail_note', page: NoteRoute.page),
        AutoRoute(path: '/update_task', page: UpdateTaskRoute.page),
        AutoRoute(path: '/add_task', page: AddingTaskRoute.page),
        AutoRoute(path: '/settings_list', page: SettingsRoute.page),
        AutoRoute(
            path: '/settings/backup_restore', page: BackupRestoreRoute.page),
        AutoRoute(
            path: '/settings/notification_selection',
            page: SettingsNotificationRoute.page),
        AutoRoute(
            path: '/settings/language_selection',
            page: LanguageSelectionRoute.page),
        AutoRoute(
            path: '/settings/data_format_selection',
            page: DateFormatSelectionRoute.page),
        AutoRoute(path: '/settings/info', page: InfoRoute.page),
        AutoRoute(
            path: '/settings/theme_selection', page: ThemeSelectionRoute.page),
        AutoRoute(path: '/', page: PinCodeRoute.page)
      ];
}
