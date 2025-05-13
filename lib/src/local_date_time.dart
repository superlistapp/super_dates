import 'package:clock/clock.dart';
import 'package:super_dates/src/local_date.dart';
import 'package:super_dates/src/utc_date_time.dart';

/// A date with a time and timezone component, where the timezone is equal to
/// that of the host system.
///
/// This class exists because Dart's core [DateTime] class can be local or UTC,
/// but not in a typesafe way. This class is always local.
///
/// If you only need a date, consider using [LocalDate] instead.
/// If you want a UTC timestamp, consider using [UtcDateTime] instead.
class LocalDateTime implements Comparable<LocalDateTime> {
  /// Constructs a [LocalDateTime] from a [year], [month], [day], [hour],
  /// [minute], [second], [millisecond] and [microsecond].
  ///
  /// ```dart
  /// final projectDue = LocalDateTime(2023, 8, 24, 18, 0, 0, 0, 0);
  /// final deliveredAt = LocalDateTime(2023, 8, 24, 17, 59, 59, 999, 999);
  /// // Phew... just in time!
  /// ```
  ///
  /// If you only need a date, consider using [LocalDate] instead.
  /// If you want a UTC timestamp, consider using [UtcDateTime] instead.
  LocalDateTime(
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
    _internal = DateTime(
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

  /// Constructs a [LocalDateTime] from a local ISO-8601 string.
  factory LocalDateTime.fromIso8601String(String iso8601) {
    final dateTime = DateTime.tryParse(iso8601);

    if (iso8601.length <= 10 || dateTime == null || dateTime.isUtc) {
      throw ArgumentError.value(
        iso8601,
        'iso8601',
        'Expected local ISO-8601 format',
      );
    }

    return LocalDateTime(
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

  /// Constructs a [LocalDateTime] with the current date and time according to
  /// the host system's clock.
  factory LocalDateTime.now() {
    final now = clock.now();
    return LocalDateTime(
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

  /// Creates a [LocalDateTime] from a "local" [DateTime].
  factory LocalDateTime.fromCoreLocalDateTime(DateTime local) {
    if (local.isUtc) {
      throw ArgumentError.value(local, 'local', 'Expected local DateTime');
    }

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

  /// Creates a [LocalDateTime] from a "UTC" [DateTime].
  factory LocalDateTime.fromCoreUtcDateTime(DateTime utc) {
    if (!utc.isUtc) {
      throw ArgumentError.value(utc, 'utc', 'Expected UTC DateTime');
    }

    return LocalDateTime.fromCoreLocalDateTime(utc.toLocal());
  }

  /// Creates a [LocalDateTime] from an unspecified type of [DateTime].
  factory LocalDateTime.fromCoreDateTime(DateTime dateTime) {
    return dateTime.isUtc
        ? LocalDateTime.fromCoreUtcDateTime(dateTime)
        : LocalDateTime.fromCoreLocalDateTime(dateTime);
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

  /// The internal [DateTime] that this [LocalDateTime] wraps.
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
  bool get isPast => isBefore(LocalDateTime.now());

  /// Returns true if this date-time is in the future (has not yet happened).
  bool get isFuture => isAfter(LocalDateTime.now());

  /// Returns true if this date-time is in the last day of its month.
  bool get isLastDayOfMonth => DateTime(year, month, day + 1).month != month;

  /// Returns the difference between this date-time and [other].
  Duration difference(LocalDateTime other) {
    return _internal.difference(other._internal);
  }

  /// Returns a new [LocalDateTime] with the given [duration] added to this.
  LocalDateTime add(Duration duration) {
    final adjusted = _internal.add(duration);
    return LocalDateTime(
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

  /// Returns a new [LocalDateTime] with the given [duration] subtracted from this.
  LocalDateTime subtract(Duration duration) {
    final adjusted = _internal.subtract(duration);
    return LocalDateTime(
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

  /// Return a new [LocalDateTime] offset by the given number of [days].
  LocalDateTime addDays(int days) {
    return LocalDateTime(
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

  /// Return a new [LocalDateTime] offset by the given number of [days].
  LocalDateTime subtractDays(int days) {
    return addDays(-days);
  }

  /// Return a new [LocalDateTime] offset by the given number of [months].
  LocalDateTime addMonths(int months) {
    return LocalDateTime(
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

  /// Return a new [LocalDateTime] offset by the given number of [months].
  LocalDateTime subtractMonths(int months) {
    return addMonths(-months);
  }

  /// Return a new [LocalDateTime] offset by the given number of [years].
  LocalDateTime addYears(int years) {
    return LocalDateTime(
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

  /// Return a new [LocalDateTime] offset by the given number of [years].
  LocalDateTime subtractYears(int years) {
    return addYears(-years);
  }

  /// Returns true if this date-time happens before [other].
  bool isBefore(LocalDateTime other) {
    return _internal.isBefore(other._internal);
  }

  /// Returns true if this date-time happens after [other].
  bool isAfter(LocalDateTime other) {
    return _internal.isAfter(other._internal);
  }

  /// Returns true if this date-time happens on the same day as [other].
  bool isSameDayAs(LocalDateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Returns true if this date-time happens at the exact same moment as [other].
  bool isSameMomentAs(LocalDateTime other) {
    return _internal.isAtSameMomentAs(other._internal);
  }

  @override
  int compareTo(LocalDateTime other) => _internal.compareTo(other._internal);

  bool operator <(LocalDateTime other) => isBefore(other);

  bool operator <=(LocalDateTime other) =>
      isBefore(other) || isSameMomentAs(other);

  bool operator >(LocalDateTime other) => isAfter(other);

  bool operator >=(LocalDateTime other) =>
      isAfter(other) || isSameMomentAs(other);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocalDateTime && isSameMomentAs(other);
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

  /// Returns a new [LocalDateTime] with optionally overridden values.
  LocalDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return LocalDateTime(
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

  /// Returns a [LocalDate] equivalent of this [LocalDateTime].
  LocalDate toLocalDate() => LocalDate(year, month, day);

  /// Returns a [UtcDateTime] equivalent of this [LocalDateTime].
  UtcDateTime toUtcDateTime() {
    final utc = _internal.toUtc();

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

  /// Returns a "local" [DateTime] equivalent of this [LocalDateTime].
  DateTime toCoreLocal() => _internal;

  /// Returns a "UTC" [DateTime] equivalent of this [LocalDateTime].
  DateTime toCoreUtc() => _internal.toUtc();
}
