// ignore_for_file: argument_type_not_assignable
// ignore_for_file: unused_element

import 'package:super_dates/super_dates.dart';

void main() {
  /// WHY ?

  // Three different temporal types for three different needs:
  LocalDate(2025, 5, 21); // Just a date (no time, no timezone drama)
  LocalDateTime(2025, 5, 21, 9, 0); // User-facing timestamp (system timezone)
  UtcDateTime(2025, 5, 21, 9, 0); // Server/collaboration timestamp (UTC)

  // Dart's DateTime mixes Dates, DateTimes, and UTC DateTimes together:
  void logEvent(DateTime dateTime) {
    // Is dateTime local or UTC? We need to check for `.isUtc`, then convert
    // to UTC if the DateTime is local, because UTC is what we want here.
  }
  DateTime(2025, 5, 21); // Is this a date or a date-time?
  DateTime.parse('2025-05-21'); // Is this a date or a date-time?

  // Your code defines what kind of datetimes are expected
  void scheduleReminder(LocalDateTime reminderTime) {}
  void logEventToServer(UtcDateTime timestamp) {}
  void displayToUser(LocalDate userDate) {}

  // Types are validated at compile-time
  scheduleReminder(LocalDate(2025, 6, 15)); // ❌ Compile error!
  logEventToServer(LocalDateTime.now()); // ❌ Compile error!
  displayToUser(UtcDateTime.now()); // ❌ Compile error!

  /// QUICK START

  // Pure dates for birthdays, deadlines, holidays
  final birthday = LocalDate(2025, 12, 25);
  print(birthday); // 2025-12-25

  // Local times for user-facing timestamps
  final appointment = LocalDateTime(2025, 12, 25, 10, 30);
  print(appointment); // 2025-12-25 10:30:00.000

  // UTC times for server logs, API timestamps
  final logEntry = UtcDateTime.now();
  print(logEntry.toIso8601String()); // 2025-05-28T14:30:00.000Z
}
