import 'package:clock/clock.dart';
import 'package:super_dates/src/local_date_time.dart';
import 'package:super_dates/src/utc_date_time.dart';

/// A simple date object with no time or timezone to be used in place of Dart's
/// [DateTime] when you only need to represent a date.
///
/// This class exists because [DateTime] is a complex class with a lot of
/// functionality that is not relevant to simple dates, leaving room for
/// confusion and bugs. For example, [DateTime] has a time and timezone,
/// neither of which are relevant to a date. [DateTime] also has lack of
/// type-safety, and it can be hard to tell if a [DateTime] is UTC-based or
/// local, or whether the time part is relevant or not. [LocalDate] has only
/// (and should always have only) a [day], [month] and [year].
///
/// Even though this class exists to prevent using [DateTime] for dates, it
/// still makes use of [DateTime] internally. This is because [DateTime] is
/// well tested and handles a lot of the complexity of dates, such as leap
/// years, days in month, and day of week calculations. The class deliberately
/// has no constructor to which takes in a [DateTime], as well as no methods
/// to convert to a [DateTime]. This is to ensure that we don't make it easy
/// to have [LocalDate]s and [DateTime]s alongside each other, which would
/// defeat the original purpose of this class.
class LocalDate implements Comparable<LocalDate> {
  /// Constructs a [LocalDate] from a [year], [month] and [day].
  ///
  /// ```dart
  /// final moonLanding = LocalDate(1969, 7, 20);
  /// final berlinWallFell = LocalDate(1989, 11, 9);
  /// ```
  ///
  /// If you need information about time of day or timezone, consider using
  /// Dart core's [DateTime].
  LocalDate(int year, int month, int day) {
    // We make use of the `DateTime` constructor for a couple of reasons:
    // 1. It handles overflow e.g. 2021-02-31 => 2021-03-03
    // 2. It means we don't have to write our own "days in month" or
    //    "leap year" logic, etc.
    _internal = DateTime(year, month, day);
  }

  /// Constructs a [LocalDate] from a string in the format 'yyyy-mm-dd'.
  factory LocalDate.fromString(String date) {
    final regex = RegExp(r'^(-?\d+)-(\d{2})-(\d{2})$');
    final match = regex.firstMatch(date);

    if (match == null) {
      throw ArgumentError.value(date, 'date', "Expected format 'yyyy-mm-dd'");
    }

    final year = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final day = int.parse(match.group(3)!);

    return LocalDate(year, month, day);
  }

  /// Constructs a [LocalDate] with today's date according to the host system's
  /// clock.
  factory LocalDate.today() {
    final now = clock.now();
    return LocalDate(now.year, now.month, now.day);
  }

  /// Constructs a [LocalDate] with yesterday's date according to the host
  /// system's clock.
  factory LocalDate.yesterday() {
    return LocalDate.today().subtractDays(1);
  }

  /// Constructs a [LocalDate] with tomorrow's date according to the host
  /// system's clock.
  factory LocalDate.tomorrow() {
    return LocalDate.today().addDays(1);
  }

  /// Creates a [LocalDate] from a "local" [DateTime].
  factory LocalDate.fromCoreLocalDateTime(DateTime local) {
    if (local.isUtc) {
      throw ArgumentError.value(local, 'local', 'Expected local DateTime');
    }

    return LocalDate(local.year, local.month, local.day);
  }

  /// Creates a [LocalDate] from a "UTC" [DateTime].
  factory LocalDate.fromCoreUtcDateTime(DateTime utc) {
    if (!utc.isUtc) {
      throw ArgumentError.value(utc, 'utc', 'Expected UTC DateTime');
    }

    return LocalDate.fromCoreLocalDateTime(utc.toLocal());
  }

  /// Creates a [LocalDate] from an unspecified type of [DateTime].
  factory LocalDate.fromCoreDateTime(DateTime dateTime) {
    return dateTime.isUtc
        ? LocalDate.fromCoreUtcDateTime(dateTime)
        : LocalDate.fromCoreLocalDateTime(dateTime);
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

  /// The internal [DateTime] that this [LocalDate] wraps.
  late final DateTime _internal;

  /// The year part of the local date.
  int get year => _internal.year;

  /// The month part of the local date.
  int get month => _internal.month;

  /// The day part of the local date.
  int get day => _internal.day;

  /// Returns the weekday of this date, where Monday is 1 and Sunday is 7.
  int get weekday => _internal.weekday;

  /// Returns true if this date is in the past (has already happened).
  bool get isPast => isBefore(LocalDate.today());

  /// Returns true if this date is yesterday.
  bool get isYesterday => isSameDayAs(LocalDate.yesterday());

  /// Returns true if this date is today.
  bool get isToday => isSameDayAs(LocalDate.today());

  /// Returns true if this date is tomorrow.
  bool get isTomorrow => isSameDayAs(LocalDate.tomorrow());

  /// Returns true if this date is in the future (has not yet happened).
  bool get isFuture => isAfter(LocalDate.today());

  /// Returns true if this date is in the last day of its month.
  bool get isLastDayOfMonth => DateTime(year, month, day + 1).month != month;

  /// Returns the number of whole days between this date and [other].
  ///
  /// The returned value is negative if [other] is before this date.
  ///
  /// See [Duration.inDays] for more info about "whole days".
  int differenceInDays(LocalDate other) {
    final thisDate = DateTime.utc(year, month, day);
    final otherDate = DateTime.utc(other.year, other.month, other.day);
    // Using UTC dates here ^^^ to avoid issues with daylight savings.
    return thisDate.difference(otherDate).inDays;
  }

  /// Return a new [LocalDate] offset by the given number of [days].
  LocalDate addDays(int days) {
    return LocalDate(year, month, day + days);
  }

  /// Return a new [LocalDate] offset by the given number of [days].
  LocalDate subtractDays(int days) {
    return addDays(-days);
  }

  /// Return a new [LocalDate] offset by the given number of [months].
  LocalDate addMonths(int months) {
    return LocalDate(year, month + months, day);
  }

  /// Return a new [LocalDate] offset by the given number of [months].
  LocalDate subtractMonths(int months) {
    return addMonths(-months);
  }

  /// Return a new [LocalDate] offset by the given number of [years].
  LocalDate addYears(int years) {
    return LocalDate(year + years, month, day);
  }

  /// Return a new [LocalDate] offset by the given number of [years].
  LocalDate subtractYears(int years) {
    return addYears(-years);
  }

  /// Returns true if this date happens before [other].
  bool isBefore(LocalDate other) {
    return _internal.isBefore(other._internal);
  }

  /// Returns true if this date happens after [other].
  bool isAfter(LocalDate other) {
    return _internal.isAfter(other._internal);
  }

  /// Returns true if this date happens on the same day as [other].
  bool isSameDayAs(LocalDate other) {
    return year == other.year && month == other.month && day == other.day;
  }

  @override
  int compareTo(LocalDate other) => _internal.compareTo(other._internal);

  bool operator <(LocalDate other) => isBefore(other);

  bool operator <=(LocalDate other) => isBefore(other) || isSameDayAs(other);

  bool operator >(LocalDate other) => isAfter(other);

  bool operator >=(LocalDate other) => isAfter(other) || isSameDayAs(other);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocalDate && isSameDayAs(other);
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() {
    final yyyy = '$year'.padLeft(4, '0');
    final mm = '$month'.padLeft(2, '0');
    final dd = '$day'.padLeft(2, '0');
    return '$yyyy-$mm-$dd';
  }

  /// Returns a new [LocalDate] with optionally overridden values.
  LocalDate copyWith({int? year, int? month, int? day}) {
    return LocalDate(year ?? this.year, month ?? this.month, day ?? this.day);
  }

  /// Returns a [LocalDateTime] equivalent of this [LocalDate].
  LocalDateTime toLocalDateTime() => LocalDateTime(year, month, day);

  /// Returns a [UtcDateTime] equivalent of this [LocalDate].
  UtcDateTime toUtcDateTime() => toLocalDateTime().toUtcDateTime();

  /// Returns a "local" [DateTime] equivalent of this [LocalDate].
  DateTime toCoreLocal() => DateTime(year, month, day);

  /// Returns a "UTC" [DateTime] equivalent of this [LocalDate].
  DateTime toCoreUtc() => toCoreLocal().toUtc();
}
