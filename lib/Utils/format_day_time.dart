import 'package:intl/intl.dart';

String formatDateTime(DateTime date) {
  // Use intl package to format DateTime
  return DateFormat('dd.MM.yyyy').format(date);
}
