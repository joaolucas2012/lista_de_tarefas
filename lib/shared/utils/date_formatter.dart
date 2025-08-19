import 'package:lista_de_tarefas/config/app_config.dart';

class DateFormatter {
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${AppConfig.todayText} ${formatTime(date)}';
    } else if (difference.inDays == 1) {
      return '${AppConfig.yesterdayText} ${formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${AppConfig.daysAgoText} ${difference.inDays} ${AppConfig.daysText}';
    } else {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }

  static String formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String formatTaskDate(DateTime date) {
    return '${AppConfig.createdText} ${formatRelativeDate(date)}';
  }

  static String formatCompletedDate(DateTime date) {
    return '${AppConfig.completedText} ${formatRelativeDate(date)}';
  }
}
