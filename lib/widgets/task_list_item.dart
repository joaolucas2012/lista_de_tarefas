import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/date_formatter.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.startToEnd,
      background: _buildDismissBackground(),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: CheckboxListTile(
            value: task.isCompleted,
            onChanged: (_) => onToggle(),
            activeColor: Colors.blue,
            checkColor: Colors.white,
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: task.isCompleted ? Colors.grey[600] : Colors.black87,
                fontSize: 16,
                fontWeight: task.isCompleted
                    ? FontWeight.normal
                    : FontWeight.w500,
              ),
            ),
            subtitle: _buildSubtitle(),
            secondary: _buildStatusIcon(),
            tileColor: task.isCompleted ? Colors.grey[50] : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.delete, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    return CircleAvatar(
      backgroundColor: task.isCompleted ? Colors.green : Colors.orange,
      radius: 20,
      child: Icon(
        task.isCompleted ? Icons.check : Icons.schedule,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildSubtitle() {
    final createdAt = task.createdAt;
    final completedAt = task.completedAt;

    String subtitle = DateFormatter.formatTaskDate(createdAt);

    if (task.isCompleted && completedAt != null) {
      subtitle += '\n${DateFormatter.formatCompletedDate(completedAt)}';
    }

    return Text(
      subtitle,
      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
    );
  }
}
