import 'package:super_dates/super_dates.dart';

void main() {
  // Pure Dates
  final localDate = LocalDate(2025, 5, 21);
  print(localDate.toString()); // 2025-05-21
  print(localDate == LocalDate(2025, 5, 21)); // true
  // LocalDate(2025, 5, 21, 12); // compile error
  // LocalDate(2025, 5, 21).toIso8601String(); // compile error
  // LocalDate(2025, 5, 21).hour; // compile error
  LocalDate.fromString('2025-05-21'); // works
  // LocalDate.fromIso8601String('2025-05-21T12:34:56.789Z'); // compile error
  // LocalDate.fromString('2025-05-21 12:34:56.789'); // runtime error
  print(localDate.toLocalDateTime().runtimeType); // LocalDateTime
  print(localDate.toUtcDateTime().runtimeType); // UtcDateTime
  print(localDate.toCoreLocal().runtimeType); // DateTime
  print(localDate.toCoreUtc().runtimeType); // DateTime

  // DateTimes based on the local timezone
  final localDateTime = LocalDateTime(2025, 5, 21, 12, 34, 56, 789, 123);
  print(localDateTime.toString()); // 2025-05-21 12:34:56.789123
  print(
    localDateTime == LocalDateTime(2025, 5, 21, 12, 34, 56, 789, 123),
  ); // true
  LocalDateTime.fromIso8601String('2025-05-21 12:34:56.789'); // works
  // LocalDateTime.fromIso8601String('2025-05-21T12:34:56.789Z'); // runtime error

  // DateTimes based on UTC
  final utcDateTime = UtcDateTime(2025, 5, 21, 12, 34, 56, 789, 123);
  print(utcDateTime.toIso8601String()); // 2025-05-21T12:34:56.789123Z
  print(utcDateTime == UtcDateTime(2025, 5, 21, 12, 34, 56, 789, 123)); // true
  UtcDateTime.fromIso8601String('2025-05-21T12:34:56.789Z'); // works
  // UtcDateTime.fromIso8601String('2025-05-21 12:34:56.789'); // runtime error
}
