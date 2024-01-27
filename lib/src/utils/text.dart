import 'package:flukit/flukit.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as time;

/// Text utilities extensions on [FluInterface]
extension FluTexts on FluInterface {
  /// Generate DateTime from timestamp || must be integer
  DateTime dateTimeFromTimestamp(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  /// Get only the time from a datetime.
  String timeFromDateTime(
    DateTime date, {
    bool withSeconds = false,
    String? locale,
  }) =>
      formatDate(date, 'HH:mm${withSeconds ? ':ss' : ''}', locale);

  /// Creates a new DateFormat, using the format specified by [pattern].
  String formatDate(
    DateTime date, [
    String pattern = 'EEEE, MMM dd',
    String? locale,
  ]) =>
      DateFormat(pattern, locale).format(date);

  /// Formats provided [DateTime] to a fuzzy time like 'a moment ago'
  String timeago(DateTime dateTime, {String locale = 'en'}) =>
      time.format(dateTime, locale: locale);

  /// A number format for compact representations,
  /// e.g. "1.2M" instead of "1,200,000".
  String numberToCompactFormat(double number) =>
      NumberFormat.compact().format(number);

  /// Get time from seconds || must be integer
  String timeFromSeconds(int seconds) {
    const secondsInOneHour = 3600;
    const secondsInOneMinute = 60;
    String text;

    if (seconds > secondsInOneHour) {
      final hours = seconds / secondsInOneHour;
      final h = hours.toInt();
      final m = int.tryParse(hours.toString().split('.')[1]);

      text = '${h}m ${m != null ? '${m}s' : ''}';
    } else if (seconds > secondsInOneMinute) {
      final minutes = (seconds / secondsInOneHour) * secondsInOneMinute;
      final m = minutes.toInt();
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
    m = (value - h * 3600) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    final hourLeft = h.toString().length < 2 ? '0$h' : h.toString();
    final minuteLeft = m.toString().length < 2 ? '0$m' : m.toString();
    final secondsLeft = s.toString().length < 2 ? '0$s' : s.toString();

    return '$hourLeft : $minuteLeft : $secondsLeft';
  }

  /// Eg `John doe` to `JD`
  String textToAvatarLabel(String text) {
    var label = text;
    final array = label.split(' ');

    if (array.length >= 2) {
      label = array[0][0] + array[array.length - 1][0];
    } else {
      label = text[0];
    }

    return label.toLowerCase();
  }

  /// Duration to formatted string
  String formatDuration(
    Duration duration, {
    bool withHours = false,
    bool withMilliseconds = false,
  }) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    final milliseconds = withMilliseconds
        ? ',${(duration.inMilliseconds % 1000).toString()[0]}'
        : '';

    final h = withHours && hours > 0
        ? '${hours < 10 ? "$hours" : hours.toString()}:'
        : '';
    final min = minutes < 10 && minutes != 0 ? '0$minutes' : minutes.toString();
    final sec = seconds < 10 ? '0$seconds' : seconds.toString();

    return '$h$min:$sec$milliseconds';
  }
}
