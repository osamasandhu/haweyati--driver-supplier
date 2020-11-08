import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';

String timeAgoSinceDate(DateTime date,AppLocalizations lang, {bool numericDates = true}) {
  final date2 = DateTime.now();
  final difference = date2.difference(date);

  if ((difference.inDays / 365).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} ${lang.yearsAgo}';
  } else if ((difference.inDays / 365).floor() >= 1) {
    return (numericDates) ? lang.oneYearAgo : lang.lastYear;
  } else if ((difference.inDays / 30).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} ${lang.monthsAgo}';
  } else if ((difference.inDays / 30).floor() >= 1) {
    return (numericDates) ? '${lang.oneMonthAgo}' : '${lang.lastMonth}';
  } else if ((difference.inDays / 7).floor() >= 2) {
    return '${(difference.inDays / 7).floor()} ${lang.weeksAgo}';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '${lang.oneWeekAgo}' : '${lang.lastWeek}';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} ${lang.daysAgo}';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? lang.oneDayAgo : lang.yesterday;
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} ${lang.hoursAgo}';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '${lang.oneHourAgo}' : '${lang.anHourAgo}';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} ${lang.minutesAgo}';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '${lang.oneMinuteAgo}' : lang.aMinuteAgo;
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} ${lang.secondsAgo}';
  } else {
    return lang.justNow;
  }
}
