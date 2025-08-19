import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../config/app_config.dart';

abstract class ITaskService {
  Future<List<Task>> getAllTasks();
  Future<void> addTask(String title);
  Future<void> toggleTaskCompletion(String taskId);
  Future<void> deleteTask(String taskId);
  Future<void> updateTask(Task task);
  List<Task> sortTasks(List<Task> tasks);
}

class TaskService implements ITaskService {
  final ITaskRepository _repository;

  TaskService({ITaskRepository? repository})
    : _repository = repository ?? TaskRepository();

  @override
  Future<List<Task>> getAllTasks() async {
    return await _repository.getAllTasks();
  }

  @override
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) {
      throw ArgumentError(AppConfig.emptyTaskError);
    }

    final task = Task(
      id: _generateId(),
      title: title.trim(),
      createdAt: DateTime.now(),
    );

    await _repository.addTask(task);
  }

  @override
  Future<void> toggleTaskCompletion(String taskId) async {
    final tasks = await _repository.getAllTasks();
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);

    if (taskIndex != -1) {
      final updatedTask = tasks[taskIndex].toggleCompletion();
      await _repository.updateTask(updatedTask);
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _repository.deleteTask(taskId);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
  }

  @override
  List<Task> sortTasks(List<Task> tasks) {
    final sortedTasks = List<Task>.from(tasks);
    sortedTasks.sort((a, b) {
      // Primeiro, ordena por status (não completadas primeiro)
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      // Depois, ordena por data de criação (mais recentes primeiro)
      return b.createdAt.compareTo(a.createdAt);
    });
    return sortedTasks;
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
