part of '../flu_utils.dart';

extension FlukitText on FlukitInterface {
  /// Generate DateTime from timestamp || must be integer
  DateTime dateTimeFromTimestamp(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  /// Get only the time from a datetime.
  /// using the format specified by [pattern] or not
  String timeFromDateTime(DateTime date,
          {String pattern = 'HH:mm', String? locale}) =>
      DateFormat(pattern, locale).format(date);

  /// Creates a new DateFormat, using the format specified by [pattern].
  String formatDate(DateTime date,
          {String pattern = 'EEEE, MMM dd', String? locale}) =>
      DateFormat(pattern, locale).format(date);

  /// Formats provided [date] to a fuzzy time like 'a moment ago'
  String timeago(DateTime dateTime, {String locale = 'en'}) =>
      tmago.format(dateTime, locale: locale, allowFromNow: false);

  /// A number format for compact representations, e.g. "1.2M" instead of "1,200,000".
  String numberToCompactFormat(double number) =>
      NumberFormat.compact().format(number);

  /// Get time from seconds || must be integer
  String timeFromSeconds(int seconds) {
    int secondsInOneHour = 3600;
    int secondsInOneMinute = 60;
    String text;

    if (seconds > secondsInOneHour) {
      double hours = seconds / secondsInOneHour;
      int h = hours.toInt();
      int? m = int.tryParse(hours.toString().split('.')[1]);

      text = '${h}m ${m != null ? m.toString() + 's' : ''}';
    } else if (seconds > secondsInOneMinute) {
      double minutes = (seconds / secondsInOneHour) * secondsInOneMinute;
      int m = minutes.toInt();
      //int? s = int.tryParse(minutes.toString().split('.')[1]); // TODO review

      text = '${m}m';
    } else {
      text = '${seconds}s';
    }

    return text;
  }

  /// Emojis
  /// Todo add type
  dynamic get emojis => Emojis;

  /// Return fonts interface
  FluFonts get fonts => FluFonts();
}

class FluFonts {
  String get neptune => 'Neptune';
}
