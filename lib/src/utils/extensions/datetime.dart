import 'package:flukit/src/utils/flu_utils.dart';

extension FluDateTime on DateTime {
  /// Generate DateTime from timestamp || must be integer
  DateTime fromTimestamp(int timestamp) => Flu.dateTimeFromTimestamp(timestamp);

  /// Creates a new DateFormat, using the format specified by [pattern].
  String format({String pattern = 'EEEE, MMM dd', String? locale}) =>
      Flu.formatDate(
        this,
        pattern: pattern,
        locale: locale,
      );

  /// Get only the time from a datetime.
  String time({bool withSeconds = false, String? locale}) =>
      Flu.timeFromDateTime(this);

  /// Formats provided [date] to a fuzzy time like 'a moment ago'
  String timeago({String locale = 'en'}) => Flu.timeago(this, locale: locale);
}
