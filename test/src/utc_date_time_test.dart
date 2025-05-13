import 'package:clock/clock.dart';
import 'package:super_dates/src/local_date.dart';
import 'package:super_dates/src/local_date_time.dart';
import 'package:super_dates/src/utc_date_time.dart';
import 'package:test/test.dart';

void main() {
  group('$UtcDateTime', () {
    group('default constructor', () {
      test('standard date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, 34, 56, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('day overflow date-time', () async {
        final date = UtcDateTime(2023, 2, 31, 12, 34, 56, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 3);
        expect(date.day, 3);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('day underflow date-time', () async {
        final date = UtcDateTime(2023, 2, -1, 12, 34, 56, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 1);
        expect(date.day, 30);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('month overflow date-time', () async {
        final date = UtcDateTime(2023, 13, 1, 12, 34, 56, 789, 123);

        expect(date.year, 2024);
        expect(date.month, 1);
        expect(date.day, 1);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('month underflow date-time', () async {
        final date = UtcDateTime(2023, 0, 1, 12, 34, 56, 789, 123);

        expect(date.year, 2022);
        expect(date.month, 12);
        expect(date.day, 1);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('hour overflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 24, 34, 56, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 30);
        expect(date.hour, 0);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('hour underflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, -1, 34, 56, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 28);
        expect(date.hour, 23);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('minute overflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, 60, 56, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 13);
        expect(date.minute, 0);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('minute underflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, -1, 56, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 11);
        expect(date.minute, 59);
        expect(date.second, 56);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('second overflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, 34, 60, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 12);
        expect(date.minute, 35);
        expect(date.second, 0);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('second underflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, 34, -1, 789, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 12);
        expect(date.minute, 33);
        expect(date.second, 59);
        expect(date.millisecond, 789);
        expect(date.microsecond, 123);
      });

      test('millisecond overflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, 34, 56, 1000, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 57);
        expect(date.millisecond, 0);
        expect(date.microsecond, 123);
      });

      test('millisecond underflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, 34, 56, -1, 123);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 55);
        expect(date.millisecond, 999);
        expect(date.microsecond, 123);
      });

      test('microsecond overflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, 34, 56, 789, 1000);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 790);
        expect(date.microsecond, 0);
      });

      test('microsecond underflow date-time', () async {
        final date = UtcDateTime(2023, 6, 29, 12, 34, 56, 789, -1);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
        expect(date.hour, 12);
        expect(date.minute, 34);
        expect(date.second, 56);
        expect(date.millisecond, 788);
        expect(date.microsecond, 999);
      });
    });

    group('fromIso8601String constructor', () {
      test('valid local date time string', () async {
        expect(
          UtcDateTime.fromIso8601String('2023-06-29T12:34:56.000Z'),
          UtcDateTime(2023, 6, 29, 12, 34, 56),
        );
      });

      test('invalid local date time string (local-based ISO-8601)', () async {
        expect(
          () => UtcDateTime.fromIso8601String('2023-06-29T12:00:00'),
          throwsArgumentError,
        );
      });

      test('invalid local date time string (local date)', () async {
        expect(
          () => UtcDateTime.fromIso8601String('2023-06-29'),
          throwsArgumentError,
        );
      });

      test('invalid local date time string (human readable)', () async {
        expect(
          () => UtcDateTime.fromIso8601String('12pm 29th June 2023'),
          throwsArgumentError,
        );
      });
    });

    test('now constructor', () async {
      withClock(
        Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
        () {
          expect(
            UtcDateTime.now(),
            UtcDateTime(2023, 6, 29, 12, 34, 56, 789, 123),
          );
        },
      );
    });

    group('weekday', () {
      test('1970-01-01 - Thursday (EPOCH)', () async {
        expect(
          UtcDateTime(1970, 1, 1, 0, 0, 0, 0, 0).weekday,
          UtcDateTime.thursday,
        );
      });

      test('2023-02-27 - Monday', () async {
        expect(
          UtcDateTime(2023, 2, 27, 12, 34, 56, 789, 123).weekday,
          UtcDateTime.monday,
        );
      });

      test('2023-02-28 - Tuesday', () async {
        expect(
          UtcDateTime(2023, 2, 28, 12, 34, 56, 789, 123).weekday,
          UtcDateTime.tuesday,
        );
      });

      test('2023-03-01 - Wednesday', () async {
        expect(
          UtcDateTime(2023, 3, 1, 12, 34, 56, 789, 123).weekday,
          UtcDateTime.wednesday,
        );
      });

      test('2023-03-02 - Thursday', () async {
        expect(
          UtcDateTime(2023, 3, 2, 12, 34, 56, 789, 123).weekday,
          UtcDateTime.thursday,
        );
      });

      test('2023-03-03 - Friday', () async {
        expect(
          UtcDateTime(2023, 3, 3, 12, 34, 56, 789, 123).weekday,
          UtcDateTime.friday,
        );
      });

      test('2023-03-04 - Saturday', () async {
        expect(
          UtcDateTime(2023, 3, 4, 12, 34, 56, 789, 123).weekday,
          UtcDateTime.saturday,
        );
      });

      test('2023-03-05 - Sunday', () async {
        expect(
          UtcDateTime(2023, 3, 5, 12, 34, 56, 789, 123).weekday,
          UtcDateTime.sunday,
        );
      });
    });

    group('isPast', () {
      test('7 days ago', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 22).isPast, true);
          },
        );
      });

      test('yesterday', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 28).isPast, true);
          },
        );
      });

      test('today before', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 29, 11, 0, 0, 0, 0).isPast, true);
          },
        );
      });

      test('today after', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 29, 13, 0, 0, 0, 0).isPast, false);
          },
        );
      });

      test('tomorrow', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 30).isPast, false);
          },
        );
      });

      test('7 days from now', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 7, 6).isPast, false);
          },
        );
      });
    });

    group('isFuture', () {
      test('7 days ago', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 22).isFuture, false);
          },
        );
      });

      test('yesterday', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 28).isFuture, false);
          },
        );
      });

      test('today before', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 29, 11, 0, 0, 0, 0).isPast, true);
          },
        );
      });

      test('today after', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 29, 13, 0, 0, 0, 0).isPast, false);
          },
        );
      });

      test('tomorrow', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 6, 30).isFuture, true);
          },
        );
      });

      test('7 days from now', () async {
        withClock(
          Clock.fixed(DateTime.utc(2023, 6, 29, 12, 34, 56, 789, 123)),
          () {
            expect(UtcDateTime(2023, 7, 6).isFuture, true);
          },
        );
      });
    });

    group('isLastDayOfMonth', () {
      void expectLastDayOfMonth(int year, int month, int daysInMonth) {
        for (var i = 1; i <= daysInMonth; i++) {
          final dateTime = UtcDateTime(year, month, i, 12, 34, 56, 789, 123);
          final expected = i == daysInMonth;
          final actual = dateTime.isLastDayOfMonth;

          expect(
            actual,
            expected,
            reason:
                'Expected $dateTime ${expected ? '' : 'not '}to be the last day of the month',
          );
        }
      }

      group('2023 - non leap year', () {
        test('January', () => expectLastDayOfMonth(2023, 1, 31));
        test('February', () => expectLastDayOfMonth(2023, 2, 28));
        test('March', () => expectLastDayOfMonth(2023, 3, 31));
        test('April', () => expectLastDayOfMonth(2023, 4, 30));
        test('May', () => expectLastDayOfMonth(2023, 5, 31));
        test('June', () => expectLastDayOfMonth(2023, 6, 30));
        test('July', () => expectLastDayOfMonth(2023, 7, 31));
        test('August', () => expectLastDayOfMonth(2023, 8, 31));
        test('September', () => expectLastDayOfMonth(2023, 9, 30));
        test('October', () => expectLastDayOfMonth(2023, 10, 31));
        test('November', () => expectLastDayOfMonth(2023, 11, 30));
        test('December', () => expectLastDayOfMonth(2023, 12, 31));
      });

      group('2024 - leap year', () {
        test('January', () => expectLastDayOfMonth(2024, 1, 31));
        test('February', () => expectLastDayOfMonth(2024, 2, 29));
        test('March', () => expectLastDayOfMonth(2024, 3, 31));
        test('April', () => expectLastDayOfMonth(2024, 4, 30));
        test('May', () => expectLastDayOfMonth(2024, 5, 31));
        test('June', () => expectLastDayOfMonth(2024, 6, 30));
        test('July', () => expectLastDayOfMonth(2024, 7, 31));
        test('August', () => expectLastDayOfMonth(2024, 8, 31));
        test('September', () => expectLastDayOfMonth(2024, 9, 30));
        test('October', () => expectLastDayOfMonth(2024, 10, 31));
        test('November', () => expectLastDayOfMonth(2024, 11, 30));
        test('December', () => expectLastDayOfMonth(2024, 12, 31));
      });
    });

    group('difference()', () {
      test('microseconds before', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 34, 56, 789, 121)),
          const Duration(microseconds: 2),
        );
      });

      test('microseconds after', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 34, 56, 789, 125)),
          const Duration(microseconds: -2),
        );
      });

      test('milliseconds before', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 34, 56, 787, 123)),
          const Duration(milliseconds: 2),
        );
      });

      test('milliseconds after', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 34, 56, 791, 123)),
          const Duration(milliseconds: -2),
        );
      });

      test('seconds before', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 34, 54, 789, 123)),
          const Duration(seconds: 2),
        );
      });

      test('seconds after', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 34, 58, 789, 123)),
          const Duration(seconds: -2),
        );
      });

      test('minutes before', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 32, 56, 789, 123)),
          const Duration(minutes: 2),
        );
      });

      test('minutes after', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 36, 56, 789, 123)),
          const Duration(minutes: -2),
        );
      });

      test('hours before', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 10, 34, 56, 789, 123)),
          const Duration(hours: 2),
        );
      });

      test('hours after', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 14, 34, 56, 789, 123)),
          const Duration(hours: -2),
        );
      });

      test('days before', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            29,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 27, 12, 34, 56, 789, 123)),
          const Duration(days: 2),
        );
      });

      test('days after', () async {
        expect(
          UtcDateTime(
            2023,
            6,
            27,
            12,
            34,
            56,
            789,
            123,
          ).difference(UtcDateTime(2023, 6, 29, 12, 34, 56, 789, 123)),
          const Duration(days: -2),
        );
      });

      test('days before (crossing daylight savings boundary)', () async {
        expect(
          UtcDateTime(
            2023,
            3,
            27,
            0,
            0,
            0,
            0,
          ).difference(UtcDateTime(2023, 3, 25, 0, 0, 0, 0)),
          const Duration(days: 2), // no daylight savings in UTC
        );
      });

      test('days after (crossing daylight savings boundary)', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            28,
            0,
            0,
            0,
            0,
          ).difference(UtcDateTime(2023, 10, 30, 0, 0, 0, 0)),
          const Duration(days: -2), // no daylight savings in UTC
        );
      });
    });

    group('add()', () {
      test('microseconds', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            123,
          ).add(const Duration(microseconds: 1)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 124),
        );
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            123,
          ).add(const Duration(microseconds: 3)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 126),
        );
      });

      test('milliseconds', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            123,
          ).add(const Duration(milliseconds: 1)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 790, 123),
        );
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            123,
          ).add(const Duration(milliseconds: 3)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 792, 123),
        );
      });

      test('seconds', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            123,
          ).add(const Duration(seconds: 1)),
          UtcDateTime(2023, 10, 10, 12, 34, 57, 789, 123),
        );
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            123,
          ).add(const Duration(seconds: 3)),
          UtcDateTime(2023, 10, 10, 12, 34, 59, 789, 123),
        );
      });

      test('minutes', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            123,
          ).add(const Duration(minutes: 1)),
          UtcDateTime(2023, 10, 10, 12, 35, 56, 789, 123),
        );
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            35,
            56,
            789,
            123,
          ).add(const Duration(minutes: -1)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
      });
    });

    group('subtract()', () {
      test('microseconds', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            124,
          ).subtract(const Duration(microseconds: 1)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            789,
            126,
          ).subtract(const Duration(microseconds: 3)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
      });

      test('milliseconds', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            790,
            123,
          ).subtract(const Duration(milliseconds: 1)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            56,
            792,
            123,
          ).subtract(const Duration(milliseconds: 3)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
      });

      test('seconds', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            57,
            789,
            123,
          ).subtract(const Duration(seconds: 1)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            34,
            59,
            789,
            123,
          ).subtract(const Duration(seconds: 3)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
      });

      test('minutes', () async {
        expect(
          UtcDateTime(
            2023,
            10,
            10,
            12,
            35,
            56,
            789,
            123,
          ).subtract(const Duration(minutes: 1)),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
      });
    });

    group('addDays()', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).addDays(1),
          UtcDateTime(2023, 10, 11, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).addDays(3),
          UtcDateTime(2023, 10, 13, 12, 34, 56, 789, 123),
        );
      });

      test('crossing month boundary', () async {
        expect(
          UtcDateTime(2023, 10, 31, 12, 34, 56, 789, 123).addDays(1),
          UtcDateTime(2023, 11, 1, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 10, 31, 12, 34, 56, 789, 123).addDays(3),
          UtcDateTime(2023, 11, 3, 12, 34, 56, 789, 123),
        );
      });

      test('crossing year boundary', () async {
        expect(
          UtcDateTime(2023, 12, 31, 12, 34, 56, 789, 123).addDays(1),
          UtcDateTime(2024, 1, 1, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 12, 31, 12, 34, 56, 789, 123).addDays(3),
          UtcDateTime(2024, 1, 3, 12, 34, 56, 789, 123),
        );
      });

      test('negative', () async {
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).addDays(-1),
          UtcDateTime(2023, 10, 9, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).addDays(-3),
          UtcDateTime(2023, 10, 7, 12, 34, 56, 789, 123),
        );
      });
    });

    group('subtractDays()', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).subtractDays(1),
          UtcDateTime(2023, 10, 9, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).subtractDays(3),
          UtcDateTime(2023, 10, 7, 12, 34, 56, 789, 123),
        );
      });

      test('crossing month boundary', () async {
        expect(
          UtcDateTime(2023, 11, 1, 12, 34, 56, 789, 123).subtractDays(1),
          UtcDateTime(2023, 10, 31, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 11, 3, 12, 34, 56, 789, 123).subtractDays(3),
          UtcDateTime(2023, 10, 31, 12, 34, 56, 789, 123),
        );
      });

      test('crossing year boundary', () async {
        expect(
          UtcDateTime(2024, 1, 1, 12, 34, 56, 789, 123).subtractDays(1),
          UtcDateTime(2023, 12, 31, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2024, 1, 3, 12, 34, 56, 789, 123).subtractDays(3),
          UtcDateTime(2023, 12, 31, 12, 34, 56, 789, 123),
        );
      });

      test('negative', () async {
        expect(
          UtcDateTime(2023, 1, 10, 12, 34, 56, 789, 123).subtractDays(-1),
          UtcDateTime(2023, 1, 11, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 1, 10, 12, 34, 56, 789, 123).subtractDays(-3),
          UtcDateTime(2023, 1, 13, 12, 34, 56, 789, 123),
        );
      });
    });

    group('addMonths()', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(2023, 9, 10, 12, 34, 56, 789, 123).addMonths(1),
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 9, 10, 12, 34, 56, 789, 123).addMonths(3),
          UtcDateTime(2023, 12, 10, 12, 34, 56, 789, 123),
        );
      });

      test('crossing year boundary', () async {
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).addMonths(3),
          UtcDateTime(2024, 1, 10, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).addMonths(15),
          UtcDateTime(2025, 1, 10, 12, 34, 56, 789, 123),
        );
      });

      test('negative', () async {
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).addMonths(-1),
          UtcDateTime(2023, 9, 10, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).addMonths(-3),
          UtcDateTime(2023, 7, 10, 12, 34, 56, 789, 123),
        );
      });
    });

    group('subtractMonths()', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(2023, 4, 4, 12, 34, 56, 789, 123).subtractMonths(1),
          UtcDateTime(2023, 3, 4, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 4, 4, 12, 34, 56, 789, 123).subtractMonths(3),
          UtcDateTime(2023, 1, 4, 12, 34, 56, 789, 123),
        );
      });

      test('crossing year boundary', () async {
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).subtractMonths(12),
          UtcDateTime(2022, 1, 1, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).subtractMonths(24),
          UtcDateTime(2021, 1, 1, 12, 34, 56, 789, 123),
        );
      });

      test('negative', () async {
        expect(
          UtcDateTime(2023, 8, 8, 12, 34, 56, 789, 123).subtractMonths(-1),
          UtcDateTime(2023, 9, 8, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 6, 1, 12, 34, 56, 789, 123).subtractMonths(-7),
          UtcDateTime(2024, 1, 1, 12, 34, 56, 789, 123),
        );
      });
    });

    group('addYears()', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).addYears(1),
          UtcDateTime(2024, 1, 1, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).addYears(3),
          UtcDateTime(2026, 1, 1, 12, 34, 56, 789, 123),
        );
      });

      test('negative', () async {
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).addYears(-1),
          UtcDateTime(2022, 1, 1, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).addYears(-3),
          UtcDateTime(2020, 1, 1, 12, 34, 56, 789, 123),
        );
      });
    });

    group('subtractYears()', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).subtractYears(1),
          UtcDateTime(2022, 1, 1, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).subtractYears(3),
          UtcDateTime(2020, 1, 1, 12, 34, 56, 789, 123),
        );
      });

      test('negative', () async {
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).subtractYears(-1),
          UtcDateTime(2024, 1, 1, 12, 34, 56, 789, 123),
        );
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).subtractYears(-3),
          UtcDateTime(2026, 1, 1, 12, 34, 56, 789, 123),
        );
      });
    });

    group('isBefore()', () {
      test('years', () async {
        expect(UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2024, 3, 2)), true);
        expect(UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2024, 2, 3)), true);
        expect(
          UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 2, 3)),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2022, 2, 3)),
          false,
        );
      });

      test('months', () async {
        expect(UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 4, 4)), true);
        expect(UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 3, 2)), true);
        expect(
          UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 2, 3)),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 1, 2)),
          false,
        );
      });

      test('days', () async {
        expect(UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 2, 5)), true);
        expect(UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 2, 4)), true);
        expect(
          UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 2, 3)),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3).isBefore(UtcDateTime(2023, 2, 2)),
          false,
        );
      });

      test('hours', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12).isBefore(UtcDateTime(2023, 2, 3, 14)),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12).isBefore(UtcDateTime(2023, 2, 3, 13)),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12).isBefore(UtcDateTime(2023, 2, 3, 12)),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12).isBefore(UtcDateTime(2023, 2, 2, 11)),
          false,
        );
      });

      test('minutes', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 50)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 40)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
          ).isBefore(UtcDateTime(2023, 2, 2, 12, 20)),
          false,
        );
      });

      test('seconds', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 50)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 40)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 30)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
          ).isBefore(UtcDateTime(2023, 2, 2, 12, 30, 20)),
          false,
        );
      });

      test('milliseconds', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 30, 200)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 30, 150)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 30, 100)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
          ).isBefore(UtcDateTime(2023, 2, 2, 12, 30, 30, 50)),
          false,
        );
      });

      test('microseconds', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
            100,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 200)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
            100,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 150)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
            100,
          ).isBefore(UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
            100,
          ).isBefore(UtcDateTime(2023, 2, 2, 12, 30, 30, 100, 50)),
          false,
        );
      });
    });

    group('isAfter()', () {
      test('years', () async {
        expect(UtcDateTime(2023, 2, 3).isAfter(UtcDateTime(2024, 2, 3)), false);
        expect(UtcDateTime(2023, 2, 3).isAfter(UtcDateTime(2023, 2, 3)), false);
        expect(UtcDateTime(2023, 2, 3).isAfter(UtcDateTime(2022, 2, 3)), true);
        expect(UtcDateTime(2023, 2, 3).isAfter(UtcDateTime(2022, 3, 4)), true);
      });

      test('months', () async {
        expect(UtcDateTime(2023, 3, 4).isAfter(UtcDateTime(2023, 4, 4)), false);
        expect(UtcDateTime(2023, 3, 4).isAfter(UtcDateTime(2023, 3, 4)), false);
        expect(UtcDateTime(2023, 3, 4).isAfter(UtcDateTime(2023, 2, 4)), true);
        expect(UtcDateTime(2023, 3, 4).isAfter(UtcDateTime(2023, 1, 3)), true);
      });

      test('days', () async {
        expect(UtcDateTime(2023, 2, 3).isAfter(UtcDateTime(2023, 2, 4)), false);
        expect(UtcDateTime(2023, 2, 3).isAfter(UtcDateTime(2023, 2, 3)), false);
        expect(UtcDateTime(2023, 2, 3).isAfter(UtcDateTime(2023, 2, 2)), true);
        expect(UtcDateTime(2023, 2, 3).isAfter(UtcDateTime(2023, 2, 1)), true);
      });

      test('hours', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12).isAfter(UtcDateTime(2023, 2, 3, 13)),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12).isAfter(UtcDateTime(2023, 2, 3, 12)),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12).isAfter(UtcDateTime(2023, 2, 3, 11)),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12).isAfter(UtcDateTime(2023, 2, 2, 13)),
          true,
        );
      });

      test('minutes', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 40)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 20)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
          ).isAfter(UtcDateTime(2023, 2, 2, 12, 10)),
          true,
        );
      });

      test('seconds', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 40)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 30)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 20)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
          ).isAfter(UtcDateTime(2023, 2, 2, 12, 30, 10)),
          true,
        );
      });

      test('milliseconds', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 30, 150)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 30, 100)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 30, 50)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
          ).isAfter(UtcDateTime(2023, 2, 2, 12, 30, 30, 0)),
          true,
        );
      });

      test('microseconds', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
            100,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 150)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
            100,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
            100,
          ).isAfter(UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 50)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            30,
            30,
            100,
            100,
          ).isAfter(UtcDateTime(2023, 2, 2, 12, 30, 30, 100, 0)),
          true,
        );
      });
    });

    group('isSameDayAs()', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 2, 2, 12, 34, 56, 789, 123)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 2, 3, 10, 21, 32, 456, 567)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 2, 3, 0, 0, 0, 0)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 2, 3)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 2, 4, 12, 34, 56, 789, 123)),
          false,
        );
      });

      test('constructor provided value adjusted date-times', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 3, 2, 12, 34, 56, 789, 123)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 3, 3, 12, 34, 56, 789, 123)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 3, 3, 10, 21, 32, 456, 567)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 3, 3, 0, 0, 0, 0)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 3, 3)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameDayAs(UtcDateTime(2023, 3, 4, 12, 34, 56, 789, 123)),
          false,
        );
      });
    });

    group('isSameMomentAs()', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 2, 2, 12, 34, 56, 789, 123)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 2, 3, 10, 21, 32, 456, 567)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 2, 3, 0, 0, 0, 0)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 2, 3)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            3,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 2, 4, 12, 34, 56, 789, 123)),
          false,
        );
      });

      test('constructor provided value adjusted date-times', () async {
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 3, 2, 12, 34, 56, 789, 123)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 3, 3, 12, 34, 56, 789, 123)),
          true,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 3, 3, 10, 21, 32, 456, 567)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 3, 3, 0, 0, 0, 0)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 3, 3)),
          false,
        );
        expect(
          UtcDateTime(
            2023,
            2,
            31,
            12,
            34,
            56,
            789,
            123,
          ).isSameMomentAs(UtcDateTime(2023, 3, 4, 12, 34, 56, 789, 123)),
          false,
        );
      });
    });

    test('compareTo', () {
      expect(
        UtcDateTime(
          2023,
          2,
          3,
          12,
          34,
          56,
          789,
          123,
        ).compareTo(UtcDateTime(2023, 2, 2, 12, 34, 56, 789, 123)),
        1,
      );
      expect(
        UtcDateTime(
          2023,
          2,
          3,
          12,
          34,
          56,
          789,
          123,
        ).compareTo(UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123)),
        0,
      );
      expect(
        UtcDateTime(
          2023,
          2,
          3,
          12,
          34,
          56,
          789,
          123,
        ).compareTo(UtcDateTime(2023, 2, 3, 10, 21, 32, 456, 567)),
        1,
      );
      expect(
        UtcDateTime(
          2023,
          2,
          3,
          12,
          34,
          56,
          789,
          123,
        ).compareTo(UtcDateTime(2023, 2, 3, 0, 0, 0, 0)),
        1,
      );
      expect(
        UtcDateTime(
          2023,
          2,
          3,
          12,
          34,
          56,
          789,
          123,
        ).compareTo(UtcDateTime(2023, 2, 3)),
        1,
      );
      expect(
        UtcDateTime(
          2023,
          2,
          3,
          12,
          34,
          56,
          789,
          123,
        ).compareTo(UtcDateTime(2023, 2, 4, 12, 34, 56, 789, 123)),
        -1,
      );
    });

    group('<', () {
      test('years', () async {
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2024, 3, 2), true);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2024, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 2, 3), false);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2022, 2, 3), false);
      });

      test('months', () async {
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 4, 4), true);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 3, 2), true);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 2, 3), false);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 1, 2), false);
      });

      test('days', () async {
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 2, 5), true);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 2, 4), true);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 2, 3), false);
        expect(UtcDateTime(2023, 2, 3) < UtcDateTime(2023, 2, 2), false);
      });

      test('hours', () async {
        expect(UtcDateTime(2023, 2, 3, 12) < UtcDateTime(2023, 2, 3, 14), true);
        expect(UtcDateTime(2023, 2, 3, 12) < UtcDateTime(2023, 2, 3, 13), true);
        expect(
          UtcDateTime(2023, 2, 3, 12) < UtcDateTime(2023, 2, 3, 12),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12) < UtcDateTime(2023, 2, 2, 11),
          false,
        );
      });

      test('minutes', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) < UtcDateTime(2023, 2, 3, 12, 50),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) < UtcDateTime(2023, 2, 3, 12, 40),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) < UtcDateTime(2023, 2, 3, 12, 30),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) < UtcDateTime(2023, 2, 2, 12, 20),
          false,
        );
      });

      test('seconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) <
              UtcDateTime(2023, 2, 3, 12, 30, 50),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) <
              UtcDateTime(2023, 2, 3, 12, 30, 40),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) <
              UtcDateTime(2023, 2, 3, 12, 30, 30),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) <
              UtcDateTime(2023, 2, 2, 12, 30, 20),
          false,
        );
      });

      test('milliseconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) <
              UtcDateTime(2023, 2, 3, 12, 30, 30, 200),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) <
              UtcDateTime(2023, 2, 3, 12, 30, 30, 150),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) <
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) <
              UtcDateTime(2023, 2, 2, 12, 30, 30, 50),
          false,
        );
      });

      test('microseconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) <
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 200),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) <
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 150),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) <
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) <
              UtcDateTime(2023, 2, 2, 12, 30, 30, 100, 50),
          false,
        );
      });
    });

    group('<=', () {
      test('days', () async {
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 2, 5), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 2, 4), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 2, 2), false);
      });

      test('months', () async {
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 4, 4), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 3, 2), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 1, 2), false);
      });

      test('years', () async {
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2024, 3, 2), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2024, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2023, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) <= UtcDateTime(2022, 2, 3), false);
      });

      test('hours', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12) <= UtcDateTime(2023, 2, 3, 14),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12) <= UtcDateTime(2023, 2, 3, 13),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12) <= UtcDateTime(2023, 2, 3, 12),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12) <= UtcDateTime(2023, 2, 2, 11),
          false,
        );
      });

      test('minutes', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) <= UtcDateTime(2023, 2, 3, 12, 50),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) <= UtcDateTime(2023, 2, 3, 12, 40),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) <= UtcDateTime(2023, 2, 3, 12, 30),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) <= UtcDateTime(2023, 2, 2, 12, 20),
          false,
        );
      });

      test('seconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) <=
              UtcDateTime(2023, 2, 3, 12, 30, 50),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) <=
              UtcDateTime(2023, 2, 3, 12, 30, 40),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) <=
              UtcDateTime(2023, 2, 3, 12, 30, 30),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) <=
              UtcDateTime(2023, 2, 2, 12, 30, 20),
          false,
        );
      });

      test('milliseconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) <=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 200),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) <=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 150),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) <=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) <=
              UtcDateTime(2023, 2, 2, 12, 30, 30, 50),
          false,
        );
      });

      test('microseconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) <=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 200),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) <=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 150),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) <=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) <=
              UtcDateTime(2023, 2, 2, 12, 30, 30, 100, 50),
          false,
        );
      });
    });

    group('>', () {
      test('days', () async {
        expect(UtcDateTime(2023, 2, 3) > UtcDateTime(2023, 2, 4), false);
        expect(UtcDateTime(2023, 2, 3) > UtcDateTime(2023, 2, 3), false);
        expect(UtcDateTime(2023, 2, 3) > UtcDateTime(2023, 2, 2), true);
        expect(UtcDateTime(2023, 2, 3) > UtcDateTime(2023, 2, 1), true);
      });

      test('months', () async {
        expect(UtcDateTime(2023, 3, 4) > UtcDateTime(2023, 4, 4), false);
        expect(UtcDateTime(2023, 3, 4) > UtcDateTime(2023, 3, 4), false);
        expect(UtcDateTime(2023, 3, 4) > UtcDateTime(2023, 2, 4), true);
        expect(UtcDateTime(2023, 3, 4) > UtcDateTime(2023, 1, 3), true);
      });

      test('years', () async {
        expect(UtcDateTime(2023, 2, 3) > UtcDateTime(2024, 2, 3), false);
        expect(UtcDateTime(2023, 2, 3) > UtcDateTime(2023, 2, 3), false);
        expect(UtcDateTime(2023, 2, 3) > UtcDateTime(2022, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) > UtcDateTime(2022, 3, 4), true);
      });

      test('minutes', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) > UtcDateTime(2023, 2, 3, 12, 40),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) > UtcDateTime(2023, 2, 3, 12, 30),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) > UtcDateTime(2023, 2, 3, 12, 20),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) > UtcDateTime(2023, 2, 2, 12, 10),
          true,
        );
      });

      test('seconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) >
              UtcDateTime(2023, 2, 3, 12, 30, 40),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) >
              UtcDateTime(2023, 2, 3, 12, 30, 30),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) >
              UtcDateTime(2023, 2, 3, 12, 30, 20),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) >
              UtcDateTime(2023, 2, 2, 12, 30, 10),
          true,
        );
      });

      test('milliseconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) >
              UtcDateTime(2023, 2, 3, 12, 30, 30, 150),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) >
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) >
              UtcDateTime(2023, 2, 3, 12, 30, 30, 50),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) >
              UtcDateTime(2023, 2, 2, 12, 30, 30, 0),
          true,
        );
      });

      test('microseconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) >
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 150),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) >
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) >
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 50),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) >
              UtcDateTime(2023, 2, 2, 12, 30, 30, 100, 0),
          true,
        );
      });
    });

    group('>=', () {
      test('days', () async {
        expect(UtcDateTime(2023, 2, 3) >= UtcDateTime(2023, 2, 4), false);
        expect(UtcDateTime(2023, 2, 3) >= UtcDateTime(2023, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) >= UtcDateTime(2023, 2, 2), true);
        expect(UtcDateTime(2023, 2, 3) >= UtcDateTime(2023, 2, 1), true);
      });

      test('months', () async {
        expect(UtcDateTime(2023, 3, 4) >= UtcDateTime(2023, 4, 4), false);
        expect(UtcDateTime(2023, 3, 4) >= UtcDateTime(2023, 3, 4), true);
        expect(UtcDateTime(2023, 3, 4) >= UtcDateTime(2023, 2, 4), true);
        expect(UtcDateTime(2023, 3, 4) >= UtcDateTime(2023, 1, 3), true);
      });

      test('years', () async {
        expect(UtcDateTime(2023, 2, 3) >= UtcDateTime(2024, 2, 3), false);
        expect(UtcDateTime(2023, 2, 3) >= UtcDateTime(2023, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) >= UtcDateTime(2022, 2, 3), true);
        expect(UtcDateTime(2023, 2, 3) >= UtcDateTime(2022, 3, 4), true);
      });

      test('minutes', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) >= UtcDateTime(2023, 2, 3, 12, 40),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) >= UtcDateTime(2023, 2, 3, 12, 30),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) >= UtcDateTime(2023, 2, 3, 12, 20),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30) >= UtcDateTime(2023, 2, 2, 12, 10),
          true,
        );
      });

      test('seconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) >=
              UtcDateTime(2023, 2, 3, 12, 30, 40),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) >=
              UtcDateTime(2023, 2, 3, 12, 30, 30),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) >=
              UtcDateTime(2023, 2, 3, 12, 30, 20),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30) >=
              UtcDateTime(2023, 2, 2, 12, 30, 10),
          true,
        );
      });

      test('milliseconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) >=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 150),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) >=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) >=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 50),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100) >=
              UtcDateTime(2023, 2, 2, 12, 30, 30, 0),
          true,
        );
      });

      test('microseconds', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) >=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 150),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) >=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) >=
              UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 50),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 30, 30, 100, 100) >=
              UtcDateTime(2023, 2, 2, 12, 30, 30, 100, 0),
          true,
        );
      });
    });

    group('==', () {
      test('straightforward', () async {
        expect(
          UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 2, 2, 12, 34, 56, 789, 123),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 2, 3, 10, 21, 32, 456, 567),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 2, 3, 0, 0, 0, 0),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 2, 3),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 3, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 2, 4, 12, 34, 56, 789, 123),
          false,
        );
      });

      test('constructor provided value adjusted date-times', () async {
        expect(
          UtcDateTime(2023, 2, 31, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 3, 2, 12, 34, 56, 789, 123),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 31, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 3, 3, 12, 34, 56, 789, 123),
          true,
        );
        expect(
          UtcDateTime(2023, 2, 31, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 3, 3, 10, 21, 32, 456, 567),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 31, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 3, 3, 0, 0, 0, 0),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 31, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 3, 3),
          false,
        );
        expect(
          UtcDateTime(2023, 2, 31, 12, 34, 56, 789, 123) ==
              UtcDateTime(2023, 3, 4, 12, 34, 56, 789, 123),
          false,
        );
      });
    });

    group('toString()', () {
      test('2023-10-10 12:34:56.789123Z', () async {
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).toString(),
          '2023-10-10 12:34:56.789123Z',
        );
      });

      test('2023-01-01 12:34:56.789123Z', () async {
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).toString(),
          '2023-01-01 12:34:56.789123Z',
        );
      });
    });

    group('toIso8601String()', () {
      test('2023-10-10T12:34:56.789123Z', () async {
        expect(
          UtcDateTime(2023, 10, 10, 12, 34, 56, 789, 123).toIso8601String(),
          '2023-10-10T12:34:56.789123Z',
        );
      });

      test('2023-01-01T12:34:56.789123Z', () async {
        expect(
          UtcDateTime(2023, 1, 1, 12, 34, 56, 789, 123).toIso8601String(),
          '2023-01-01T12:34:56.789123Z',
        );
      });
    });

    group('copyWith()', () {
      test('override all fields', () async {
        final dateTime = UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90);
        final copy = dateTime.copyWith(
          year: 2024,
          month: 1,
          day: 1,
          hour: 1,
          minute: 1,
          second: 1,
          millisecond: 1,
          microsecond: 1,
        );

        // Check copy has overriden values
        expect(copy.year, 2024);
        expect(copy.month, 1);
        expect(copy.day, 1);
        expect(copy.hour, 1);
        expect(copy.minute, 1);
        expect(copy.second, 1);
        expect(copy.millisecond, 1);
        expect(copy.microsecond, 1);

        // Verify original date is unchanged
        expect(dateTime.year, 2023);
        expect(dateTime.month, 11);
        expect(dateTime.day, 07);
        expect(dateTime.hour, 12);
        expect(dateTime.minute, 34);
        expect(dateTime.second, 56);
        expect(dateTime.millisecond, 78);
        expect(dateTime.microsecond, 90);
      });

      test('copy w/ no overrides', () async {
        final dateTime = UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90);
        final copy = dateTime.copyWith();

        // Check copy has overriden values (same as original since none provided)
        expect(copy.year, 2023);
        expect(copy.month, 11);
        expect(copy.day, 07);
        expect(copy.hour, 12);
        expect(copy.minute, 34);
        expect(copy.second, 56);
        expect(copy.millisecond, 78);
        expect(copy.microsecond, 90);

        // Verify original date is unchanged
        expect(dateTime.year, 2023);
        expect(dateTime.month, 11);
        expect(dateTime.day, 07);
        expect(dateTime.hour, 12);
        expect(dateTime.minute, 34);
        expect(dateTime.second, 56);
        expect(dateTime.millisecond, 78);
        expect(dateTime.microsecond, 90);
      });
    });

    test('toLocalDate()', () async {
      expect(
        LocalDateTime(
          2023,
          11,
          07,
          12,
          34,
          56,
          78,
          90,
        ).toUtcDateTime().toLocalDate(),
        LocalDate(2023, 11, 07),
      );
    });

    test('toLocalDateTime()', () async {
      final dateTime = UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90);
      final actual = dateTime.toLocalDateTime();
      final expected = DateTime.utc(2023, 11, 07, 12, 34, 56, 78, 90).toLocal();

      expect(actual.year, expected.year);
      expect(actual.month, expected.month);
      expect(actual.day, expected.day);
      expect(actual.hour, expected.hour);
      expect(actual.minute, expected.minute);
      expect(actual.second, expected.second);
      expect(actual.millisecond, expected.millisecond);
      expect(actual.microsecond, expected.microsecond);
    });

    test('toCoreLocal()', () async {
      expect(
        UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90).toCoreLocal(),
        DateTime.utc(2023, 11, 07, 12, 34, 56, 78, 90).toLocal(),
      );
    });

    test('toCoreUtc()', () async {
      expect(
        UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90).toCoreUtc(),
        DateTime.utc(2023, 11, 07, 12, 34, 56, 78, 90),
      );
    });

    group('fromCoreLocalDateTime()', () {
      test('local', () async {
        expect(
          UtcDateTime.fromCoreLocalDateTime(
            DateTime.utc(2023, 11, 07, 12, 34, 56, 78, 90).toLocal(),
          ),
          UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90),
        );
      });

      test('utc', () async {
        expect(
          () => UtcDateTime.fromCoreLocalDateTime(
            DateTime.utc(2023, 11, 07, 12, 34, 56, 78, 90),
          ),
          throwsArgumentError,
        );
      });
    });

    group('fromCoreUtcDateTime()', () {
      test('local', () async {
        expect(
          () => UtcDateTime.fromCoreUtcDateTime(
            DateTime(2023, 11, 07, 12, 34, 56, 78, 90),
          ),
          throwsArgumentError,
        );
      });

      test('utc', () async {
        expect(
          UtcDateTime.fromCoreUtcDateTime(
            DateTime.utc(2023, 11, 07, 12, 34, 56, 78, 90),
          ),
          UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90),
        );
      });
    });

    group('fromCoreDateTime()', () {
      test('local', () async {
        expect(
          UtcDateTime.fromCoreDateTime(
            DateTime.utc(2023, 11, 07, 12, 34, 56, 78, 90).toLocal(),
          ),
          UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90),
        );
      });

      test('utc', () async {
        expect(
          UtcDateTime.fromCoreDateTime(
            DateTime.utc(2023, 11, 07, 12, 34, 56, 78, 90),
          ),
          UtcDateTime(2023, 11, 07, 12, 34, 56, 78, 90),
        );
      });
    });
  });
}
