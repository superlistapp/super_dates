import 'package:clock/clock.dart';
import 'package:super_dates/src/local_date.dart';
import 'package:super_dates/src/local_date_time.dart';

/// A date with a time and timezone component, where the timezone is equal to
/// UTC.
///
/// This class exists because Dart's core [DateTime] class can be local or UTC,
/// but not in a typesafe way. This class is always UTC.
///
/// If you only need a date, consider using [LocalDate] instead.
/// If you want a local date-time, consider using [LocalDateTime] instead.
class UtcDateTime implements Comparable<UtcDateTime> {
  /// Constructs a [UtcDateTime] from a [year], [month], [day], [hour],
  /// [minute], [second], [millisecond] and [microsecond].
  ///
  /// ```dart
  /// final projectDue = LocalDateTime(2023, 8, 24, 18, 0, 0, 0, 0);
  /// final deliveredAt = LocalDateTime(2023, 8, 24, 17, 59, 59, 999, 999);
  /// // Phew... just in time!
  /// ```
  ///
  /// If you only need a date, consider using [LocalDate] instead.
  /// If you want a local date-time, consider using [LocalDateTime] instead.
  UtcDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) {
    // We make use of the `DateTime` constructor for a couple of reasons:
    // 1. It handles overflow e.g. 2021-02-31 => 2021-03-03
    // 2. It means we don't have to write our own "days in month" or
    //    "leap year" logic, etc.
    _internal = DateTime.utc(
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// Constructs a [UtcDateTime] from a UTC-based ISO-8601 string.
  factory UtcDateTime.fromIso8601String(String iso8601) {
    final dateTime = DateTime.tryParse(iso8601);

    if (iso8601.length <= 10 || dateTime == null || !dateTime.isUtc) {
      throw ArgumentError.value(
        iso8601,
        'iso8601',
        'Expected UTC ISO-8601 format',
      );
    }

    return UtcDateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
    );
  }

  /// Constructs a [UtcDateTime] with the current UTC date-time according to
  /// the host system's clock.
  factory UtcDateTime.now() {
    final now = clock.now().toUtc();
    return UtcDateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
  }

  /// Creates a [UtcDateTime] from a "local" [DateTime].
  factory UtcDateTime.fromCoreLocalDateTime(DateTime local) {
    if (local.isUtc) {
      throw ArgumentError.value(local, 'local', 'Expected local DateTime');
    }

    return UtcDateTime.fromCoreUtcDateTime(local.toUtc());
  }

  /// Creates a [UtcDateTime] from a "UTC" [DateTime].
  factory UtcDateTime.fromCoreUtcDateTime(DateTime utc) {
    if (!utc.isUtc) {
      throw ArgumentError.value(utc, 'utc', 'Expected UTC DateTime');
    }

    return UtcDateTime(
      utc.year,
      utc.month,
      utc.day,
      utc.hour,
      utc.minute,
      utc.second,
      utc.millisecond,
      utc.microsecond,
    );
  }

  /// Creates a [UtcDateTime] from an unspecified type of [DateTime].
  factory UtcDateTime.fromCoreDateTime(DateTime dateTime) {
    return dateTime.isUtc
        ? UtcDateTime.fromCoreUtcDateTime(dateTime)
        : UtcDateTime.fromCoreLocalDateTime(dateTime);
  }

  // Weekday constants
  static const int monday = 1;
  static const int tuesday = 2;
  static const int wednesday = 3;
  static const int thursday = 4;
  static const int friday = 5;
  static const int saturday = 6;
  static const int sunday = 7;
  static const int daysPerWeek = 7;

  // Month constants
  static const int january = 1;
  static const int february = 2;
  static const int march = 3;
  static const int april = 4;
  static const int may = 5;
  static const int june = 6;
  static const int july = 7;
  static const int august = 8;
  static const int september = 9;
  static const int october = 10;
  static const int november = 11;
  static const int december = 12;
  static const int monthsPerYear = 12;

  /// The internal [DateTime] that this [UtcDateTime] wraps.
  late final DateTime _internal;

  /// The year part of the local date-time.
  int get year => _internal.year;

  /// The month part of the local date-time.
  int get month => _internal.month;

  /// The day part of the local date-time.
  int get day => _internal.day;

  /// The hour part of the local date-time.
  int get hour => _internal.hour;

  /// The minute part of the local date-time.
  int get minute => _internal.minute;

  /// The second part of the local date-time.
  int get second => _internal.second;

  /// The millisecond part of the local date-time.
  int get millisecond => _internal.millisecond;

  /// The microsecond part of the local date-time.
  int get microsecond => _internal.microsecond;

  /// Returns the weekday of this date-time, where Monday is 1 and Sunday is 7.
  int get weekday => _internal.weekday;

  /// Returns true if this date-time is in the past (has already happened).
  bool get isPast => isBefore(UtcDateTime.now());

  /// Returns true if this date-time is in the future (has not yet happened).
  bool get isFuture => isAfter(UtcDateTime.now());

  /// Returns true if this date-time is in the last day of its month.
  bool get isLastDayOfMonth {
    return DateTime.utc(year, month, day + 1).month != month;
  }

  /// Returns the difference between this date-time and [other].
  Duration difference(UtcDateTime other) {
    return _internal.difference(other._internal);
  }

  /// Returns a new [UtcDateTime] with the given [duration] added to this.
  UtcDateTime add(Duration duration) {
    final adjusted = _internal.add(duration);
    return UtcDateTime(
      adjusted.year,
      adjusted.month,
      adjusted.day,
      adjusted.hour,
      adjusted.minute,
      adjusted.second,
      adjusted.millisecond,
      adjusted.microsecond,
    );
  }

  /// Returns a new [UtcDateTime] with the given [duration] subtracted from this.
  UtcDateTime subtract(Duration duration) {
    final adjusted = _internal.subtract(duration);
    return UtcDateTime(
      adjusted.year,
      adjusted.month,
      adjusted.day,
      adjusted.hour,
      adjusted.minute,
      adjusted.second,
      adjusted.millisecond,
      adjusted.microsecond,
    );
  }

  /// Return a new [UtcDateTime] offset by the given number of [days].
  UtcDateTime addDays(int days) {
    return UtcDateTime(
      year,
      month,
      day + days,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// Return a new [UtcDateTime] offset by the given number of [days].
  UtcDateTime subtractDays(int days) {
    return addDays(-days);
  }

  /// Return a new [UtcDateTime] offset by the given number of [months].
  UtcDateTime addMonths(int months) {
    return UtcDateTime(
      year,
      month + months,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// Return a new [UtcDateTime] offset by the given number of [months].
  UtcDateTime subtractMonths(int months) {
    return addMonths(-months);
  }

  /// Return a new [UtcDateTime] offset by the given number of [years].
  UtcDateTime addYears(int years) {
    return UtcDateTime(
      year + years,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// Return a new [UtcDateTime] offset by the given number of [years].
  UtcDateTime subtractYears(int years) {
    return addYears(-years);
  }

  /// Returns true if this date-time happens before [other].
  bool isBefore(UtcDateTime other) {
    return _internal.isBefore(other._internal);
  }

  /// Returns true if this date-time happens after [other].
  bool isAfter(UtcDateTime other) {
    return _internal.isAfter(other._internal);
  }

  /// Returns true if this date-time happens on the same day as [other].
  bool isSameDayAs(UtcDateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Returns true if this date-time happens at the exact same moment as [other].
  bool isSameMomentAs(UtcDateTime other) {
    return _internal.isAtSameMomentAs(other._internal);
  }

  @override
  int compareTo(UtcDateTime other) => _internal.compareTo(other._internal);

  bool operator <(UtcDateTime other) => isBefore(other);

  bool operator <=(UtcDateTime other) =>
      isBefore(other) || isSameMomentAs(other);

  bool operator >(UtcDateTime other) => isAfter(other);

  bool operator >=(UtcDateTime other) =>
      isAfter(other) || isSameMomentAs(other);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UtcDateTime && isSameMomentAs(other);
  }

  @override
  int get hashCode => Object.hash(
    year,
    month,
    day,
    hour,
    minute,
    second,
    millisecond,
    microsecond,
  );

  @override
  String toString() {
    return _internal.toString();
  }

  /// Returns an ISO-8601 full-precision extended format representation.
  String toIso8601String() {
    return _internal.toIso8601String();
  }

  /// Returns a new [UtcDateTime] with optionally overridden values.
  UtcDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return UtcDateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  /// Returns a [LocalDate] equivalent of this [UtcDateTime].
  LocalDate toLocalDate() => toLocalDateTime().toLocalDate();

  /// Returns a [LocalDateTime] equivalent of this [UtcDateTime].
  LocalDateTime toLocalDateTime() {
    final local = _internal.toLocal();

    return LocalDateTime(
      local.year,
      local.month,
      local.day,
      local.hour,
      local.minute,
      local.second,
      local.millisecond,
      local.microsecond,
    );
  }

  /// Returns a "local" [DateTime] equivalent of this [UtcDateTime].
  DateTime toCoreLocal() => _internal.toLocal();

  /// Returns a "UTC" [DateTime] equivalent of this [UtcDateTime].
  DateTime toCoreUtc() => _internal;
}
