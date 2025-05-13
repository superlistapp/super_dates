import 'package:super_dates/src/local_date.dart';
import 'package:super_dates/src/local_date_time.dart';
import 'package:super_dates/src/utc_date_time.dart';

extension DateTimeExtensions on DateTime {
  /// Creates a [LocalDate] from this [DateTime].
  LocalDate toLocalDate() => LocalDate.fromCoreDateTime(this);

  /// Creates a [LocalDateTime] from this [DateTime].
  LocalDateTime toLocalDateTime() => LocalDateTime.fromCoreDateTime(this);

  /// Creates a [UtcDateTime] from this [DateTime].
  UtcDateTime toUtcDateTime() => UtcDateTime.fromCoreDateTime(this);
}
