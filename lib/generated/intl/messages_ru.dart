// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(appVersion) => "Версия приложения: ${appVersion}";

  static String m1(author) => "Автор: ${author}";

  static String m2(errorMessage) => "Ошибка: ${errorMessage}";

  static String m3(day, hour, minute) =>
      "Уведомлять за ${day} дней в ${hour}:${minute}";

  static String m4(dateTime) => "Уведомлять за ${dateTime} часов/минут";

  static String m5(nextAge) => "Исполняется ${nextAge}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp": MessageLookupByLibrary.simpleMessage("О приложении"),
        "addTask": MessageLookupByLibrary.simpleMessage("Добавить задачу"),
        "addTaskButton": MessageLookupByLibrary.simpleMessage("Создать"),
        "appVersionN": m0,
        "authorN": m1,
        "backup": MessageLookupByLibrary.simpleMessage("Резервная копия"),
        "backupCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Резервное копирование завершено успешно"),
        "backupOnGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Резервная копия на Google Диске"),
        "calendar": MessageLookupByLibrary.simpleMessage("Календарь"),
        "chooseDateFormat":
            MessageLookupByLibrary.simpleMessage("Выберите формат даты:"),
        "chooseDateTime":
            MessageLookupByLibrary.simpleMessage("Выберите дату и время:"),
        "chooseTheme": MessageLookupByLibrary.simpleMessage("Выбор темы"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Выберите язык:"),
        "createABackup":
            MessageLookupByLibrary.simpleMessage("Создать резервную копию"),
        "darkThemeModeName": MessageLookupByLibrary.simpleMessage("Темная"),
        "dateFormat": MessageLookupByLibrary.simpleMessage("Формат даты"),
        "daysShouldINotifyAboutTasks": MessageLookupByLibrary.simpleMessage(
            "За сколько дней уведомлять о задачах?"),
        "deleted": MessageLookupByLibrary.simpleMessage("Удалено"),
        "descriptionForTask": MessageLookupByLibrary.simpleMessage("Описание"),
        "doNotLoseDataWhenChangingYourDevice":
            MessageLookupByLibrary.simpleMessage(
                "Не теряйте данные при смене устройства"),
        "emptyDayCalendar":
            MessageLookupByLibrary.simpleMessage("В этот день нет задач"),
        "emptyNoteList": MessageLookupByLibrary.simpleMessage(
            "Вы можете добавить заметку, нажав кнопку \"+\" ниже"),
        "emptyTasksList": MessageLookupByLibrary.simpleMessage(
            "Вы можете добавить задачу, нажав кнопку \"+\" ниже"),
        "enterNameInTextField":
            MessageLookupByLibrary.simpleMessage("Введите наименование"),
        "enterTheTextOfTheNote":
            MessageLookupByLibrary.simpleMessage("Введите текст заметки"),
        "errorN": m2,
        "fillInTheRequiredFields":
            MessageLookupByLibrary.simpleMessage("Заполните обязательные поля"),
        "googleDrive": MessageLookupByLibrary.simpleMessage("Google Диск"),
        "hintTextNameInTextField":
            MessageLookupByLibrary.simpleMessage("Наименование*"),
        "hopeMessageAppInInfo": MessageLookupByLibrary.simpleMessage(
            "Доверьтесь нам в управлении вашим временем, и мы поможем вам достичь максимальной продуктивности."),
        "howLongDoesItTakeToNotifyAboutATask":
            MessageLookupByLibrary.simpleMessage(
                "За сколько уведомлять о задаче (часы, минуты)?"),
        "info": MessageLookupByLibrary.simpleMessage("Информация"),
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "lightThemeModeName": MessageLookupByLibrary.simpleMessage("Светлая"),
        "logInToGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Войти в Google Диск"),
        "logOutOfGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Выйти из Google Диска"),
        "loggedOutSuccessfully":
            MessageLookupByLibrary.simpleMessage("Успешно вышли из системы"),
        "month": MessageLookupByLibrary.simpleMessage("месяц"),
        "notes": MessageLookupByLibrary.simpleMessage("Заметки"),
        "notification": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "notifyDayNInAdvanceAtHourNminuteN": m3,
        "notifyInDatetimeNHoursminutes": m4,
        "purposeMessageAppInInfo": MessageLookupByLibrary.simpleMessage(
            "Мы разработали это приложение с одной целью - чтобы вы никогда не забывали о своих важных делах. Наше приложение легко настраивается, чтобы обеспечить своевременные напоминания и помочь  успешно выполнять задачи."),
        "receiveNotificationsTime": MessageLookupByLibrary.simpleMessage(
            "В какое время хотите получать уведомления?"),
        "recovery": MessageLookupByLibrary.simpleMessage("Восстановление"),
        "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Восстановление завершено успешно"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Выберите цвет"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "startTyping": MessageLookupByLibrary.simpleMessage("Начните ввод"),
        "systemThemeModeName":
            MessageLookupByLibrary.simpleMessage("Системная"),
        "tasks": MessageLookupByLibrary.simpleMessage("Задачи"),
        "tasksNotFound":
            MessageLookupByLibrary.simpleMessage("Задача не найдена"),
        "theNoteIsSaved":
            MessageLookupByLibrary.simpleMessage("Заметка сохранена"),
        "theNoteWasNotFound":
            MessageLookupByLibrary.simpleMessage("Заметка не была найдена"),
        "thePasswordWasEnteredIncorrectly":
            MessageLookupByLibrary.simpleMessage(
                "Пароль был введен неправильно. Повторите попытку"),
        "theme": MessageLookupByLibrary.simpleMessage("Тема"),
        "thisIsATestNotificationItsAllRight":
            MessageLookupByLibrary.simpleMessage(
                "Это тестовое уведомление. Всё работает!"),
        "titleNote": MessageLookupByLibrary.simpleMessage("Заголовок"),
        "turnsN": m5,
        "twoWeeks": MessageLookupByLibrary.simpleMessage("2 недели"),
        "updateTask": MessageLookupByLibrary.simpleMessage("Обновить"),
        "week": MessageLookupByLibrary.simpleMessage("неделя"),
        "welcomeMessageInInfo": MessageLookupByLibrary.simpleMessage(
            "Приветствуем вас в нашем приложении для эффективного управления задачами."),
        "youHaveNotEnteredARequiredField": MessageLookupByLibrary.simpleMessage(
            "You have not entered a required field!")
      };
}
