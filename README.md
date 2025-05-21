# SuperDates ⏱️

> A minimal typesafe DateTime API extension for Dart.

## Why?

Dates and date-times are different things, and mixing them leads to bugs. This package provides a type-safe way to handle:
- Pure dates (year, month, day)
- Local date-times (with system timezone)
- UTC date-times (with explicit timezone)

## Features

- Type-safe date handling
- Clear separation between dates and date-times
- Explicit UTC vs Local time handling
- Easy conversion between types
- Integration with Dart's core DateTime

## Usage Examples

```dart
  // Pure Dates
  final localDate = LocalDate(2025, 5, 21);
  print(localDate.toString()); // 2025-05-21
  print(localDate == LocalDate(2025, 5, 21)); // true
  LocalDate(2025, 5, 21, 12); // compile error
  LocalDate(2025, 5, 21).toIso8601String(); // compile error
  LocalDate(2025, 5, 21).hour; // compile error
  LocalDate.fromString('2025-05-21'); // works
  LocalDate.fromIso8601String('2025-05-21T12:34:56.789Z'); // compile error
  LocalDate.fromString('2025-05-21 12:34:56.789'); // runtime error
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
  LocalDateTime.fromIso8601String('2025-05-21T12:34:56.789Z'); // runtime error

  // DateTimes based on UTC
  final utcDateTime = UtcDateTime(2025, 5, 21, 12, 34, 56, 789, 123);
  print(utcDateTime.toIso8601String()); // 2025-05-21T12:34:56.789123Z
  print(utcDateTime == UtcDateTime(2025, 5, 21, 12, 34, 56, 789, 123)); // true
  UtcDateTime.fromIso8601String('2025-05-21T12:34:56.789Z'); // works
  UtcDateTime.fromIso8601String('2025-05-21 12:34:56.789'); // runtime error
```

## Motivation
Dates and date-times are different things. 

When you're working with a date, it should contain nothing more than a year, a month, and a day. Done. As soon as there is any time component, or worse yet a timezeone, whether explicit or implicit, you have sowned the seeds of your own demise. You will hate yourself later for having to debug a timezone issue for a date field. Trust me. I have that t-shirt!

Within date-times, there are further sub-divisions you can make. Date-times based in the local timezone are useful for user facing timestamps, while utc-based date-times are useful when people with different timezones need to collaborate.

Dart's core DateTime wants to us entangle all of these concerns in a single object. This leads to inconsistancies and bugs.

This work is heavily inspired by Stephen Colebourne's great work on [Joda Time](https://github.com/JodaOrg/joda-time).
