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

  /// Replace all emojis in text with [Joypixels] emojis.
  TextSpan replaceEmojis(TextSpan? span) {
    final children = <TextSpan>[];
    final runes = span?.text?.runes;

    if (runes != null) {
      for (int i = 0; i < runes.length; /* empty */) {
        int current = runes.elementAt(i);

        // we assume that everything that is not
        // in Extended-ASCII set is an emoji...
        final isEmoji = current > 255;
        final shouldBreak = isEmoji ? (x) => x <= 255 : (x) => x > 255;

        final chunk = <int>[];
        while (!shouldBreak(current)) {
          chunk.add(current);
          if (++i >= runes.length) break;
          current = runes.elementAt(i);
        }

        children.add(
          TextSpan(
            text: String.fromCharCodes(chunk),
            recognizer: span?.recognizer,
            style: span?.style?.copyWith(
              fontFamily: isEmoji
                  ? (Flukit.appSettings.emojiFont ?? Flukit.fonts.emoji)
                  : null,
              package: isEmoji ? 'flukit' : null,
            ),
          ),
        );
      }
    }

    return TextSpan(children: children);
  }

  /// Return fonts interface
  FluFonts get fonts => FluFonts();
}

class FluFonts {
  String get neptune => 'neptune';
  String get emoji => 'joypixels';
}
