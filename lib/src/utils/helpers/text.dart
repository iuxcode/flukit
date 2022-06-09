part of '../flu_utils.dart';

extension FlukitText on FlukitInterface {
  /// Generate DateTime from timestamp || must be integer
  DateTime dateTimeFromTimestamp(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  /// Get only the time from a datetime.
  /// using the format specified by [pattern] or not
  String timeFromDateTime(DateTime date, {String pattern = 'HH:mm', String? locale}) => DateFormat(pattern, locale).format(date);

  /// Creates a new DateFormat, using the format specified by [pattern].
  String formatDate(DateTime date, { String pattern =  'EEEE, MMM dd', String? locale}) => DateFormat(pattern, locale).format(date);

  /// Formats provided [date] to a fuzzy time like 'a moment ago'
  String timeago(DateTime dateTime, {String locale = 'En'}) => tmago.format(dateTime,locale: locale,allowFromNow: false);

  /// A number format for compact representations, e.g. "1.2M" instead of "1,200,000".
  String numberToCompactFormat(double number) => NumberFormat.compact().format(number);

  /// Emojis
  /// Todo add type
  get emojis => Emojis;
}