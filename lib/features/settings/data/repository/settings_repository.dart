import 'package:flutter/material.dart';
import 'package:diary/core/error/failure.dart';
import 'package:diary/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:diary/features/settings/data/models/day_time_notification.dart';
import 'package:diary/features/settings/data/models/settings.dart';
import 'package:diary/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:dartz/dartz.dart';

class SettingsRepository implements AbstractSettingsRepository {
  final AbstractSettingsLocalDataSource localDataSource;

  SettingsRepository({required this.localDataSource});
  @override
  Future<Either<Failure, String>> getDateFormat() async {
    try {
      final dateFormat = await localDataSource.getDateFormatFromCache();
      return Right(dateFormat);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      final lang = await localDataSource.getLanguageFromCache();
      return Right(lang);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, TimeNotification>> getNotificationDayTime() async {
    try {
      final notificationDay =
          await localDataSource.getNotificationDayTimeNotificationFromCache();
      return Right(notificationDay);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> getTheme() async {
    try {
      final theme = await localDataSource.getThemeFromCache();
      return Right(theme);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> setDateFormat(String dateFormat) async {
    try {
      return Right(await localDataSource.dateFormatToCache(dateFormat));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> setLanguage(String lang) async {
    try {
      return Right(await localDataSource.languageToCache(lang));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> setNotificationDayTime(
      TimeNotification dayTime) async {
    try {
      return Right(await localDataSource
          .notificationDayTimeNotificationToCache(dayTime));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> setTheme(AppThemeMode theme) async {
    try {
      return Right(await localDataSource.themeToCache(theme));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, SettingsModel>> getSettingsData() async {
    String dateFormat = '';
    String language = '';
    TimeNotification dayTimeNotification = TimeNotification(hour: 0, minute: 0);
    AppThemeMode theme = AppThemeMode.system;
    try {
      (await getDateFormat()).fold(
          (failure) => debugPrint("error"), (result) => dateFormat = result);
      (await getLanguage()).fold(
          (failure) => debugPrint("error"), (result) => language = result);
      (await getNotificationDayTime()).fold((failure) => debugPrint("error"),
          (result) => dayTimeNotification = result);
      (await getTheme()).fold((failure) => debugPrint("error"), (result) {
        switch (result) {
          case "system":
            theme = AppThemeMode.system;
            break;
          case "dark":
            theme = AppThemeMode.dark;
            break;
          case "light":
            theme = AppThemeMode.light;
            break;
        }
      });
      return (Right(SettingsModel(
          dayTimeNotification: dayTimeNotification,
          language: language,
          dateFormat: dateFormat,
          theme: theme)));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }
}
