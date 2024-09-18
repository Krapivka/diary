import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();
  static String formatDate(DateTime dateTime, String dateFormat) {
    final DateFormat formatter = DateFormat(dateFormat);
    final date = formatter.format(dateTime);

    return date;
  }

  static int getDifferenceDate(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  static String getDifferenceCurrentDayTask(DateTime task) {
    DateTime currentDate = DateTime.now();

    DateTime nextTask = DateTime(currentDate.year, task.month, task.day);

    if (currentDate.day == nextTask.day &&
        currentDate.month == nextTask.month) {
      return 0.toString();
    }
    if (currentDate.isAfter(nextTask)) {
      nextTask = DateTime(currentDate.year + 1, task.month, task.day);
    }

    int differenceInDays = nextTask.difference(currentDate).inDays;

    return (differenceInDays + 1).toString();
  }

  static String parseDateToString(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  static DateTime combineDateAndTime(DateTime datePart, DateTime timePart) {
    return DateTime(
      datePart.year,
      datePart.month,
      datePart.day,
      timePart.hour,
      timePart.minute,
      timePart.second,
      timePart.millisecond,
      timePart.microsecond,
    );
  }

  static String get defaultDateFormat => 'dd/MM/yyyy HH:mm';

  static List<String> get dateFormatList => [
        'dd/MM/yyyy HH:mm',
        'dd-MM-yyyy HH:mm',
        'dd.MM.yyyy HH:mm',
        'MM/dd/yyyy HH:mm',
        'MM-dd-yyyy HH:mm',
        'MM.dd.yyyy HH:mm',
      ];
}
