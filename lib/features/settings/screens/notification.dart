import 'package:auto_route/auto_route.dart';
import 'package:diary/core/services/notification/notification_service.dart';
import 'package:diary/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:diary/features/settings/data/models/day_time_notification.dart';
import 'package:diary/generated/l10n.dart';
import 'package:diary/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/components/action_button.dart';

@RoutePage()
class SettingsNotificationPage extends StatelessWidget {
  const SettingsNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsNotificationPageView();
  }
}

class SettingsNotificationPageView extends StatelessWidget {
  const SettingsNotificationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    TimeNotification dayTimeNotification =
        BlocProvider.of<SettingsBloc>(context).state.dayTimeNotification;
    int notificationHour = dayTimeNotification.hour;
    int notificationMinute = dayTimeNotification.minute;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).notification),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                NotificationService.showTestNotification(
                    S.of(context).thisIsATestNotificationItsAllRight);
              },
              icon: const Icon(Icons.notification_important))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).howLongDoesItTakeToNotifyAboutATask,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime:
                      DateTime(0, 0, 0, notificationHour, notificationMinute),
                  itemExtent: 60,
                  use24hFormat: true,
                  onDateTimeChanged: (dateTime) {
                    notificationHour = dateTime.hour;
                    notificationMinute = dateTime.minute;
                  }),
            ),
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _ButtonAddTask(
                      onTap: () {
                        BlocProvider.of<SettingsBloc>(context).add(
                            SetNotificationDayTimeEvent(TimeNotification(
                                hour: notificationHour,
                                minute: notificationMinute)));
                        AutoRouter.of(context).pushAndPopUntil(
                            const HomeRoute(),
                            predicate: (Route<dynamic> route) => false);
                      },
                    )))
          ],
        ),
      ),
    );
  }
}

class _ButtonAddTask extends StatelessWidget {
  const _ButtonAddTask({
    required this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: ActionButton(
          text: S.of(context).save,
        ));
  }
}
