# SuperDates ⏱️

**Stop time/timezone bugs before they happen**. SuperDates has three different temporal types for three different needs:

```dart
LocalDate(2025, 5, 21);            // Just a date (no time, no timezone drama)
LocalDateTime(2025, 5, 21, 9, 0);  // User-facing timestamp (system timezone)
UtcDateTime(2025, 5, 21, 9, 0);    // Server/collaboration timestamp (UTC)
```

## The Problem

Dart's DateTime mixes Dates, DateTimes, and UTC DateTimes together.

```dart
void logEvent(DateTime dateTime) {
  // Is dateTime local or UTC? We need to check for `.isUtc`, then convert
  // to UTC if the DateTime is local, because UTC is what we want here.
}

DateTime(2025, 5, 21)        // Is this a date or a date-time?
DateTime.parse('2025-05-21') // Is this a date or a date-time?
```

## How types save your as... assets

SuperDates introduces type-safe temporal types that are validated by the compiler at compile-time.

```dart
// Your code defines what kind of datetimes are expected
void scheduleReminder(LocalDateTime reminderTime) { ... }
void logEventToServer(UtcDateTime timestamp) { ... }
void displayToUser(LocalDate userDate) { ... }

// Types are validated at compile-time
scheduleReminder(LocalDate(2025, 6, 15));  // ❌ Compile error!
logEventToServer(LocalDateTime.now());     // ❌ Compile error!
displayToUser(UtcDateTime.now());          // ❌ Compile error!
```

## Quick Start

```yaml
dependencies:
  super_dates: ^1.0.0
```

```dart
import 'package:super_dates/super_dates.dart';

// Pure dates for birthdays, deadlines, holidays
final birthday = LocalDate(2025, 12, 25);
print(birthday); // 2025-12-25

// Local times for user-facing timestamps  
final appointment = LocalDateTime(2025, 12, 25, 10, 30);
print(appointment); // 2025-12-25 10:30:00.000

// UTC times for server logs, API timestamps
final logEntry = UtcDateTime.now();
print(logEntry.toIso8601String()); // 2025-05-28T14:30:00.000Z
```

## Features

- Type-safe date and date-time handling
- Clear separation between dates and date-times
- Explicit UTC vs Local time handling
- Easy conversion between types
- Integration with Dart's core DateTime

## Motivation
Dates and date-times are different things. 

When you're working with a date, it should contain nothing more than a year, a month, and a day. Done. As soon as there is any time component, or worse yet a timezeone, whether explicit or implicit, you have sowned the seeds of your own demise. You will hate yourself later for having to debug a timezone issue for a date field. Trust me. I have that t-shirt!

Within date-times, there are further sub-divisions you can make. Date-times based in the local timezone are useful for user facing timestamps, while utc-based date-times are useful when people with different timezones need to collaborate.

Dart's core DateTime wants to us entangle all of these concerns in a single object. This leads to inconsistancies and bugs.

This work is heavily inspired by Stephen Colebourne's great work on [Joda Time](https://github.com/JodaOrg/joda-time).
