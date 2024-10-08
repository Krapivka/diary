import 'package:diary/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:diary/features/settings/data/models/day_time_notification.dart';
import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  const SettingsModel(
      {required this.dayTimeNotification,
      required this.language,
      required this.dateFormat,
      required this.theme});
  final TimeNotification dayTimeNotification;
  final String language;
  final String dateFormat;
  final AppThemeMode theme;

  @override
  List<Object?> get props => [dayTimeNotification, language, dateFormat, theme];
}
