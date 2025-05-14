import 'package:clock/clock.dart';
import 'package:super_dates/src/local_date.dart';
import 'package:super_dates/src/local_date_time.dart';
import 'package:test/test.dart';

void main() {
  group('$LocalDate', () {
    group('default constructor', () {
      test('standard date', () async {
        final date = LocalDate(2023, 6, 29);

        expect(date.year, 2023);
        expect(date.month, 6);
        expect(date.day, 29);
      });

      test('max local date', () async {
        final date = LocalDate(275760, 9, 13);

        expect(date.year, 275760);
        expect(date.month, 9);
        expect(date.day, 13);
      });

      test('after max local date', () async {
        expect(() => LocalDate(275760, 9, 14), throwsArgumentError);
      });

      test('min local date', () async {
        final date = LocalDate(-271821, 4, 21);

        expect(date.year, -271821);
        expect(date.month, 4);
        expect(date.day, 21);
      });

      test('before min local date', () async {
        expect(() => LocalDate(-271821, 4, 20), throwsArgumentError);
      });

      test('day overflow date', () async {
        final date = LocalDate(2023, 2, 31);

        expect(date.year, 2023);
        expect(date.month, 3);
        expect(date.day, 3);
      });

      test('day underflow date', () async {
        final date = LocalDate(2023, 2, -1);

        expect(date.year, 2023);
        expect(date.month, 1);
        expect(date.day, 30);
      });

      test('month overflow date', () async {
        final date = LocalDate(2023, 13, 1);

        expect(date.year, 2024);
        expect(date.month, 1);
        expect(date.day, 1);
      });

      test('month underflow date', () async {
        final date = LocalDate(2023, 0, 1);

        expect(date.year, 2022);
        expect(date.month, 12);
        expect(date.day, 1);
      });
    });

    group('fromString constructor', () {
      test('valid local date string', () async {
        expect(LocalDate.fromString('2023-06-29'), LocalDate(2023, 6, 29));
      });

      test('max local date', () async {
        expect(LocalDate.fromString('275760-09-13'), LocalDate(275760, 9, 13));
      });

      test('after max local date', () async {
        expect(() => LocalDate.fromString('275760-09-14'), throwsArgumentError);
      });

      test('7-11-11', () async {
        expect(LocalDate.fromString('7-11-11'), LocalDate(7, 11, 11));
      });

      test('-7-11-11', () async {
        expect(LocalDate.fromString('-7-11-11'), LocalDate(-7, 11, 11));
      });

      test('min local date', () async {
        expect(
          LocalDate.fromString('-271821-04-21'),
          LocalDate(-271821, 4, 21),
        );
      });

      test('before min local date', () async {
        expect(
          () => LocalDate.fromString('-271821-04-20'),
          throwsArgumentError,
        );
      });

      test('invalid local date string (ISO-8601)', () async {
        expect(
          () => LocalDate.fromString('2023-06-29T12:00:00Z'),
          throwsArgumentError,
        );
      });

      test('invalid local date string (human readable)', () async {
        expect(
          () => LocalDate.fromString('29th June 2023'),
          throwsArgumentError,
        );
      });
    });

    test('today constructor', () async {
      withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
        expect(LocalDate.today(), LocalDate(2023, 6, 29));
      });
    });

    test('yesterday constructor', () async {
      withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
        expect(LocalDate.yesterday(), LocalDate(2023, 6, 28));
      });
    });

    test('tomorrow constructor', () async {
      withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
        expect(LocalDate.tomorrow(), LocalDate(2023, 6, 30));
      });
    });

    group('weekday', () {
      test('1970-01-01 - Thursday (EPOCH)', () async {
        expect(LocalDate(1970, 1, 1).weekday, LocalDate.thursday);
      });

      test('2023-02-27 - Monday', () async {
        expect(LocalDate(2023, 2, 27).weekday, LocalDate.monday);
      });

      test('2023-02-28 - Tuesday', () async {
        expect(LocalDate(2023, 2, 28).weekday, LocalDate.tuesday);
      });

      test('2023-03-01 - Wednesday', () async {
        expect(LocalDate(2023, 3, 1).weekday, LocalDate.wednesday);
      });

      test('2023-03-02 - Thursday', () async {
        expect(LocalDate(2023, 3, 2).weekday, LocalDate.thursday);
      });

      test('2023-03-03 - Friday', () async {
        expect(LocalDate(2023, 3, 3).weekday, LocalDate.friday);
      });

      test('2023-03-04 - Saturday', () async {
        expect(LocalDate(2023, 3, 4).weekday, LocalDate.saturday);
      });

      test('2023-03-05 - Sunday', () async {
        expect(LocalDate(2023, 3, 5).weekday, LocalDate.sunday);
      });
    });

    group('isPast', () {
      test('7 days ago', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 22).isPast, true);
        });
      });

      test('yesterday', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 28).isPast, true);
        });
      });

      test('today', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 29).isPast, false);
        });
      });

      test('tomorrow', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 30).isPast, false);
        });
      });

      test('7 days from now', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 7, 6).isPast, false);
        });
      });
    });

    group('isYesterday', () {
      test('2 days ago', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 27).isYesterday, false);
        });
      });

      test('yesterday', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 28).isYesterday, true);
        });
      });

      test('today', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 29).isYesterday, false);
        });
      });
    });

    group('isToday', () {
      test('yesterday', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 28).isToday, false);
        });
      });

      test('today', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 29).isToday, true);
        });
      });

      test('tomorrow', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 30).isToday, false);
        });
      });
    });

    group('isTomorrow', () {
      test('today', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 29).isTomorrow, false);
        });
      });

      test('tomorrow', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 30).isTomorrow, true);
        });
      });

      test('2 days from now', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 7, 1).isTomorrow, false);
        });
      });
    });

    group('isFuture', () {
      test('7 days ago', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 22).isFuture, false);
        });
      });

      test('yesterday', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 28).isFuture, false);
        });
      });

      test('today', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 29).isFuture, false);
        });
      });

      test('tomorrow', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 6, 30).isFuture, true);
        });
      });

      test('7 days from now', () async {
        withClock(Clock.fixed(DateTime(2023, 6, 29)), () {
          expect(LocalDate(2023, 7, 6).isFuture, true);
        });
      });
    });

    group('isLastDayOfMonth', () {
      void expectLastDayOfMonth(int year, int month, int daysInMonth) {
        for (var i = 1; i <= daysInMonth; i++) {
          final date = LocalDate(year, month, i);
          final expected = i == daysInMonth;
          final actual = date.isLastDayOfMonth;

          expect(
            actual,
            expected,
            reason:
                'Expected $date ${expected ? '' : 'not '}to be the last day of the month',
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

    group('differenceInDays()', () {
      test('same day', () async {
        expect(
          LocalDate(2023, 6, 29).differenceInDays(LocalDate(2023, 6, 29)),
          0,
        );
      });

      test('1 day before', () async {
        expect(
          LocalDate(2023, 6, 29).differenceInDays(LocalDate(2023, 6, 28)),
          1,
        );
      });

      test('2 days before (crossing daylight savings boundary)', () async {
        expect(
          LocalDate(2023, 3, 27).differenceInDays(LocalDate(2023, 3, 25)),
          2,
        );
      });

      test('1 day after', () async {
        expect(
          LocalDate(2023, 6, 29).differenceInDays(LocalDate(2023, 6, 30)),
          -1,
        );
      });

      test('2 days after (crossing daylight savings boundary)', () async {
        expect(
          LocalDate(2023, 10, 28).differenceInDays(LocalDate(2023, 10, 30)),
          -2,
        );
      });
    });

    group('addDays()', () {
      test('straightforward', () async {
        expect(LocalDate(2023, 10, 10).addDays(1), LocalDate(2023, 10, 11));
        expect(LocalDate(2023, 10, 10).addDays(3), LocalDate(2023, 10, 13));
      });

      test('crossing month boundary', () async {
        expect(LocalDate(2023, 10, 31).addDays(1), LocalDate(2023, 11, 1));
        expect(LocalDate(2023, 10, 31).addDays(3), LocalDate(2023, 11, 3));
      });

      test('crossing year boundary', () async {
        expect(LocalDate(2023, 12, 31).addDays(1), LocalDate(2024, 1, 1));
        expect(LocalDate(2023, 12, 31).addDays(3), LocalDate(2024, 1, 3));
      });

      test('negative', () async {
        expect(LocalDate(2023, 10, 10).addDays(-1), LocalDate(2023, 10, 9));
        expect(LocalDate(2023, 10, 10).addDays(-3), LocalDate(2023, 10, 7));
      });
    });

    group('subtractDays()', () {
      test('straightforward', () async {
        expect(LocalDate(2023, 10, 10).subtractDays(1), LocalDate(2023, 10, 9));
        expect(LocalDate(2023, 10, 10).subtractDays(3), LocalDate(2023, 10, 7));
      });

      test('crossing month boundary', () async {
        expect(LocalDate(2023, 11, 1).subtractDays(1), LocalDate(2023, 10, 31));
        expect(LocalDate(2023, 11, 3).subtractDays(3), LocalDate(2023, 10, 31));
      });

      test('crossing year boundary', () async {
        expect(LocalDate(2024, 1, 1).subtractDays(1), LocalDate(2023, 12, 31));
        expect(LocalDate(2024, 1, 3).subtractDays(3), LocalDate(2023, 12, 31));
      });

      test('negative', () async {
        expect(LocalDate(2023, 1, 10).subtractDays(-1), LocalDate(2023, 1, 11));
        expect(LocalDate(2023, 1, 10).subtractDays(-3), LocalDate(2023, 1, 13));
      });
    });

    group('addMonths()', () {
      test('straightforward', () async {
        expect(LocalDate(2023, 9, 10).addMonths(1), LocalDate(2023, 10, 10));
        expect(LocalDate(2023, 9, 10).addMonths(3), LocalDate(2023, 12, 10));
      });

      test('crossing year boundary', () async {
        expect(LocalDate(2023, 10, 10).addMonths(3), LocalDate(2024, 1, 10));
        expect(LocalDate(2023, 10, 10).addMonths(15), LocalDate(2025, 1, 10));
      });

      test('negative', () async {
        expect(LocalDate(2023, 10, 10).addMonths(-1), LocalDate(2023, 9, 10));
        expect(LocalDate(2023, 10, 10).addMonths(-3), LocalDate(2023, 7, 10));
      });
    });

    group('subtractMonths()', () {
      test('straightforward', () async {
        expect(LocalDate(2023, 4, 4).subtractMonths(1), LocalDate(2023, 3, 4));
        expect(LocalDate(2023, 4, 4).subtractMonths(3), LocalDate(2023, 1, 4));
      });

      test('crossing year boundary', () async {
        expect(LocalDate(2023, 1, 1).subtractMonths(12), LocalDate(2022, 1, 1));
        expect(LocalDate(2023, 1, 1).subtractMonths(24), LocalDate(2021, 1, 1));
      });

      test('negative', () async {
        expect(LocalDate(2023, 8, 8).subtractMonths(-1), LocalDate(2023, 9, 8));
        expect(LocalDate(2023, 6, 1).subtractMonths(-7), LocalDate(2024, 1, 1));
      });
    });

    group('addYears()', () {
      test('straightforward', () async {
        expect(LocalDate(2023, 1, 1).addYears(1), LocalDate(2024, 1, 1));
        expect(LocalDate(2023, 1, 1).addYears(3), LocalDate(2026, 1, 1));
      });

      test('negative', () async {
        expect(LocalDate(2023, 1, 1).addYears(-1), LocalDate(2022, 1, 1));
        expect(LocalDate(2023, 1, 1).addYears(-3), LocalDate(2020, 1, 1));
      });
    });

    group('subtractYears()', () {
      test('straightforward', () async {
        expect(LocalDate(2023, 1, 1).subtractYears(1), LocalDate(2022, 1, 1));
        expect(LocalDate(2023, 1, 1).subtractYears(3), LocalDate(2020, 1, 1));
      });

      test('negative', () async {
        expect(LocalDate(2023, 1, 1).subtractYears(-1), LocalDate(2024, 1, 1));
        expect(LocalDate(2023, 1, 1).subtractYears(-3), LocalDate(2026, 1, 1));
      });
    });

    group('isBefore()', () {
      test('days', () async {
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 2, 5)), true);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 2, 4)), true);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 2, 3)), false);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 2, 2)), false);
      });

      test('months', () async {
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 4, 4)), true);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 3, 2)), true);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 2, 3)), false);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 1, 2)), false);
      });

      test('years', () async {
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2024, 3, 2)), true);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2024, 2, 3)), true);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2023, 2, 3)), false);
        expect(LocalDate(2023, 2, 3).isBefore(LocalDate(2022, 2, 3)), false);
      });
    });

    group('isAfter()', () {
      test('days', () async {
        expect(LocalDate(2023, 2, 3).isAfter(LocalDate(2023, 2, 4)), false);
        expect(LocalDate(2023, 2, 3).isAfter(LocalDate(2023, 2, 3)), false);
        expect(LocalDate(2023, 2, 3).isAfter(LocalDate(2023, 2, 2)), true);
        expect(LocalDate(2023, 2, 3).isAfter(LocalDate(2023, 2, 1)), true);
      });

      test('months', () async {
        expect(LocalDate(2023, 3, 4).isAfter(LocalDate(2023, 4, 4)), false);
        expect(LocalDate(2023, 3, 4).isAfter(LocalDate(2023, 3, 4)), false);
        expect(LocalDate(2023, 3, 4).isAfter(LocalDate(2023, 2, 4)), true);
        expect(LocalDate(2023, 3, 4).isAfter(LocalDate(2023, 1, 3)), true);
      });

      test('years', () async {
        expect(LocalDate(2023, 2, 3).isAfter(LocalDate(2024, 2, 3)), false);
        expect(LocalDate(2023, 2, 3).isAfter(LocalDate(2023, 2, 3)), false);
        expect(LocalDate(2023, 2, 3).isAfter(LocalDate(2022, 2, 3)), true);
        expect(LocalDate(2023, 2, 3).isAfter(LocalDate(2022, 3, 4)), true);
      });
    });

    group('isSameDayAs()', () {
      test('straightforward', () async {
        expect(LocalDate(2023, 2, 3).isSameDayAs(LocalDate(2023, 2, 2)), false);
        expect(LocalDate(2023, 2, 3).isSameDayAs(LocalDate(2023, 2, 3)), true);
        expect(LocalDate(2023, 2, 3).isSameDayAs(LocalDate(2023, 2, 4)), false);
      });

      test('constructor provided value adjusted dates', () async {
        expect(
          LocalDate(2023, 2, 31).isSameDayAs(LocalDate(2023, 3, 2)),
          false,
        );
        expect(LocalDate(2023, 2, 31).isSameDayAs(LocalDate(2023, 3, 3)), true);
        expect(
          LocalDate(2023, 2, 31).isSameDayAs(LocalDate(2023, 3, 4)),
          false,
        );
      });
    });

    test('compareTo()', () {
      final yesterday = LocalDate(2023, 10, 4);
      final today = LocalDate(2023, 10, 5);
      final tomorrow = LocalDate(2023, 10, 6);

      expect(yesterday.compareTo(yesterday), 0);
      expect(yesterday.compareTo(today), -1);
      expect(yesterday.compareTo(tomorrow), -1);

      expect(today.compareTo(yesterday), 1);
      expect(today.compareTo(today), 0);
      expect(today.compareTo(tomorrow), -1);

      expect(tomorrow.compareTo(yesterday), 1);
      expect(tomorrow.compareTo(today), 1);
      expect(tomorrow.compareTo(tomorrow), 0);
    });

    group('<', () {
      test('days', () async {
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 2, 5), true);
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 2, 4), true);
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 2, 3), false);
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 2, 2), false);
      });

      test('months', () async {
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 4, 4), true);
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 3, 2), true);
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 2, 3), false);
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 1, 2), false);
      });

      test('years', () async {
        expect(LocalDate(2023, 2, 3) < LocalDate(2024, 3, 2), true);
        expect(LocalDate(2023, 2, 3) < LocalDate(2024, 2, 3), true);
        expect(LocalDate(2023, 2, 3) < LocalDate(2023, 2, 3), false);
        expect(LocalDate(2023, 2, 3) < LocalDate(2022, 2, 3), false);
      });
    });

    group('<=', () {
      test('days', () async {
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 2, 5), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 2, 4), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 2, 3), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 2, 2), false);
      });

      test('months', () async {
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 4, 4), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 3, 2), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 2, 3), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 1, 2), false);
      });

      test('years', () async {
        expect(LocalDate(2023, 2, 3) <= LocalDate(2024, 3, 2), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2024, 2, 3), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2023, 2, 3), true);
        expect(LocalDate(2023, 2, 3) <= LocalDate(2022, 2, 3), false);
      });
    });

    group('>', () {
      test('days', () async {
        expect(LocalDate(2023, 2, 3) > LocalDate(2023, 2, 4), false);
        expect(LocalDate(2023, 2, 3) > LocalDate(2023, 2, 3), false);
        expect(LocalDate(2023, 2, 3) > LocalDate(2023, 2, 2), true);
        expect(LocalDate(2023, 2, 3) > LocalDate(2023, 2, 1), true);
      });

      test('months', () async {
        expect(LocalDate(2023, 3, 4) > LocalDate(2023, 4, 4), false);
        expect(LocalDate(2023, 3, 4) > LocalDate(2023, 3, 4), false);
        expect(LocalDate(2023, 3, 4) > LocalDate(2023, 2, 4), true);
        expect(LocalDate(2023, 3, 4) > LocalDate(2023, 1, 3), true);
      });

      test('years', () async {
        expect(LocalDate(2023, 2, 3) > LocalDate(2024, 2, 3), false);
        expect(LocalDate(2023, 2, 3) > LocalDate(2023, 2, 3), false);
        expect(LocalDate(2023, 2, 3) > LocalDate(2022, 2, 3), true);
        expect(LocalDate(2023, 2, 3) > LocalDate(2022, 3, 4), true);
      });
    });

    group('>=', () {
      test('days', () async {
        expect(LocalDate(2023, 2, 3) >= LocalDate(2023, 2, 4), false);
        expect(LocalDate(2023, 2, 3) >= LocalDate(2023, 2, 3), true);
        expect(LocalDate(2023, 2, 3) >= LocalDate(2023, 2, 2), true);
        expect(LocalDate(2023, 2, 3) >= LocalDate(2023, 2, 1), true);
      });

      test('months', () async {
        expect(LocalDate(2023, 3, 4) >= LocalDate(2023, 4, 4), false);
        expect(LocalDate(2023, 3, 4) >= LocalDate(2023, 3, 4), true);
        expect(LocalDate(2023, 3, 4) >= LocalDate(2023, 2, 4), true);
        expect(LocalDate(2023, 3, 4) >= LocalDate(2023, 1, 3), true);
      });

      test('years', () async {
        expect(LocalDate(2023, 2, 3) >= LocalDate(2024, 2, 3), false);
        expect(LocalDate(2023, 2, 3) >= LocalDate(2023, 2, 3), true);
        expect(LocalDate(2023, 2, 3) >= LocalDate(2022, 2, 3), true);
        expect(LocalDate(2023, 2, 3) >= LocalDate(2022, 3, 4), true);
      });
    });

    group('==', () {
      test('straightforward', () async {
        expect(LocalDate(2023, 2, 3) == LocalDate(2023, 2, 2), false);
        expect(LocalDate(2023, 2, 3) == LocalDate(2023, 2, 3), true);
        expect(LocalDate(2023, 2, 3) == LocalDate(2023, 2, 4), false);
      });

      test('constructor provided value adjusted dates', () async {
        expect(LocalDate(2023, 2, 31) == LocalDate(2023, 3, 2), false);
        expect(LocalDate(2023, 2, 31) == LocalDate(2023, 3, 3), true);
        expect(LocalDate(2023, 2, 31) == LocalDate(2023, 3, 4), false);
      });
    });

    group('toString()', () {
      test('2023-10-10', () async {
        expect(LocalDate(2023, 10, 10).toString(), '2023-10-10');
      });

      test('2023-01-01', () async {
        expect(LocalDate(2023, 1, 1).toString(), '2023-01-01');
      });
    });

    group('copyWith()', () {
      test('override all fields', () async {
        final date = LocalDate(2023, 11, 07);
        final copy = date.copyWith(year: 2024, month: 1, day: 1);

        // Check copy has overriden values
        expect(copy, LocalDate(2024, 1, 1));

        // Verify original date is unchanged
        expect(date, LocalDate(2023, 11, 07));
      });

      test('copy w/ no overrides', () async {
        final date = LocalDate(2023, 11, 07);
        final copy = date.copyWith();

        // Check copy has overriden values (same as original since none provided)
        expect(copy, LocalDate(2023, 11, 07));

        // Verify original date is unchanged
        expect(date, LocalDate(2023, 11, 07));
      });
    });

    test('toLocalDateTime()', () async {
      expect(
        LocalDate(2023, 11, 07).toLocalDateTime(),
        LocalDateTime(2023, 11, 07, 0, 0, 0, 0, 0),
      );
    });

    test('toUtcDateTime()', () async {
      final date = LocalDate(2023, 11, 07);
      final actual = date.toUtcDateTime();
      final expected = DateTime(2023, 11, 07).toUtc();

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
        LocalDate(2023, 11, 07).toCoreLocal(),
        DateTime(2023, 11, 07, 0, 0, 0, 0, 0),
      );
    });

    test('toCoreUtc()', () async {
      final date = LocalDate(2023, 11, 07);
      final actual = date.toCoreUtc();
      final expected = DateTime(2023, 11, 07).toUtc();

      expect(actual.year, expected.year);
      expect(actual.month, expected.month);
      expect(actual.day, expected.day);
      expect(actual.hour, expected.hour);
      expect(actual.minute, expected.minute);
      expect(actual.second, expected.second);
      expect(actual.millisecond, expected.millisecond);
      expect(actual.microsecond, expected.microsecond);
    });

    group('fromCoreLocalDateTime()', () {
      test('local', () async {
        expect(
          LocalDate.fromCoreLocalDateTime(
            DateTime(2023, 11, 07, 12, 34, 56, 78, 90),
          ),
          LocalDate(2023, 11, 07),
        );
      });

      test('utc', () async {
        expect(
          () => LocalDate.fromCoreLocalDateTime(
            DateTime(2023, 11, 07, 12, 34, 56, 78, 90).toUtc(),
          ),
          throwsArgumentError,
        );
      });
    });

    group('fromCoreUtcDateTime()', () {
      test('local', () async {
        expect(
          () => LocalDate.fromCoreUtcDateTime(
            DateTime(2023, 11, 07, 12, 34, 56, 78, 90),
          ),
          throwsArgumentError,
        );
      });

      test('utc', () async {
        expect(
          LocalDate.fromCoreUtcDateTime(
            DateTime(2023, 11, 07, 12, 34, 56, 78, 90).toUtc(),
          ),
          LocalDate(2023, 11, 07),
        );
      });
    });

    group('fromCoreDateTime()', () {
      test('local', () async {
        expect(
          LocalDate.fromCoreDateTime(
            DateTime(2023, 11, 07, 12, 34, 56, 78, 90),
          ),
          LocalDate(2023, 11, 07),
        );
      });

      test('utc', () async {
        expect(
          LocalDate.fromCoreDateTime(
            DateTime(2023, 11, 07, 12, 34, 56, 78, 90).toUtc(),
          ),
          LocalDate(2023, 11, 07),
        );
      });
    });
  });
}
