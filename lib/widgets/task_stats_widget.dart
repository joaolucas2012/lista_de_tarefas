import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/config/app_config.dart';

class TaskStatsWidget extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;

  const TaskStatsWidget({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    final pendingTasks = totalTasks - completedTasks;
    final completionPercentage = totalTasks > 0
        ? (completedTasks / totalTasks * 100).round()
        : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.blue[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[200]!, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard(
                context,
                AppConfig.totalLabel,
                totalTasks.toString(),
                Icons.list_alt,
                Colors.blue,
              ),
              _buildStatCard(
                context,
                AppConfig.completedLabel,
                completedTasks.toString(),
                Icons.check_circle,
                Colors.green,
              ),
              _buildStatCard(
                context,
                AppConfig.pendingLabel,
                pendingTasks.toString(),
                Icons.schedule,
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProgressBar(context, completionPercentage),
          const SizedBox(height: 8),
          Text(
            '$completionPercentage${AppConfig.completedPercentage}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.blue[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, int percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppConfig.progressLabel,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue[700],
              ),
            ),
            Text(
              '$percentage%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.blue[100],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
