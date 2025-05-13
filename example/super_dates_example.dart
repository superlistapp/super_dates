import 'package:super_dates/super_dates.dart';

void main() {
  final date = LocalDate(2023, 6, 29);
  print(date);

  final dateTime = LocalDateTime(2023, 6, 29, 12, 34, 56, 789, 123);
  print(dateTime);

  final utcDateTime = UtcDateTime(2023, 6, 29, 12, 34, 56, 789, 123);
  print(utcDateTime);
}
