import 'package:auto_route/auto_route.dart';
import 'package:diary/core/utils/components/base_widget.dart';

import 'package:diary/core/utils/date_utils/date_utils.dart';
import 'package:diary/features/settings/bloc/bloc/settings_bloc.dart';

import 'package:diary/features/settings/widgets/setting_tile.dart';
import 'package:diary/generated/l10n.dart';
import 'package:diary/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String mapperTheme(String themeMode) {
      switch (themeMode) {
        case "light":
          return S.of(context).lightThemeModeName;
        case "dark":
          return S.of(context).darkThemeModeName;
        case "system":
          return S.of(context).systemThemeModeName;
        default:
          return S.of(context).systemThemeModeName;
      }
    }

    String mapperLanguage(String langCode) {
      switch (langCode) {
        case "ru":
          return "Русский";
        case "en":
          return "English";
        default:
          return "Русский";
      }
    }

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return BaseWidget(
          child: ListView(
            shrinkWrap: true,
            children: [
              SettingTile(
                  icon: const Icon(Icons.notifications_on_outlined),
                  title: S.of(context).notification,
                  subtitle: S.of(context).notifyInDatetimeNHoursminutes(
                      DateTimeUtils.formatDate(
                          DateTime(0, 0, 0, state.dayTimeNotification.hour,
                              state.dayTimeNotification.minute),
                          "HH:mm")),
                  onTap: () {
                    AutoRouter.of(context)
                        .push(const SettingsNotificationRoute());
                  }),
              SettingTile(
                  icon: const Icon(Icons.language_outlined),
                  title: S.of(context).language,
                  subtitle: mapperLanguage(state.language),
                  onTap: () {
                    AutoRouter.of(context).push(const LanguageSelectionRoute());
                  }),
              SettingTile(
                icon: const Icon(Icons.date_range_outlined),
                title: S.of(context).dateFormat,
                subtitle: state.dateFormat,
                onTap: () {
                  AutoRouter.of(context).push(const DateFormatSelectionRoute());
                },
              ),
              SettingTile(
                icon: const Icon(Icons.color_lens_outlined),
                title: S.of(context).theme,
                subtitle: mapperTheme(state.theme.localization),
                onTap: () {
                  AutoRouter.of(context).push(const ThemeSelectionRoute());
                },
              ),
              SettingTile(
                icon: const Icon(Icons.info_outline),
                title: S.of(context).info,
                onTap: () {
                  AutoRouter.of(context).push(InfoRoute());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
