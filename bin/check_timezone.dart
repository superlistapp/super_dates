void main() {
  final now = DateTime.now();
  print('timezone: "${now.timeZoneName}"');
  print('offset: ${now.timeZoneOffset}');
}
