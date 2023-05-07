import 'package:flukit/flukit.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as time;

extension T on FluInterface {
  /// Generate DateTime from timestamp || must be integer
  DateTime dateTimeFromTimestamp(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  /// Get only the time from a datetime.
  String timeFromDateTime(DateTime date,
          {bool withSeconds = false, String? locale}) =>
      formatDate(date,
          pattern: 'HH:mm${withSeconds ? ':ss' : ''}', locale: locale);

  /// Creates a new DateFormat, using the format specified by [pattern].
  String formatDate(DateTime date,
          {String pattern = 'EEEE, MMM dd', String? locale}) =>
      DateFormat(pattern, locale).format(date);

  /// Formats provided [date] to a fuzzy time like 'a moment ago'
  String timeago(DateTime dateTime, {String locale = 'en'}) =>
      time.format(dateTime, locale: locale, allowFromNow: false);

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

      text = '${h}m ${m != null ? '${m}s' : ''}';
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

  /// format seconds to time
  String timeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    return "$hourLeft : $minuteLeft : $secondsLeft";
  }

  String textToAvatarFormat(String text) {
    text = text.trim();
    List<String> array = text.split(' ');

    if (array.length >= 2) {
      text = array[0][0] + array[array.length - 1][0];
    } else {
      text = text[0];
    }

    return text.toLowerCase();
  }

  /// Duration to formatted string
  String formatDuration(Duration duration,
      {bool withHours = false, bool withMilliseconds = false}) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds % 60;
    final String milliseconds = withMilliseconds
        ? ',${(duration.inMilliseconds % 1000).toString()[0]}'
        : '';

    String h = withHours && hours > 0
        ? '${hours < 10 ? "$hours" : hours.toString()}:'
        : '';
    String min =
        minutes < 10 && minutes != 0 ? '0$minutes' : minutes.toString();
    String sec = seconds < 10 ? '0$seconds' : seconds.toString();

    return "$h$min:$sec$milliseconds";
  }
}
