// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddingTaskRoute.name: (routeData) {
      final args = routeData.argsAs<AddingTaskRouteArgs>(
          orElse: () => const AddingTaskRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddingTaskPage(
          key: args.key,
          dateTimeCalendar: args.dateTimeCalendar,
        ),
      );
    },
    BackupRestoreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BackupRestorePage(),
      );
    },
    DateFormatSelectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DateFormatSelectionPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    InfoRoute.name: (routeData) {
      final args =
          routeData.argsAs<InfoRouteArgs>(orElse: () => const InfoRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InfoPage(key: args.key),
      );
    },
    LanguageSelectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LanguageSelectionPage(),
      );
    },
    NoteRoute.name: (routeData) {
      final args =
          routeData.argsAs<NoteRouteArgs>(orElse: () => const NoteRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NotePage(
          key: args.key,
          note: args.note,
        ),
      );
    },
    PinCodeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PinCodePage(),
      );
    },
    SettingsNotificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsNotificationPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    ThemeSelectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ThemeSelectionPage(),
      );
    },
    UpdateTaskRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateTaskRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UpdateTaskPage(
          key: args.key,
          taskmodel: args.taskmodel,
        ),
      );
    },
  };
}

/// generated route for
/// [AddingTaskPage]
class AddingTaskRoute extends PageRouteInfo<AddingTaskRouteArgs> {
  AddingTaskRoute({
    Key? key,
    DateTime? dateTimeCalendar,
    List<PageRouteInfo>? children,
  }) : super(
          AddingTaskRoute.name,
          args: AddingTaskRouteArgs(
            key: key,
            dateTimeCalendar: dateTimeCalendar,
          ),
          initialChildren: children,
        );

  static const String name = 'AddingTaskRoute';

  static const PageInfo<AddingTaskRouteArgs> page =
      PageInfo<AddingTaskRouteArgs>(name);
}

class AddingTaskRouteArgs {
  const AddingTaskRouteArgs({
    this.key,
    this.dateTimeCalendar,
  });

  final Key? key;

  final DateTime? dateTimeCalendar;

  @override
  String toString() {
    return 'AddingTaskRouteArgs{key: $key, dateTimeCalendar: $dateTimeCalendar}';
  }
}

/// generated route for
/// [BackupRestorePage]
class BackupRestoreRoute extends PageRouteInfo<void> {
  const BackupRestoreRoute({List<PageRouteInfo>? children})
      : super(
          BackupRestoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'BackupRestoreRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DateFormatSelectionPage]
class DateFormatSelectionRoute extends PageRouteInfo<void> {
  const DateFormatSelectionRoute({List<PageRouteInfo>? children})
      : super(
          DateFormatSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'DateFormatSelectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InfoPage]
class InfoRoute extends PageRouteInfo<InfoRouteArgs> {
  InfoRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          InfoRoute.name,
          args: InfoRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'InfoRoute';

  static const PageInfo<InfoRouteArgs> page = PageInfo<InfoRouteArgs>(name);
}

class InfoRouteArgs {
  const InfoRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'InfoRouteArgs{key: $key}';
  }
}

/// generated route for
/// [LanguageSelectionPage]
class LanguageSelectionRoute extends PageRouteInfo<void> {
  const LanguageSelectionRoute({List<PageRouteInfo>? children})
      : super(
          LanguageSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageSelectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotePage]
class NoteRoute extends PageRouteInfo<NoteRouteArgs> {
  NoteRoute({
    Key? key,
    NoteEntity? note,
    List<PageRouteInfo>? children,
  }) : super(
          NoteRoute.name,
          args: NoteRouteArgs(
            key: key,
            note: note,
          ),
          initialChildren: children,
        );

  static const String name = 'NoteRoute';

  static const PageInfo<NoteRouteArgs> page = PageInfo<NoteRouteArgs>(name);
}

class NoteRouteArgs {
  const NoteRouteArgs({
    this.key,
    this.note,
  });

  final Key? key;

  final NoteEntity? note;

  @override
  String toString() {
    return 'NoteRouteArgs{key: $key, note: $note}';
  }
}

/// generated route for
/// [PinCodePage]
class PinCodeRoute extends PageRouteInfo<void> {
  const PinCodeRoute({List<PageRouteInfo>? children})
      : super(
          PinCodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PinCodeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsNotificationPage]
class SettingsNotificationRoute extends PageRouteInfo<void> {
  const SettingsNotificationRoute({List<PageRouteInfo>? children})
      : super(
          SettingsNotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsNotificationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ThemeSelectionPage]
class ThemeSelectionRoute extends PageRouteInfo<void> {
  const ThemeSelectionRoute({List<PageRouteInfo>? children})
      : super(
          ThemeSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeSelectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UpdateTaskPage]
class UpdateTaskRoute extends PageRouteInfo<UpdateTaskRouteArgs> {
  UpdateTaskRoute({
    Key? key,
    required TaskModel taskmodel,
    List<PageRouteInfo>? children,
  }) : super(
          UpdateTaskRoute.name,
          args: UpdateTaskRouteArgs(
            key: key,
            taskmodel: taskmodel,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateTaskRoute';

  static const PageInfo<UpdateTaskRouteArgs> page =
      PageInfo<UpdateTaskRouteArgs>(name);
}

class UpdateTaskRouteArgs {
  const UpdateTaskRouteArgs({
    this.key,
    required this.taskmodel,
  });

  final Key? key;

  final TaskModel taskmodel;

  @override
  String toString() {
    return 'UpdateTaskRouteArgs{key: $key, taskmodel: $taskmodel}';
  }
}
