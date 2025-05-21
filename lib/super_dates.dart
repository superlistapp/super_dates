/// SuperDates is a minimal typesafe DateTime API extension for Dart.
///
/// Dart's DateTime is a one-stop-shop for dates and date-times (local and utc-based).
///
/// This project provides a minimal extension to that API, by defining three primatives
/// to split the concerns of dates and date-times (local and utc-based):
///
/// - [LocalDate]     - a date with no time or zone
/// - [LocalDateTime] - a date-time with an implicit timezone (from the system)
/// - [UtcDateTime]   - a date-time with an explicit timezone (UTC)
///
/// The primitives can be created directly from, and conveted back to, core DateTimes.
library;

export 'src/date_time_extensions.dart';
export 'src/local_date.dart';
export 'src/local_date_time.dart';
export 'src/utc_date_time.dart';
