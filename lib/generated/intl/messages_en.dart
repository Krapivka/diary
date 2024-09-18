// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(appVersion) => "Application Version: ${appVersion}";

  static String m1(author) => "Author: ${author}";

  static String m2(errorMessage) => "Error: ${errorMessage}";

  static String m3(day, hour, minute) =>
      "notify ${day} days in advance at ${hour}:${minute}";

  static String m4(dateTime) => "Notify in ${dateTime} hours/minutes";

  static String m5(nextAge) => "Turns ${nextAge}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp": MessageLookupByLibrary.simpleMessage("About app"),
        "addTask": MessageLookupByLibrary.simpleMessage("Add task"),
        "addTaskButton": MessageLookupByLibrary.simpleMessage("Add task"),
        "appVersionN": m0,
        "authorN": m1,
        "backup": MessageLookupByLibrary.simpleMessage("Backup"),
        "backupCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Backup completed successfully"),
        "backupOnGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Backup on Google Drive"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "chooseDateFormat":
            MessageLookupByLibrary.simpleMessage("Select the date format:"),
        "chooseDateTime":
            MessageLookupByLibrary.simpleMessage("Выберите дату и время:"),
        "chooseTheme": MessageLookupByLibrary.simpleMessage("Select themes"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Select a language:"),
        "createABackup":
            MessageLookupByLibrary.simpleMessage("Create a backup"),
        "darkThemeModeName": MessageLookupByLibrary.simpleMessage("Dark"),
        "dateFormat": MessageLookupByLibrary.simpleMessage("Date format"),
        "daysShouldINotifyAboutTasks": MessageLookupByLibrary.simpleMessage(
            "How many days should notify about tasks?"),
        "deleted": MessageLookupByLibrary.simpleMessage("Deleted"),
        "descriptionForTask": MessageLookupByLibrary.simpleMessage("Описание"),
        "doNotLoseDataWhenChangingYourDevice":
            MessageLookupByLibrary.simpleMessage(
                "Do not lose data when changing your device"),
        "emptyDayCalendar": MessageLookupByLibrary.simpleMessage(
            "There are no tasks on this day"),
        "emptyNoteList": MessageLookupByLibrary.simpleMessage(
            "You can add a note by clicking the \"+\" button below"),
        "emptyTasksList": MessageLookupByLibrary.simpleMessage(
            "You can add a task by clicking the \"+\" button below"),
        "enterNameInTextField":
            MessageLookupByLibrary.simpleMessage("Enter name"),
        "enterTheTextOfTheNote":
            MessageLookupByLibrary.simpleMessage("Enter the text of the note"),
        "errorN": m2,
        "fillInTheRequiredFields":
            MessageLookupByLibrary.simpleMessage("Fill in the required fields"),
        "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
        "hintTextNameInTextField":
            MessageLookupByLibrary.simpleMessage("Title*"),
        "hopeMessageAppInInfo": MessageLookupByLibrary.simpleMessage(
            "Trust us to manage your time and we will help you achieve maximum productivity."),
        "howLongDoesItTakeToNotifyAboutATask":
            MessageLookupByLibrary.simpleMessage(
                "How long does it take to notify about a task (hours, minutes)?"),
        "info": MessageLookupByLibrary.simpleMessage("Info"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lightThemeModeName": MessageLookupByLibrary.simpleMessage("Light"),
        "logInToGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Log in to Google Drive"),
        "logOutOfGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Log out of Google Drive"),
        "loggedOutSuccessfully":
            MessageLookupByLibrary.simpleMessage("Logged out successfully"),
        "month": MessageLookupByLibrary.simpleMessage("month"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notification": MessageLookupByLibrary.simpleMessage("Notifications"),
        "notifyDayNInAdvanceAtHourNminuteN": m3,
        "notifyInDatetimeNHoursminutes": m4,
        "purposeMessageAppInInfo": MessageLookupByLibrary.simpleMessage(
            "We have developed this application with one goal in mind - so that you never forget about your important business. Our app is easily customizable to provide timely reminders and help you complete tasks successfully."),
        "receiveNotificationsTime": MessageLookupByLibrary.simpleMessage(
            "What time do you want to receive notifications?"),
        "recovery": MessageLookupByLibrary.simpleMessage("Recovery"),
        "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Restore completed successfully"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Select color"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "startTyping": MessageLookupByLibrary.simpleMessage("Start typing"),
        "systemThemeModeName": MessageLookupByLibrary.simpleMessage("System"),
        "tasks": MessageLookupByLibrary.simpleMessage("Tasks"),
        "tasksNotFound":
            MessageLookupByLibrary.simpleMessage("The task was not found"),
        "theNoteIsSaved":
            MessageLookupByLibrary.simpleMessage("The note is saved"),
        "theNoteWasNotFound":
            MessageLookupByLibrary.simpleMessage("The note was not found"),
        "thePasswordWasEnteredIncorrectly":
            MessageLookupByLibrary.simpleMessage(
                "The password was entered incorrectly. Try again"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "thisIsATestNotificationItsAllRight":
            MessageLookupByLibrary.simpleMessage(
                "This is a test notification. It\'s all right!"),
        "titleNote": MessageLookupByLibrary.simpleMessage("Title"),
        "turnsN": m5,
        "twoWeeks": MessageLookupByLibrary.simpleMessage("2 weeks"),
        "updateTask": MessageLookupByLibrary.simpleMessage("Update task"),
        "week": MessageLookupByLibrary.simpleMessage("week"),
        "welcomeMessageInInfo": MessageLookupByLibrary.simpleMessage(
            "Welcome to our application for effective task management."),
        "youHaveNotEnteredARequiredField": MessageLookupByLibrary.simpleMessage(
            "You have not entered a required field!")
      };
}
